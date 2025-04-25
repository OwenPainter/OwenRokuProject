#!/bin/bash

ZIP_FILE="PushUpApp.zip"
ROKU_IP="192.168.141.113"

# Remove the existing zip file if it exists but ignore hidden zip files
test -f "$ZIP_FILE" && [[ "$ZIP_FILE" != .* ]] && rm "$ZIP_FILE"

# Compress the roku folders and stuff
zip -r "$ZIP_FILE" components images source Makefile manifest sounds

echo "Compression complete: $ZIP_FILE"

echo -n "Open Roku Debugger? (y/n): "
read answer

if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
  echo "Launching Debugger..."
  telnet "$ROKU_IP" 8085
elif [[ "$answer" == "n" || "$answer" == "N" ]]; then
  echo "Cancelling..."
else
  echo "Invalid input. Please enter y or n."
fi
