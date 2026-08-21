#!/usr/bin/env bash
# Show/hide the sidebar with a slide animation. Used by touchegg gestures.

EWW=$(command -v eww || true)
if [ -z "$EWW" ]; then
  for p in "$HOME/.cargo/bin/eww" "$HOME/.local/bin/eww" "$HOME/eww/target/release/eww"; do
    [ -x "$p" ] && EWW=$p && break
  done
fi
[ -z "$EWW" ] && exit 1

case "$1" in
  show)
    "$EWW" update reveal=false 2>/dev/null || true
    "$EWW" open sidebar 2>/dev/null || true
    sleep 0.08
    "$EWW" update reveal=true
    ;;
  hide)
    "$EWW" update reveal=false 2>/dev/null || true
    sleep 0.4
    "$EWW" close sidebar 2>/dev/null || true
    ;;
  toggle)
    if "$EWW" active-windows 2>/dev/null | grep -q sidebar; then
      "$0" hide
    else
      "$0" show
    fi
    ;;
  *) echo "usage: panel.sh show|hide|toggle" ;;
esac
