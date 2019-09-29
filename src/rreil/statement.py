class Statement(object):
    pass

class Assign(Statement):
    def __init__(self, size, lhs, rhs):
        self.size = size
        self.lhs = lhs
        self.rhs = rhs

    def __str__(self):
        return "%s =:%d %s" % (self.lhs, self.size, self.rhs)

class Load(Statement):
    def __init__(self, size, lhs, address):
        self.size = size
        self.lhs = lhs
        self.address = address

    def __str__(self):
        return "%s =:%d *(%s)" % (self.lhs, self.size, self.address)
        
class Store(Statement):
    def __init__(self, size, address, rhs):
        self.size = size
        self.address = address
        self.rhs = rhs

    def __str__(self):
        return "*(%s) =:%d %s" % (self.address, self.size, self.rhs)
        
class Ite(Statement):
    def __init__(self, cond, then_branch, else_branch):
        self.cond = cond
        self._then = then_branch
        self._else = else_branch

    def __str__(self):
        return "if (%s) {\n%s} else {\n%s}" % (self.cond, "\n".join(map(str, self._then)), "\n".join(map(str, self._else)))
    
    
class While(Statement):
    def __init__(self, cond, body):
        self.cond = cond
        self.body = body

    def __str__(self):
        return "while (%s) {\n%s}" % (self.cond, "\n".join(map(str, self.body)))
    

class CBranch(Statement):
    def __init__(self, cond, target_true, target_false):
        self.cond = cond
        self.taken = target_true
        self.nottaken = target_false
    def __str__(self):
        return "if (%s) { goto %s } else { goto %s }" % (self.cond, self.taken, self.nottaken)

class Branch(Statement):
    def __init__(self, hint, target):
        self.hint = hint
        self.target = target
    def __str__(self):
        return "goto [%s] %s" % (self.hint, self.target)
    
class Flop(Statement):
    def __init__(self, op, flags, lhs, rhs):
        self.op = op
        self.flags = flags
        self.lhs = lhs
        self.rhs = rhs

    def __str__(self):
        s = "%s = $%s " % (self.lhs, self.op)
        if self.rhs:
            s += "(%s)" % ", ".join(map(str, self.rhs))
        s += "[flags: %s]" % self.flags
        return s
    
class Prim(Statement):
    def __init__(self, op, lhs, rhs):
        self.op = op
        self.lhs = lhs
        self.rhs = rhs
    def __str__(self):
        s = ""
        if self.lhs:
            s += "(%s)" % ", ".join(map(str, self.lhs))
            s += " = "
        s += "$%s" % self.op
        if self.rhs:
            s += " (%s)" % ", ".join(map(str,self.rhs))
        return s

class Throw(Statement):
    def __init__(self, exc):
        self._exception = exc
    def __str__(self):
        return "throw %s" % self._exception
    
    
def StatementListInit():
    return list()

def StatementListNext(a, b):
    b.append(a)
    return b

