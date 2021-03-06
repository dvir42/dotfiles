#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar on all monitors
MONITOR=HDMI2 polybar -q --reload top &
MONITOR=HDMI2 polybar -q --reload bottom &
MONITOR=eDP1 polybar --reload top &
MONITOR=eDP1 polybar --reload bottom &
