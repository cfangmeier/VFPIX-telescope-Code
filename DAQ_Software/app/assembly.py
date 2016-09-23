import re

opcodes_r_type = {
        'add':   '000011',
        'sub':   '000011',
        'and':   '000011',
        'or':    '000011',
        'xor':   '000011',
        'sll':   '000011',
        'mul':   '000011',
        'jr':    '001000',
        }

opcodes_d_type = {
        'ldw':   '000010',
        'stw':   '000110',
        'addil': '001010',
        'addih': '001110',
        'orih':  '010010',
        'oril':  '010110',
        'andih': '011010',
        'andil': '011110',
        }

opcodes_b_type = {
        'b':   '000001',
        'bal':   '001001',
        }

opxcodes = {'add': '00010',
            'sub': '00000',
            'and': '00110',
            'or': '00101',
            'xor': '00100',
            'sll': '00001',
            'mul': '01001',
            'jr': '00000',
            }


def to_twoscomplement(bits, value):
    if value < 0:
        value = (1 << bits) + value
    formatstring = '{:0%ib}' % bits
    return formatstring.format(value)


class Instruction:
    reg_re = re.compile('\$r([0-9]+)')

    def __init__(self, text, line_number, instruction_number, labels):
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
        self.cmd = cmd
        self.args = args

    def _parse_register_argument(self, arg_str):
        try:
            num = self.reg_re.findall(arg_str)[0]
            return int(num)
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
        else:
            rd = self._parse_register_argument(self.args[0])
            rs = self._parse_register_argument(self.args[1])
            rt = self._parse_register_argument(self.args[2])
        instr = opcodes_r_type[self.cmd]
        instr += '00000'
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
        instr += '0'
        instr += '{:04b}'.format(rt)
        instr += '0'
        instr += to_twoscomplement(16, imm)
        return instr

    def _build_b_type_instruction(self):
        delta = (self.labels[self.args[0]] - self.addr)
        instr = opcodes_b_type[self.cmd]
        instr += '0000'
        instr += '000000'
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
            fmt = 'Unknown command on line {}: {}'
            raise ValueError(fmt.format(self.line_number, self.cmd))


def remove_comments(ass_lines):
    instruction_number = 0
    for line_number, line in ass_lines:
        pre_comment = line.split('#')[0].strip()
        if pre_comment != '':
            yield line_number, instruction_number, pre_comment


def assemble(ass_text):
    print()
    print('='*80)
    print(ass_text)
    print('='*80)
    lines = list(enumerate(ass_text.split('\n')))
    lines = remove_comments(lines)
    labels = {}
    instructions = []
    for line_number, instruction_number, line in lines:
        instr = Instruction(line, line_number, instruction_number, labels)
        if instr.label is not None:
            labels[instr.label] = instr.addr
        instructions.append(instr)

    bins = [instr.get_bin() for instr in instructions]
    print(bins)
    return bins
