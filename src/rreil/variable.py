
class Variable(object):
    def __init__(self, _id , offset):
        self._id = _id
        self.offset = offset
    def __str__(self):
        s = str(self._id)
        if self.offset:
            s = s + "/%d" % self.offset
        return s

class VariableLimited(object):
    def __init__(self, _id , offset, size):
        self._id = _id
        self.offset = offset
        self.size = size
    def __str__(self):
        s = str(self._id)
        if self.offset:
            s = s + "/%d" % self.offset
        return s + ":%d" % self.size

def VariableLimitedListInit():
    return list()

def VariableLimitedListNext(a, l):
    l.append(a)
    return l
        
        
