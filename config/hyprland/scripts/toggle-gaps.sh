#!/usr/bin/env bash

readonly GAPS=5
readonly GAPS_OFF=0
readonly BORDER=2
readonly BORDER_ROUND=7

current_gaps=$(hyprctl getoption general:gaps_in | grep "custom type: " | awk '{print $3}')

if [ "$current_gaps" -eq $GAPS_OFF ]; then
  hyprctl keyword general:gaps_in $GAPS
  hyprctl keyword general:gaps_out $GAPS
  hyprctl keyword general:border_size $BORDER
  hyprctl keyword decoration:rounding $BORDER_ROUND
  notify-send "gaps on"
else
  notify-send "gaps off"
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:gaps_out 0
  hyprctl keyword general:border_size 0
  hyprctl keyword decoration:rounding 0
fi
