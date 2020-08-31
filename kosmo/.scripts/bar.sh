#!/bin/sh

killall -q polybar
#polybar white
#polybar mpd

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload white &
  done
else
  polybar --reload white &
fi

