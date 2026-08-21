#!/usr/bin/env bash
# Sets MPRIS player volume; eww passes 0-100, playerctl wants 0.0-1.0.
playerctl volume "$(awk -v v="$1" 'BEGIN{printf "%.2f", v/100}')" 2>/dev/null
