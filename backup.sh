#!/bin/bash
function copyFolder() {
  local sourceFolder=$1
  local destinationFolder=$2

  # Check if the source fodler exists
  if [ ! -d "$sourceFolder" ]; then
     echo "Source folder does not exist: $sourceFolder"
     exit 1
  fi

  # Check if the destination directory exists
  if [ ! -d "$destinationFolder" ]; then
     echo "Destination directory does not exist: $destinationFolder, creating it now"
     mkdir -p $destinationFolder
  fi

  rm -rf "$destinationFolder"
  cp -R "$sourceFolder" "$destinationFolder"

  if [ $? -eq 0 ]; then
     echo "Folder $sourcefile copied successfully."
  else
      echo "Failed $sourcefile to copy the folder."
     exit 2
  fi
}

function copyFile() {
  local sourcefile=$1
  local destinationFolder=$2

  # Check if the source file exists
  if [ ! -f "$sourcefile" ]; then
     echo "Source file does not exist: $sourcefile"
     exit 1
  fi

  # Check if the destination directory exists
  if [ ! -d "$destinationFolder" ]; then
     echo "Destination directory does not exist: $destinationFolder, creating it now"
     mkdir -p $destinationFolder
  fi

  cp -f "$sourcefile" "$destinationFolder"

  if [ $? -eq 0 ]; then
     echo "File $sourcefile copied successfully."
  else
      echo "Failed $sourcefile to copy the file."
     exit 2
  fi
}
# Definition of file paths of configuration files
# Nix OS
NIXOS_SOURCE_FILE="/etc/nixos/configuration.nix"
NIXOS_DESTINATION_DIR="nixos/etc/nixos/"

# NeoVim - NvChad
NVIM_NVCHAD_SOURCE_DIR="$HOME/.config/nvim"
NVIM_NVCHAD_DESTINATION_DIR="neovim/.config/nvim"


# Copying files
copyFile "$NIXOS_SOURCE_FILE" "$NIXOS_DESTINATION_DIR"
copyFolder "$NVIM_NVCHAD_SOURCE_DIR" "$NVIM_NVCHAD_DESTINATION_DIR"

# Publishing into Github
git add .
currentTime=$(date +"%d:%m:%Y %H:%M:%S")
git commit -m "Backup $currentTime"
git push origin master

