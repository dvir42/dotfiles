#!/bin/sh

#Change DVI-I-1 to what monitor you want from running command: xrandr
MONITOR="HDMI2"
STYLUS_ID=`xinput | grep "Tablet stylus" | cut -f 2 | cut -c 4-5`

xsetwacom --set $STYLUS_ID Button 2 3

xinput map-to-output $STYLUS_ID $MONITOR
