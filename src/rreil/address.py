class Address(object):
    def __init__(self, size, address):
        self.size = size
        self.address = address
    def __str__(self):
        return "{%d} %s" % (self.size, self.address) 
        
