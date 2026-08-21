#!/usr/bin/env bash
# Sukoon sidebar installer — run with:
#   curl -fsSL https://raw.githubusercontent.com/Musasteel/sukoon-privacy/claude/eww-sidebar-config-95wbif/eww/install.sh | bash
set -e

BRANCH=claude/eww-sidebar-config-95wbif
REPO=https://github.com/Musasteel/sukoon-privacy

echo "==> Installing helper packages (sudo password may be asked)..."
sudo apt-get install -y playerctl brightnessctl pamixer fonts-font-awesome curl git
fc-cache -f > /dev/null 2>&1 || true

echo "==> Fetching sidebar config..."
tmp=$(mktemp -d)
git clone --depth 1 -b "$BRANCH" "$REPO" "$tmp"
mkdir -p "$HOME/.config/eww"
cp -r "$tmp/eww/." "$HOME/.config/eww/"
rm -f "$HOME/.config/eww/install.sh"
chmod +x "$HOME/.config/eww/scripts/"*.sh
rm -rf "$tmp"

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

echo "==> Starting sidebar..."
"$EWW" kill 2>/dev/null || true
sleep 1
"$EWW" daemon
sleep 1
"$EWW" open sidebar
echo "Done. Toggle with: eww open sidebar / eww close sidebar"
