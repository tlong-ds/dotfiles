#!/bin/bash

# Ensure directories exist
mkdir -p "$HOME/bin"
mkdir -p "$HOME/Applications"
mkdir -p "$HOME/Library/LaunchAgents"
mkdir -p "$HOME/Library/Logs"

echo "=== Microphone Protector Setup ==="

# Compile the Swift utility
echo "Compiling swift audio manager..."
swiftc -O "$HOME/bin/audio-manager.swift" -o "$HOME/bin/audio-manager"
if [ $? -ne 0 ]; then
    echo "Error: Swift compilation failed."
    exit 1
fi
echo "Swift utility compiled successfully."

# Compile the AppleScript
echo "Compiling AppleScript..."
rm -rf "$HOME/Applications/MicrophoneProtector.app"
osacompile -s -o "$HOME/Applications/MicrophoneProtector.app" "$HOME/bin/microphone_protector.applescript"
if [ $? -ne 0 ]; then
    echo "Error: AppleScript compilation failed."
    exit 1
fi
echo "AppleScript app compiled successfully."

# Set LSUIElement to hide dock icon
echo "Configuring App to run in background (no dock icon)..."
/usr/libexec/PlistBuddy -c "Delete :LSUIElement" "$HOME/Applications/MicrophoneProtector.app/Contents/Info.plist" 2>/dev/null
/usr/libexec/PlistBuddy -c "Add :LSUIElement bool true" "$HOME/Applications/MicrophoneProtector.app/Contents/Info.plist"

# Unload existing agent if running
echo "Unloading existing LaunchAgent if active..."
launchctl bootout gui/$(id -u)/com.bunnypro.microphone-protector 2>/dev/null
launchctl unload "$HOME/Library/LaunchAgents/com.bunnypro.microphone-protector.plist" 2>/dev/null

# Load the new LaunchAgent
echo "Loading and starting LaunchAgent..."
launchctl bootstrap gui/$(id -u) "$HOME/Library/LaunchAgents/com.bunnypro.microphone-protector.plist" 2>/dev/null || launchctl load "$HOME/Library/LaunchAgents/com.bunnypro.microphone-protector.plist"

echo "=== Setup Complete ==="
echo "Microphone Protector is now running and will persist across reboots."
echo "Locked default microphone: $( "$HOME/bin/audio-manager" get )"
