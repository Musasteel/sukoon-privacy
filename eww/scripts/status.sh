#!/usr/bin/env bash
# Emits one JSON object with system state, polled by eww.

vol=$(pamixer --get-volume 2>/dev/null)
[ -z "$vol" ] && vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oP '\d+(?=%)' | head -1)
vol=${vol:-50}

bri=$(brightnessctl -m 2>/dev/null | cut -d, -f4 | tr -d '%')
bri=${bri:-50}

bat=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
bat=${bat:-100}

disk=$(df --output=pcent / 2>/dev/null | tail -1 | tr -dc '0-9')
mem=$(free 2>/dev/null | awk '/^Mem/ {printf "%d", $3*100/$2}')

t=$(cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | sort -rn | head -1)
temp=$(( ${t:-40000} / 1000 ))

wifi=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '$1=="yes"{print $2; exit}')
bt=$(bluetoothctl show 2>/dev/null | awk '/Powered:/{print ($2=="yes") ? "yes" : "no"; exit}')
prof=$(powerprofilesctl get 2>/dev/null || echo balanced)

dark=false
[ "$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null)" = "'prefer-dark'" ] && dark=true

printf '{"vol":%s,"bri":%s,"bat":%s,"disk":%s,"mem":%s,"temp":%s,"wifi":"%s","bt":"%s","prof":"%s","dark":%s}\n' \
  "$vol" "$bri" "$bat" "${disk:-0}" "${mem:-0}" "$temp" "${wifi//\"/\\\"}" "${bt:-no}" "$prof" "$dark"
