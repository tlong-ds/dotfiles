#!/usr/bin/env bash
# ==============================================================================
# apply_shortcuts.sh
# Overwrites Apple Pages, Numbers, and Keynote shortcuts with Google Docs / Sheets / Slides conventions.
# ==============================================================================

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Applying Google Docs shortcuts to Apple Pages..."
defaults import com.apple.Pages "$DIR/com.apple.Pages.plist"
defaults import com.apple.iWork.Pages "$DIR/com.apple.Pages.plist"

echo "==> Applying Google Sheets shortcuts to Apple Numbers..."
defaults import com.apple.Numbers "$DIR/com.apple.Numbers.plist"
defaults import com.apple.iWork.Numbers "$DIR/com.apple.Numbers.plist"

echo "==> Applying Google Slides shortcuts to Apple Keynote..."
defaults import com.apple.Keynote "$DIR/com.apple.Keynote.plist"
defaults import com.apple.iWork.Keynote "$DIR/com.apple.Keynote.plist"

echo "==> Restarting cfprefsd (macOS preferences daemon)..."
killall cfprefsd 2>/dev/null || true

echo "Done! Please restart Pages, Numbers, and Keynote for changes to take effect."
