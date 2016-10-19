'''
==============================================================================
===========================INSTRUCTION SET====================================
==============================================================================

***********************
**R-Type Instructions**
***********************
  31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
 | 0| 0| A| B| 1| 1|   COND    | S|    RS     |    RT     |    RD     |     OPX      | X| X| X| X|

 | A| B|  OPX | INSTRUCTION      | ACTION                               |
 |--|--|------|------------------|--------------------------------------|
 | 0| 0| 00010| add $rd $rs $rt  | $rd <= $rs + $rt                     |
 | 0| 0| 00000| sub $rd $rs $rt  | $rd <= $rs - $rt                     |
 | 0| 0| 00110| and $rd $rs $rt  | $rd <= $rs & $rt                     |
 | 0| 0| 00101| or  $rd $rs $rt  | $rd <= $rs | $rt                     |
 | 0| 0| 00100| xor $rd $rs $rt  | $rd <= $rs ^ $rt                     |
 | 0| 0| 00001| sll $rd $rs $rt  | $rd <= $rs << $rt                    |
 | 0| 0| 01001| mul $rd $rs $rt  | $rd <= $rs[15:0] * $rt[15:0]         |
 | 1| 0| 00000| jr  $rs          | $pc <= $rs                           |
 | 1| 0| 00011| ret              | $pc <= $15                           |
 | 0| 1| 00000| spush $rd        | MEM[$r14-4] <= $rd; $r14 <= $r14 - 4 |
 | 1| 1| 00000| spop  $rd        | $rd <= MEM[$r14]; $r14 <= $r14 + 4   |

***********************
**D-Type Instructions**
***********************
  31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
 | 0| S| A| B| 1| 0|   RS      | S|    RT     | X|         IMMEDIATE                             |

 | S| A| B| INSTRUCTION        | ACTION                 |
 |--|--|--|--------------------|------------------------|
 | 0| 0| 0| ldw   $rt $rs imm  | $rt <= MEM[$rs+imm]    |
 | 0| 0| 1| stw   $rt $rs imm  | MEM[$rs+imm] <= $rt    |
 | 0| 1| 0| addil $rt $rs imm  | $rt <= $rs + imm       |
 | 0| 1| 1| addih $rt $rs imm  | $rt <= $rs + (imm<<16) |
 | 1| 0| 0| oril  $rt $rs imm  | $rt <= $rs | imm       |
 | 1| 0| 1| orih  $rt $rs imm  | $rt <= $rs | (imm<<16) |
 | 1| 1| 0| andil $rt $rs imm  | $rt <= $rs & imm       |
 | 1| 1| 1| andih $rt $rs imm  | $rt <= $rs & (imm<<16) |

***********************
**B-Type Instructions**
***********************
  31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
 | 0| 0| A| B| 0| 1|   COND    | S| X| X| X| X| X|         LABEL                                 |

 | A| B| INSTRUCTION  | ACTION                              |
 |--|--|--------------|-------------------------------------|
 | 0| 0| b   imm      | $pc <= $pc + label                  |
 | 1| 0| bal imm      | $pc <= $pc + label; $r15 <= $pc + 4 |

#########################
##Conditional Execution##
#########################
R-Type and B-Type instructions can be conditionally executed. The assembly
syntax to use this feature is:

    add $r0 $r0 $r0 s
    b(ne) LABEL

The trailing "s" in the add instruction will cause the status flags (N, Z, C, and V) to be updated
based on the result of the operation. In this case, the result is 0 so the Z flag will will be set.
The "ne" condition executes if the Z flag is unset. Therefore, the branch is not executed and the
following command is loaded. Technically, the command is still executed, just it's effects are
suppressed.
'''
from __future__ import division, print_function, absolute_import
import re
import sys
import click

PAGE_SIZE = 64

opcodes_r_type = {
        'add':   '000011',
        'sub':   '000011',
        'and':   '000011',
        'or':    '000011',
        'xor':   '000011',
        'sll':   '000011',
        'mul':   '000011',
        'jr':    '001000',
        'spush': '000111',
        'spop':  '001111',
        'ret':   '001000',
        }

opcodes_d_type = {
        'ldw':   '000010',
        'stw':   '000110',
        'addil': '001010',
        'addih': '001110',
        'oril':  '010010',
        'orih':  '010110',
        'andil': '011010',
        'andih': '011110',
        }

opcodes_b_type = {
        'b':   '000001',
        'bal': '001001',
        }

opxcodes = {
        'add':   '00010',
        'sub':   '00000',
        'and':   '00110',
        'or':    '00101',
        'xor':   '00100',
        'sll':   '00001',
        'mul':   '01001',
        'jr':    '00000',
        'spush': '00000',
        'spop':  '00000',
        }

condition_codes = {
        'eq': '0000',
        'ne': '0001',
        'hs': '0010',
        'lo': '0011',
        'mi': '0100',
        'pl': '0101',
        'vs': '0110',
        'vc': '0111',
        'hi': '1000',
        'ls': '1001',
        'ge': '1010',
        'lt': '1011',
        'gt': '1100',
        'le': '1101',
        'al': '1110',
        'nv': '1111',
        }


def to_twoscomplement(bits, value):
    if value < 0:
        value = (1 << bits) + value
    formatstring = '{:0%ib}' % bits
    return formatstring.format(value)


