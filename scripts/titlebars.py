from pprint import * 
import json, subprocess, os

focused_id = -1
focused_color = "#EEEEEE"
normal_color = "#666666"
invisible = "#00000000"

ignore = [
    "Google-chrome"
]

class Window:
    def __init__(self, id, window):
        rect = window['tiledRectangle']
        self.x =  rect['x']
        self.y =  rect['y']
        self.w =  rect['width']
        self.h =  rect['height']
        self.shown = window['shown']
        self.floating = window['state'] == "floating"
        self.focused = id == focused_id
        print("id:", id, "focused:", focused_id)

        if self.focused:
            self.color =  focused_color
        else:
            self.color = normal_color
        if window['className'] in ignore:
            self.color = invisible

    def render(self):
        print(
            self.shown,
            self.floating,
            self.focused,
            self.color,
            self.x,
            self.y,
            self.w,
            self.h
            )


def extract_windows(root):
    if root == None:
        return []
    first_child = extract_windows(root['firstChild'])
    second_child = extract_windows(root['secondChild'])
    client = root['client']
    if client:
        return [Window(root['id'], client)] + first_child + second_child
    return first_child + second_child

def get_windows():
    output = subprocess.check_output("bspc query -T -d", shell=True)
    output = json.loads(output.decode('utf-8'))

    global focused_id
    focused_id = output['focusedNodeId']

    windows = extract_windows(output['root'])
    return windows

if __name__ == '__main__':
    for w in get_windows():
        w.render()

