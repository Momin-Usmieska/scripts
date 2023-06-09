#!/bin/bash

percent=$(cat /sys/class/power_supply/BAT1/capacity)

if [[ $percent < 15 ]]; then
  notify-send -u "critical" "Battery" "low Battery"
elif [[ $percent == 100 ]]; then
  notify-send  "Battery" "full Battery"
fi
