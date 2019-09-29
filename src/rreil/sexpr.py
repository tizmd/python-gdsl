
class SExprBase(object):
    pass

class Lin(SExprBase):
    def __init__(self, lin):
        self.linear = lin
    def __str__(self):
        return str(self.linear)
    
class Cmp(SExprBase):
    def __init__(self, size, comp):
        self.size = size
        self.comp = comp
    def __str__(self):
        return "[%s]:%d" % (self.comp, self.size)
    
class Arb(SExprBase):
    def __str__(self):
        return "arbitrary"