class Instruction:
    reg_re = re.compile('\$(\S{2,3})')
    cmd_re = re.compile('([a-z]+)(\(([a-z]*)\))?')

    def __init__(self, text, filename, line_number, instruction_number, labels):
        self.filename = filename
        self.line_number = line_number
        self.addr = instruction_number*4
        self.text = text
        self.labels = labels
        self._tokenize()

    def _tokenize(self):
        if ':' in self.text:
            label, instr = self.text.split(':')
            self.label = label.strip()
        else:
            self.label, instr = None, self.text
        toks = instr.split()
        cmd, args = toks[0], toks[1:]
        cmd, _, cond = self.cmd_re.findall(cmd)[0]
        if not cond:
            cond = 'al'
        if args[-1] == 's':
            self.set = '1'
            args = args[:-1]
        else:
            self.set = '0'
        self.cmd = cmd
        self.args = args
        self.cond = cond

    def _parse_register_argument(self, arg_str):
        try:
            reg = self.reg_re.findall(arg_str)[0]
            if reg == 'sp':
                return 14
            elif reg == 'ra':
                return 15
            else:
                return int(reg[1:])
        except (ValueError, IndexError):
            fmt = 'Require register (eg. $r1), found \"{}\"'
            raise ValueError(fmt.format(arg_str))

    def _parse_literal_argument(self, arg_str):
        try:
            if arg_str[:2] == '0b':
                return int(arg_str, 2)
            elif arg_str[:2] == '0x':
                return int(arg_str, 16)
            else:
                return int(arg_str)
        except ValueError:
            fmt = 'Require Numeric Literal, found \"{}\"'
            raise ValueError(fmt.format(arg_str))

    def _build_r_type_instruction(self):
        if self.cmd == 'jr':
            rd = 0
            rt = 0
            rs = self._parse_register_argument(self.args[0])
        elif self.cmd in ('spop', 'spush'):
            rd = self._parse_register_argument(self.args[0])
            rt = 0
            rs = 0
        else:
            rd = self._parse_register_argument(self.args[0])
            rs = self._parse_register_argument(self.args[1])
            rt = self._parse_register_argument(self.args[2])
        instr = opcodes_r_type[self.cmd]
        instr += condition_codes[self.cond]
        instr += self.set
        instr += '{:04b}'.format(rs)
        instr += '{:04b}'.format(rt)
        instr += '{:04b}'.format(rd)
        instr += opxcodes[self.cmd]
        instr += '0000'
        return instr

    def _build_d_type_instruction(self):
        rt = self._parse_register_argument(self.args[0])
        rs = self._parse_register_argument(self.args[1])
        imm = self._parse_literal_argument(self.args[2])
        instr = opcodes_d_type[self.cmd]
        instr += '{:04b}'.format(rs)
        instr += self.set
        instr += '{:04b}'.format(rt)
        instr += '0'
        instr += to_twoscomplement(16, imm)
        return instr

    def _build_b_type_instruction(self):
        delta = (self.labels[self.args[0]] - self.addr)
        instr = opcodes_b_type[self.cmd]
        instr += condition_codes[self.cond]
        instr += self.set
        instr += '00000'
        instr += to_twoscomplement(16, delta)
        return instr

    def get_bin(self):
        if self.cmd in opcodes_r_type.keys():
            return self._build_r_type_instruction()
        elif self.cmd in opcodes_d_type.keys():
            return self._build_d_type_instruction()
        elif self.cmd in opcodes_b_type.keys():
            return self._build_b_type_instruction()
        else:
            fmt = 'Unknown command on line {} of {}: {}'
            args = self.line_number, self.filename, self.cmd
            raise ValueError(fmt.format(args))


def preprocess(ass_lines, filename, instruction_number_start=0):
    instruction_number = instruction_number_start
    for line_number, line in enumerate(ass_lines.split('\n')):
        pre_comment = line.split('#')[0].strip()
        if pre_comment != '':
            yield filename, line_number+1, instruction_number, pre_comment
            instruction_number += 1


@click.command()
@click.option('--format', type=click.Choice(['hex', 'bintext', 'bin']),
              default='bintext')
@click.option('-o', '--output', type=click.File('w'), default='-')
@click.argument('sources', type=click.File('r'), nargs=-1)
def assemble(sources, format, output):
    if not sources:
        sources = [('stdin', sys.stdin)]
    else:
        sources = [(source.name, source) for source in sources]
    lines = []
    for filename, source in sources:
        lines.extend(preprocess(source.read(), filename, len(lines)))

    labels = {}
    instructions = []
    for filename, line_number, instruction_number, line in lines:
        instr = Instruction(line, filename, line_number,
                            instruction_number, labels)
        if instr.label is not None:
            labels[instr.label] = instr.addr
        instructions.append(instr)
    instructions = [instr.get_bin() for instr in instructions]

    pad_size = PAGE_SIZE - ((len(instructions)+1) % PAGE_SIZE)
    page_count = (len(instructions)+1+pad_size) // PAGE_SIZE
    instructions.extend(['0'*32]*pad_size)
    instructions.insert(0, '{:32b}'.format(page_count))

    for bintext in instructions:
        if format == 'bintext':
            output.write('{}\n'.format(bintext))
        elif format == 'hex':
            hextext = '{:08X}'.format(int(bintext, 2))
            output.write('{}\n'.format(hextext))
