import six
import abc
import rreil.branch_hint as branch_hint
import rreil.ids as ids
import rreil.flop as flop
import rreil.address as address
import rreil.exception as exception
import rreil.comparator as comparator
import rreil.expr       as expr
import rreil.linear     as linear
import rreil.sexpr      as sexpr
import rreil.statement  as statement
import rreil.variable  as variable

class Builder(six.with_metalass(abc.ABCMeta)):
    pass

class BaseAddressBuilder(Builder):
    @abc.abstractmethod
    def Address(self, size, address):
        raise NotImplementedError    

class DefaultAddressBuilder(BaseAddressBuilder):
    def Address(self, size, address):
        return address.Address(size, address)
    
class BaseExceptionBuilder(Builder):
    @abc.abstractmethod    
    def SharedException(self, shared):
        raise NotImplementedError    

    @abc.abstractmethod
    def ArchException(self, arch):
        raise NotImplementedError    

class DefaultExceptionBuilder(BaseExceptionBuilder):
    def SharedException(self, shared):
        return exception.SharedException(shared)

    def ArchException(self, arch):
        return exception.ArchException(arch)

class BaseExprBuilder(Builder):
    @abc.abstractmethod    
    def And(self, a, b):
        raise NotImplementedError    

    @abc.abstractmethod
    def Div(self, a, b):
        raise NotImplementedError    

    @abc.abstractmethod
    def DivS(self, a, b):
        raise NotImplementedError    

    @abc.abstractmethod
    def Mod(self, a, b):
        raise NotImplementedError    

    @abc.abstractmethod
    def ModS(self, a, b):
        raise NotImplementedError    

    @abc.abstractmethod
    def Mul(self, a, b):
        raise NotImplementedError    

    @abc.abstractmethod
    def Or(self, a, b):
        raise NotImplementedError    

    @abc.abstractmethod
    def SExpr(self, a):
        raise NotImplementedError    

    @abc.abstractmethod
    def ShL(self, a, b):
        raise NotImplementedError    

    @abc.abstractmethod
    def ShR(self, a, b):
        raise NotImplementedError    

    @abc.abstractmethod
    def ShRS(self, a, b):
        raise NotImplementedError    

    @abc.abstractmethod
    def Sx(self, size, a):
        raise NotImplementedError    

    @abc.abstractmethod
    def Xor(self, a):
        raise NotImplementedError    

    @abc.abstractmethod
    def Zx(self, size, a):
        raise NotImplementedError    

class DefaultExprBuilder(BaseExprBuilder):

    def And(self, a, b):
        return expr.And(a, b)

    def Div(self, a, b):
        return expr.Div(a, b)

    def DivS(self, a, b):
        return expr.DivS(a, b)

    def Mod(self, a, b):
        return expr.Mod(a, b)

    def ModS(self, a, b):
        return expr.ModS(a, b)

    def Mul(self, a, b):
        return expr.Mul(a, b)

    def Or(self, a, b):
        return expr.Or(a, b)

    def SExpr(self, a):
        return expr.SExpr(a, b)

    def ShL(self, a, b):
        return expr.Shl(a, b)

    def ShR(self, a, b):
        return expr.ShR(a, b)

    def ShRS(self, a, b):
        return expr.ShRS(a, b)

    def Sx(self, size, a):
        return expr.Sx(size, a)

    def Xor(self, a):
        return expr.Xor(a, b)

    def Zx(self, size, a):
        return expr.Zx(size, a)

class BaseCmpBuilder(Builder):

    @abc.abstractmethod
    def Eq(self, a, b):
        raise NotImplementedError            

    @abc.abstractmethod
    def LeS(self, a, b):
        raise NotImplementedError            

    @abc.abstractmethod
    def LeU(self, a, b):
        raise NotImplementedError            

    @abc.abstractmethod
    def LtS(self, a, b):
        raise NotImplementedError            

    @abc.abstractmethod
    def LtU(self, a, b):
        raise NotImplementedError            

    @abc.abstractmethod
    def Neq(self, a, b):
        raise NotImplementedError            

class BaseIdBuilder(Builder):
    @abc.abstractmethod    
    def ArchId(self, arch):
        raise NotImplementedError            

    @abc.abstractmethod
    def SharedId(self, shared):
        raise NotImplementedError            

    @abc.abstractmethod
    def TemporaryId(self, temp):
        raise NotImplementedError            

class BaseLinearBuilder(Builder):
    @abc.abstractmethod
    def LinAdd(self, a, b):
        raise NotImplementedError

    @abc.abstractmethod
    def LinImm(self, a):
        raise NotImplementedError

    @abc.abstractmethod
    def LinScale(self, a, b):
        raise NotImplementedError

    @abc.abstractmethod
    def LinSub(self, a, b):
        raise NotImplementedError

    @abc.abstractmethod
    def LinVar(self, a):
        raise NotImplementedError

class BaseSExprBuilder(Builder):

    @abc.abstractmethod
    def Arb(self):
        raise NotImplementedError

    @abc.abstractmethod
    def Cmp(self, size, c):
        raise NotImplementedError

    @abc.abstractmethod
    def Lin(self, l):
        raise NotImplementedError

class BaseStatementBuilder(Builder):
    @abc.abstractmethod
    def Assign(self, size, lhs, rhs):
        raise NotImplementedError
    @abc.abstractmethod
    def Branch(self, hint, target):
        raise NotImplementedError        
    @abc.abstractmethod
    def CBranch(self, cond, taken, nottaken):
        raise NotImplementedError
    @abc.abstractmethod
    def Flop(self, op, flags, lhs, rhs):
        raise NotImplementedError
    @abc.abstractmethod
    def Ite(self, cond, t, f):
        raise NotImplementedError
    @abc.abstractmethod
    def Load(self, size, lhs, address):
        raise NotImplementedError
    @abc.abstractmethod
    def Prim(self, op, lhs, rhs):
        raise NotImplementedError
    @abc.abstractmethod
    def Store(self, size, address, rhs):
        raise NotImplementedError
    @abc.abstractmethod
    def Throw(self, exc):
        raise NotImplementedError
    @abc.abstractmethod
    def While(self, cond, body):
        raise NotImplementedError


class BaseVariableBuilder(Builder):
    @abc.abstractmethod    
    def Variable(self, _id, offset):
        raise NotImplementedError
    @abc.abstractmethod
    def VariableLimited(self, _id, offset, size):
        raise NotImplementedError

class DefaultVariableBuilder(BaseVariableBuilder):

    def Variable(self, _id, offset):
        return variable.Variable(_id, offset)

    def VariableLimited(self, _id, offset, size):
        return variable.VariableLimited(_id, offset, size)

class BaseBuilder(BaseAddressBuilder,
                  BaseExceptionBuilder,
                  BaseExprBuilder,                  
                  BaseCmpBuilder,
                  BaseIdBuilder,
                  BaseLinearBuilder,
                  BaseSExprBuilder,
                  BaseStatementBuilder,
                  BaseVariableBuilder):
    
    def StatementListInit():
        return list()

    def StatementListNext(a, b):
        b.append(a)
        return b

    def VariableLimitedListInit():
        return list()

    def VariableLimitedListNext(a, l):
        l.append(a)
        return l

                  
        
    
        
