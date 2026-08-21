#!/usr/bin/env bash
# Toggles for the quick-settings chips: wifi | bt | profile | dark

case "$1" in
  wifi)
    if [ "$(nmcli radio wifi)" = "enabled" ]; then nmcli radio wifi off; else nmcli radio wifi on; fi ;;
  bt)
    if bluetoothctl show | grep -q "Powered: yes"; then bluetoothctl power off; else bluetoothctl power on; fi ;;
  profile)
    case "$(powerprofilesctl get 2>/dev/null)" in
      power-saver) powerprofilesctl set balanced ;;
      balanced)    powerprofilesctl set performance 2>/dev/null || powerprofilesctl set power-saver ;;
      *)           powerprofilesctl set power-saver ;;
    esac ;;
  dark)
    if [ "$(gsettings get org.gnome.desktop.interface color-scheme)" = "'prefer-dark'" ]; then
      gsettings set org.gnome.desktop.interface color-scheme 'default'
    else
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    fi ;;
esac
