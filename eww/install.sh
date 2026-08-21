#!/usr/bin/env bash
# Sukoon sidebar installer — run with:
#   curl -fsSL https://raw.githubusercontent.com/Musasteel/sukoon-privacy/claude/eww-sidebar-config-95wbif/eww/install.sh | bash
set -e

BRANCH=claude/eww-sidebar-config-95wbif
REPO=https://github.com/Musasteel/sukoon-privacy

echo "==> Installing helper packages (sudo password may be asked)..."
sudo apt-get install -y playerctl brightnessctl pamixer fonts-font-awesome curl git
# Ubuntu's archive carries the obsolete touchegg 1.x (no swipe support on
# modern libinput); touchegg 2.x lives in the developer's official PPA.
if ! systemctl list-unit-files 2>/dev/null | grep -q '^touchegg'; then
  echo "==> Adding the official touchegg PPA (2.x)..."
  sudo add-apt-repository -y ppa:touchegg/stable || true
  sudo apt-get update || true
fi
sudo apt-get install -y touchegg || echo "WARN: touchegg unavailable; trackpad gestures will not work"
fc-cache -f > /dev/null 2>&1 || true

echo "==> Fetching sidebar config..."
tmp=$(mktemp -d)
git clone --depth 1 -b "$BRANCH" "$REPO" "$tmp"
mkdir -p "$HOME/.config/eww"
cp -r "$tmp/eww/." "$HOME/.config/eww/"
rm -f "$HOME/.config/eww/install.sh"
chmod +x "$HOME/.config/eww/scripts/"*.sh
rm -rf "$tmp"

echo "==> Setting up trackpad gestures (3-finger swipe left/right)..."
if [ -f "$HOME/.config/eww/touchegg.conf" ]; then
  mkdir -p "$HOME/.config/touchegg"
  mv "$HOME/.config/eww/touchegg.conf" "$HOME/.config/touchegg/touchegg.conf"
fi
if command -v touchegg > /dev/null; then
  sudo systemctl enable --now touchegg.service 2>/dev/null || true
  # restart the user-session client so it picks up the new config
  pkill -u "$(id -u)" -x touchegg 2>/dev/null || true
  sleep 1
  nohup touchegg > /dev/null 2>&1 &
fi

# Find the eww binary even if it isn't on PATH in this shell
EWW=$(command -v eww || true)
if [ -z "$EWW" ]; then
  for p in "$HOME/.cargo/bin/eww" "$HOME/.local/bin/eww" "$HOME/eww/target/release/eww"; do
    [ -x "$p" ] && EWW=$p && break
  done
fi
if [ -z "$EWW" ]; then
  echo "ERROR: could not find the 'eww' binary. Install eww, then run: eww open sidebar"
  exit 1
fi

echo "==> Enabling autostart at login..."
mkdir -p "$HOME/.config/autostart"
cat > "$HOME/.config/autostart/sukoon-sidebar.desktop" <<AUTOEOF
[Desktop Entry]
Type=Application
Name=Sukoon Sidebar
Exec=sh -lc "sleep 2; $HOME/.config/eww/scripts/panel.sh show"
X-GNOME-Autostart-enabled=true
AUTOEOF

echo "==> Starting sidebar..."
"$EWW" kill 2>/dev/null || true
sleep 1
"$EWW" daemon
sleep 1
"$HOME/.config/eww/scripts/panel.sh" show
echo "Done. Swipe left with 3 fingers to show the sidebar, right to hide it."
echo "Manual toggle: ~/.config/eww/scripts/panel.sh toggle"
