windows = {}

def putWindow(id, x, y, width, height):
    windows[id] = (x, y, width, height)

def getWindow(id):
    return windows[id]
