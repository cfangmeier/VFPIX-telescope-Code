import unittest
import app.assembly as ass


def c(s):
    return s.replace('_', '')


class AssemblyGeneralTests(unittest.TestCase):

    def test_comments(self):
        assembly_text = '# comment line\nadd $r0 $r1 $r2 #following comment'
        instruction = ass.assemble(assembly_text)
        correct = [c('000011_0000_0_0001_0010_0000_00010_0000')]
        assert(instruction == correct)

    def test_labels(self):
        assembly_text = 'LABEL1: sub $r0 $r1 $r2\nadd $r0 $r1 $r2'
        instruction = ass.assemble(assembly_text)
        correct = [c('000011_0000_0_0001_0010_0000_00010_0000')]
        assert(instruction == correct)


class AssemblyRTypeInstruction(unittest.TestCase):

    def test_add(self):
        assembly_text = 'add $r0 $r1 $r2'
        instruction = ass.assemble(assembly_text)
        correct = [c('000011_0000_0_0001_0010_0000_00010_0000')]
        assert(instruction == correct)

    def test_sub(self):
        assembly_text = 'sub $r0 $r1 $r2'
        instruction = ass.assemble(assembly_text)
        correct = [c('000011_0000_0_0001_0010_0000_00000_0000')]
        assert(instruction == correct)

    def test_and(self):
        assembly_text = 'and $r0 $r1 $r2'
        instruction = ass.assemble(assembly_text)
        correct = [c('000011_0000_0_0001_0010_0000_00110_0000')]
        assert(instruction == correct)

    def test_or(self):
        assembly_text = 'or $r0 $r1 $r2'
        instruction = ass.assemble(assembly_text)
        correct = [c('000011_0000_0_0001_0010_0000_00101_0000')]
        assert(instruction == correct)

    def test_xor(self):
        assembly_text = 'xor $r0 $r1 $r2'
        instruction = ass.assemble(assembly_text)
        correct = [c('000011_0000_0_0001_0010_0000_00100_0000')]
        assert(instruction == correct)

    def test_sll(self):
        assembly_text = 'sll $r0 $r1 $r2'
        instruction = ass.assemble(assembly_text)
        correct = [c('000011_0000_0_0001_0010_0000_00001_0000')]
        assert(instruction == correct)

    def test_mul(self):
        assembly_text = 'mul $r0 $r1 $r2'
        instruction = ass.assemble(assembly_text)
        correct = [c('000011_0000_0_0001_0010_0000_01001_0000')]
        assert(instruction == correct)


def suite():
    s = unittest.TestSuite()
    at = s.addTest
    r_tests = ['test_add', 'test_sub', 'test_and', 'test_or',
               'test_xor', 'test_sll', 'test_mul']
    # r_tests = ['test_add']
    for test in r_tests:
        at(AssemblyRTypeInstruction(test))
    gen_tests = ['test_comments', 'test_labels']
    for test in gen_tests:
        at(AssemblyGeneralTests(test))
    return s
