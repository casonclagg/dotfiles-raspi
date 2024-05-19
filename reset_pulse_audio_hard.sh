#!/bin/bash

# Stop PulseAudio services
systemctl --user stop pulseaudio.service
systemctl --user stop pulseaudio.socket

# Remove PulseAudio configuration files
rm -rf ~/.config/pulse
rm -rf ~/.pulse
rm -rf ~/.pulse-cookie
rm -rf /run/user/$(id -u)/pulse

# Reinstall PulseAudio
sudo apt-get remove --purge pulseaudio -y
sudo apt-get autoremove -y
sudo apt-get install pulseaudio -y

# Ensure PipeWire is disabled
systemctl --user stop pipewire.service
systemctl --user stop pipewire.socket
systemctl --user disable pipewire.service
systemctl --user disable pipewire.socket
systemctl --user mask pipewire.service
systemctl --user mask pipewire.socket

# Start PulseAudio services
systemctl --user enable pulseaudio.service
systemctl --user enable pulseaudio.socket
systemctl --user start pulseaudio.service
systemctl --user start pulseaudio.socket

# Check PulseAudio status
systemctl --user status pulseaudio.service

# Verify PulseAudio info
pactl info

# Test audio output
pactl list sinks short
