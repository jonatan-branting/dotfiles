#!/usr/bin/env python
import i3ipc
import math

i3 = i3ipc.Connection()

def set_dynamic_gaps(self=None, _=None):
    try:
        ws = i3.get_tree().find_focused().workspace()
        tiled = [w for w in ws
                    if w.floating != "auto_on" and w.floating != "user_on"]
        visible = [w for w in tiled
                    if not w.parent or w.parent.layout != "stacked"]
        numw = len(visible)
        inner = max(16 - ((numw + 2)//2)*2, 2)
        i3.command("gaps inner current set {}".format(inner))
    except:
        pass
        #TODO output to file

# Dynamically name your workspaces after the current window class
def set_workspace_name(i3, e):
    try:
        focused = i3.get_tree().find_focused()
        if focused.type == "workspace":
            i3.command('rename workspace to {}'.format(focused.num))
        else:
            name = focused.name[:15] + ".." if len(focused.name) > 15 else focused.name
            ws_name = "{}:{}".format(focused.workspace().num, name)
            i3.command('rename workspace to "%s"' % ws_name)
    except:
        pass
        # TODO output to file


# Init
set_dynamic_gaps()

# Subscribe to events
i3.on('workspace::focus', set_dynamic_gaps)
i3.on('window::new', set_dynamic_gaps)
i3.on('window::close', set_dynamic_gaps)

i3.on('workspace::focus', set_workspace_name)
i3.on("window::focus", set_workspace_name)
i3.on("window::close", set_workspace_name)
i3.on("window::title", set_workspace_name)


# Start the main loop and wait for events to come in.
i3.main()
