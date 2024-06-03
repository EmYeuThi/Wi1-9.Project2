#!/bin/bash

# Download and unzip ngrok
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1

# Set ngrok authtoken
NGROK_TOKEN="2hLQzcVxVFh9lB2DqA4dndztFMG_5GWCNLUALaDuqXuDgcDuP"
./ngrok authtoken $NGROK_TOKEN 

# Start ngrok in the background
nohup ./ngrok tcp 5900 &>/dev/null &

# Update and install QEMU
echo "Please wait for installing new 10..."
sudo apt update -y > /dev/null 2>&1
echo "Installing QEMU (2-3m)..."
sudo apt install qemu-system-x86 curl -y > /dev/null 2>&1

# Check if the Windows disk image already exists
if [ -f "w10x64.img" ]; then
    echo "Windows disk image already exists. Skipping download."
else
    echo "Downloading Windows Disk..."
    curl -L -o w10x64.img https://bit.ly/akuhnetW10x64
fi

# Display VNC details
echo "Windows 10 x64 Lite On Google Colab"
echo "Your VNC IP Address:"
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "Note: Use Right-Click Or Ctrl+C To Copy"
echo "Please Keep Colab Tab Open, Maximum Time 12h"
echo "Script by fb.com/thuong.hai.581"

# Start Windows
echo "Starting Windows xxxz..."
sudo qemu-system-x86_64 -vnc :0 -hda w10x64.img -smp cores=2 -m 8096M -machine usb=on -device usb-tablet