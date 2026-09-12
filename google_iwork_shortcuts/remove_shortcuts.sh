#!/usr/bin/env bash
# ==============================================================================
# remove_shortcuts.sh
# Removes custom Google shortcuts from Apple Pages, Numbers, and Keynote.
# ==============================================================================

echo "==> Removing custom shortcuts from Apple Pages..."
defaults delete com.apple.Pages NSUserKeyEquivalents 2>/dev/null || true
defaults delete com.apple.iWork.Pages NSUserKeyEquivalents 2>/dev/null || true

echo "==> Removing custom shortcuts from Apple Numbers..."
defaults delete com.apple.Numbers NSUserKeyEquivalents 2>/dev/null || true
defaults delete com.apple.iWork.Numbers NSUserKeyEquivalents 2>/dev/null || true

echo "==> Removing custom shortcuts from Apple Keynote..."
defaults delete com.apple.Keynote NSUserKeyEquivalents 2>/dev/null || true
defaults delete com.apple.iWork.Keynote NSUserKeyEquivalents 2>/dev/null || true

echo "==> Restarting cfprefsd (macOS preferences daemon)..."
killall cfprefsd 2>/dev/null || true

echo "Reverted! Apple default shortcuts restored."
