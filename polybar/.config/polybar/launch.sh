#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
#polybar-msg cmd quit
#
# Launch bar1 and bar2
# cho "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# polybar base 2>&1 | tee -a /tmp/polybar1.log & disown

MONITOR=DP-2 TRAY_POS="right" polybar --reload &
MONITOR=HDMI-3 TRAY_POS="" polybar --reload &
