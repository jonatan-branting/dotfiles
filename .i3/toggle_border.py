#!/usr/bin/env python
import i3ipc

i3 = i3ipc.Connection()
ws = [w for w in i3.get_tree().find_focused().workspace() if w.window_class 
        if w.floating != "auto_on" and w.floating != "user_on"]

def set_normal():
    for win in ws:
        win.command("border normal 1")

def set_pixel():
    for win in ws:
        win.command("border pixel 1")

normal = False
for win in ws:
    print(win.border)
    if win.border == "normal":
        normal = True
        break

if normal:
    set_pixel()
    print("set pixel")
else:
    set_normal()
    print("set normal")
