from .arity import *

class Expr(object):
    pass

class SExpr(Expr):
    def __init__(self, sexpr):
        self.sexpr = sexpr

    def __str__(self):
        s = "%s" % self.sexpr
        if isinstance(self.sexpr, Infix):
            s = "(%s)" % s
        return s
    
class Mul(Expr, Infix):
    op_str = "*"

class Div(Expr, Infix):
    op_str = "/u"

class DivS(Expr, Infix):
    op_str = "/S"

class Mod(Expr, Infix):
    op_str = "%%"

class ModS(Expr, Infix):
    op_str = "%%s"

class ShL(Expr, Infix):
    op_str = "<<"

class ShR(Expr, Infix):
    op_str = ">>u"

class ShRS(Expr, Infix):
    op_str = ">>s"

class And(Expr, Infix):
    op_str = "&"

class Or(Expr, Infix):
    op_str = "|"

class Xor(Expr, Infix):
    op_str = "^"

class Sx(Expr, Arity1):
    def __init__(self, size, arg):
        super(Sx,self).__init__(arg)
        self.size = size

    def __str__(self):
        return "{%d->s*} %s" % (self.size, self.arg)
    
class Zx(Expr, Arity1):
    def __init__(self, size, arg):
        super(Zx,self).__init__(arg)
        self.size = size

    def __str__(self):
        return "{%d->u*} %s" % (self.size, self.arg)

    
