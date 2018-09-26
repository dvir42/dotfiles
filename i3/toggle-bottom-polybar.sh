#!/bin/sh

eDP1_id=$(xdo id -a "polybar-bottom_eDP1")
HDMI2_id=$(xdo id -a "polybar-bottom_HDMI2")

if [ $eDP1_id ]; then
    xdo kill -r $eDP1_id
else
    MONITOR=eDP1 polybar --reload bottom &
fi
if [ $HDMI2_id ]; then
    xdo kill -r $HDMI2_id
else
    MONITOR=HDMI2 polybar --reload bottom &
fi
