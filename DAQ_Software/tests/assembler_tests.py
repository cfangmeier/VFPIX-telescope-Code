import unittest
import app.assembly as ass


class AssemblyTest(unittest.TestCase):

    def _test(self, txt, correct):
        inst = ass.assemble(txt)
        correct = [s.replace('_', '') for s in correct]
        if inst != correct:
            print(txt)
            print(inst)
            print(correct)
            assert(False)

class AssemblyGeneralTests(AssemblyTest):

    def test_comments(self):
        assembly_text = '# comment line\nadd $r0 $r1 $r2 #following comment'
        correct = ['000011_0000_0_0001_0010_0000_00010_0000']
        self._test(assembly_text, correct)

    def test_labels(self):
        assembly_text = '''
        oril $r1 $r0 1  # Initialize registers
        oril $r2 $r0 2
LABEL1: add $r3 $r1 $r2 # Calculate next term in series
        add $r2 $r0 $r2
        add $r1 $r0 $r3
        b LABEL1  # Branch back to LABEL1
'''
        correct = ['010010_00000000100000000000000001',
                   '010010_00000001000000000000000010',
                   '000011_00000000100100011000100000',
                   '000011_00000000000100010000100000',
                   '000011_00000000000110001000100000',
                   '000001_0000_000000_1111111111110100']
        self._test(assembly_text, correct)

class AssemblyDTypeInstruction(AssemblyTest):

    def test_load_word(self):
        assembly_text = 'ldw $r1 $r0 2'
        correct = ['000010_0000_0_0001_0_00000000_00000010']
        self._test(assembly_text, correct)

    def test_store_word(self):
        assembly_text = 'stw $r1 $r0 2'
        correct = ['000110_0000_0_0001_0_00000000_00000010']
        self._test(assembly_text, correct)

    def test_add_imm_low(self):
        assembly_text = 'addil $r1 $r0 2'
        correct = ['001010_0000_0_0001_0_00000000_00000010']
        self._test(assembly_text, correct)

    def test_add_imm_high(self):
        assembly_text = 'addih $r1 $r0 2'
        correct = ['001110_0000_0_0001_0_00000000_00000010']
        self._test(assembly_text, correct)

    def test_or_imm_low(self):
        assembly_text = 'oril $r1 $r0 2'
        correct = ['010010_0000_0_0001_0_00000000_00000010']
        self._test(assembly_text, correct)

    def test_or_imm_high(self):
        assembly_text = 'orih $r1 $r0 2'
        correct = ['010110_0000_0_0001_0_00000000_00000010']
        self._test(assembly_text, correct)

    def test_and_imm_low(self):
        assembly_text = 'andil $r1 $r0 2'
        correct = ['011010_0000_0_0001_0_00000000_00000010']
        self._test(assembly_text, correct)

    def test_and_imm_high(self):
        assembly_text = 'andih $r1 $r0 2'
        correct = ['011110_0000_0_0001_0_00000000_00000010']
        self._test(assembly_text, correct)


class AssemblyBTypeInstruction(AssemblyTest):

    def test_branch(self):
        assembly_text = 'LABEL: b LABEL'
        correct = ['000001_0000_000000_00000000_00000000']
        self._test(assembly_text, correct)

    def test_branch_and_link(self):
        assembly_text = 'LABEL: bal LABEL'
        correct = ['001001_0000_000000_00000000_00000000']
        self._test(assembly_text, correct)


class AssemblyRTypeInstruction(AssemblyTest):

    def test_add(self):
        assembly_text = 'add $r0 $r1 $r2'
        correct = ['000011_0000_0_0001_0010_0000_00010_0000']
        self._test(assembly_text, correct)

    def test_sub(self):
        assembly_text = 'sub $r0 $r1 $r2'
        correct = ['000011_0000_0_0001_0010_0000_00000_0000']
        self._test(assembly_text, correct)

    def test_and(self):
        assembly_text = 'and $r0 $r1 $r2'
        correct = ['000011_0000_0_0001_0010_0000_00110_0000']
        self._test(assembly_text, correct)

    def test_or(self):
        assembly_text = 'or $r0 $r1 $r2'
        correct = ['000011_0000_0_0001_0010_0000_00101_0000']
        self._test(assembly_text, correct)

    def test_xor(self):
        assembly_text = 'xor $r0 $r1 $r2'
        correct = ['000011_0000_0_0001_0010_0000_00100_0000']
        self._test(assembly_text, correct)

    def test_sll(self):
        assembly_text = 'sll $r0 $r1 $r2'
        correct = ['000011_0000_0_0001_0010_0000_00001_0000']
        self._test(assembly_text, correct)

    def test_mul(self):
        assembly_text = 'mul $r0 $r1 $r2'
        correct = ['000011_0000_0_0001_0010_0000_01001_0000']
        self._test(assembly_text, correct)


def suite():
    s = unittest.TestSuite()
    at = s.addTest
    r_tests = ['test_add', 'test_sub', 'test_and', 'test_or',
               'test_xor', 'test_sll', 'test_mul']
    # r_tests = ['test_add']
    for test in r_tests:
        at(AssemblyRTypeInstruction(test))
    d_tests = ['test_load_word', 'test_store_word',
               'test_add_imm_low', 'test_add_imm_high',
               'test_or_imm_low', 'test_or_imm_high',
               'test_and_imm_low', 'test_and_imm_high']
    for test in d_tests:
        at(AssemblyDTypeInstruction(test))
    b_tests = ['test_branch', 'test_branch_and_link']
    for test in b_tests:
        at(AssemblyBTypeInstruction(test))
    gen_tests = ['test_comments', 'test_labels']
    for test in gen_tests:
        at(AssemblyGeneralTests(test))
    return s
