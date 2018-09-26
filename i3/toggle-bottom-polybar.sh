#!/bin/sh

eDP1_id=$(xdo id -a "polybar-bottom_eDP1")
HDMI2_id=$(xdo id -a "polybar-bottom_HDMI2")

if [ $eDP1_id ]; then
    if xprop -id $eDP1_id | grep -q "Normal"; then
        xdo hide -r $eDP1_id
    else
        xdo show -r $eDP1_id
    fi
fi
if [ $HDMI2_id ]; then
    if xprop -id $HDMI2_id | grep -q "Normal"; then
        xdo hide -r $HDMI2_id
    else
        xdo show -r $HDMI2_id
    fi
fi
