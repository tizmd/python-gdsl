
from .arity import Infix

class Comparator(Infix):
    pass

class Eq(Comparator):
    op_str = "=="

class Neq(Comparator):
    op_str = "!="

class LeS(Comparator):
    op_str = "<=s"

class LeU(Comparator):
    op_str = "<=u"

class LtS(Comparator):
    op_str = "<s"

class LtU(Comparator):
    op_str = "<u"


