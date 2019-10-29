#!/bin/env python
from i3pystatus import Status
status = Status()


status.register("clock",
    format="%a %-d %b %X")


status.register("battery",
    format="{percentage:.2f}% {remaining:%E%hh:%Mm}",
    alert=True,
    alert_percentage=5,
    status={
        "DIS":  "Discharging",
        "CHR":  "Charging",
        "FULL": "Bat full",
    },)

status.register("network",
    interface="wlp1s0",
    color_up="#FFFFFF",
    color_down="#FFFFFF",
    format_up="{essid} {quality:03.0f}%",)


status.register("scratchpad",
    format="s:{number}")


status.run()

