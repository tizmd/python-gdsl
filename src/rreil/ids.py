from enum import IntEnum

class Id(object):
    pass

class ArchId(Id):
    def __init__(self, arch):
        self.arch = arch

    def __str__(self):
        return str(self.arch)
    
RREIL_ID_SHARED = IntEnum("RREIL_ID_SHARED", ["FLOATING_FLAGS"])
        
class SharedId(Id):
    def __init__(self, shared):
        self.shared = RREIL_ID_SHARED(shared + 1)

    def __str__(self):
        return str(self.shared)

class TemporaryId(Id):
    def __init__(self, temp):
        self.temporary = int(temp)

    def __str__(self):
        return "T%d" % self.temporary
    
    

