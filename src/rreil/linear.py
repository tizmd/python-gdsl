from .arity import Infix

class LinearBase(object):
    pass

class LinVar(LinearBase):
    def __init__(self, var):
        self.variable = var

    def __str__(self):
        return str(self.variable)

class LinImm(LinearBase):
    def __init__(self, imm):
        self.value = imm
    def __str__(self):
        return "%d" % self.value
    
class LinAdd(LinearBase, Infix):
    op_str = "+"

class LinSub(LinearBase, Infix):
    op_str = "-"

class LinScale(LinearBase):
    def __init__(self, imm, opnd):
        self.imm = imm
        self.opnd = opnd
    def __str__(self):
        return "%d*%s" % (self.imm, self.opnd)

    
        
    
    
    
