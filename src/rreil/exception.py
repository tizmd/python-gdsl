
from enum import IntEnum
class Exc(object):
    pass

ExceptionShared = IntEnum("ExceptionShared", ["DIVISION_BY_ZERO"])

class SharedException(Exc):
    def __init__(self, shared):
        self.shared = ExceptionShared(shared+1)
    def __str__(self):
        return "{{Exception: {}}}".format(self.shared.name)

class ArchException(Exc):
    def __init__(self, arch):
        self.arch = arch
    def __str__(self):
        return '{}'.format(self.arch)


