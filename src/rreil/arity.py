
class Arity1(object):
    __slots__ = ("arg",)
    def __init__(self, opnd):
        self.arg = opnd

    def __str__(self):
        return "%s(%s)" % (self.__class__.__name__, self.arg)

    def __repr__(self):
        return "<%s>" % self
    @property
    def args(self):
        yield self.arg

class Arity2(object):
    __slots__ = ("_args",)
    def __init__(self, opnd0, opnd1):
        self._args = (opnd0, opnd1)

    def __str__(self):
        return "%s%s" % (self.__class__.__name__, self._args)

    def __repr__(self):
        return "<%s>" % self

    @property
    def args(self):
        return iter(self._args)

class Infix(Arity2):
    op_str = NotImplemented
    def __str__(self):
        arg0, arg1 = self.args
        return "%s %s %s" % (arg0, self.op_str, arg1)

