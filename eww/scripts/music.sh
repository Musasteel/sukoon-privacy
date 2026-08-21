#!/usr/bin/env bash
# Emits one JSON object with MPRIS player state, polled by eww.

status=$(playerctl status 2>/dev/null || echo Stopped)
if [ "$status" = "Stopped" ]; then
  printf '{"status":"Stopped","title":"Nothing playing","artist":"","art":"","pvol":100}\n'
  exit 0
fi

esc() { sed 's/\\/\\\\/g; s/"/\\"/g'; }
title=$(playerctl metadata title 2>/dev/null | esc)
artist=$(playerctl metadata artist 2>/dev/null | esc)

url=$(playerctl metadata mpris:artUrl 2>/dev/null)
art=""
case "$url" in
  file://*) art=${url#file://} ;;
  http*)
    art="/tmp/eww-art-$(printf %s "$url" | md5sum | cut -d' ' -f1).img"
    [ -f "$art" ] || curl -sL "$url" -o "$art" 2>/dev/null ;;
esac

pvol=$(playerctl volume 2>/dev/null | awk '{printf "%d", $1*100}')

printf '{"status":"%s","title":"%s","artist":"%s","art":"%s","pvol":%s}\n' \
  "$status" "${title:-Unknown}" "$artist" "$art" "${pvol:-100}"
