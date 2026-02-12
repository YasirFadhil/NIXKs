{ config, pkgs, ... }:

let
  ventoyWrapper = pkgs.writeShellScriptBin "ventoy-create-usb" ''
    set -e

    # Colors for output
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    NC='\033[0m' # No Color

    # Check if running as root
    if [[ $EUID -ne 0 ]]; then
      echo -e "''${RED}Error: This script must be run as root''${NC}"
      echo "Please run: sudo ventoy-create-usb /dev/sdX"
      exit 1
    fi

    # Check if device argument provided
    if [ -z "$1" ]; then
      echo -e "''${RED}Error: No device specified''${NC}"
      echo -e "''${YELLOW}Usage: ventoy-create-usb /dev/sdX''${NC}"
      echo ""
      echo "Available block devices:"
      lsblk -d -n -o NAME,SIZE,TYPE | grep disk
      exit 1
    fi

    DEVICE=$1

    # Validate device exists
    if [ ! -b "$DEVICE" ]; then
      echo -e "''${RED}Error: Device $DEVICE does not exist''${NC}"
      exit 1
    fi

    # Warn user before proceeding
    echo -e "''${YELLOW}WARNING: This will erase all data on $DEVICE''${NC}"
    read -p "Are you sure you want to continue? (yes/no): " -r
    if [[ ! $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
      echo -e "''${YELLOW}Cancelled''${NC}"
      exit 0
    fi

    # Create temporary working directory
    WORK_DIR=$(mktemp -d)
    trap "rm -rf $WORK_DIR" EXIT

    echo -e "''${GREEN}Setting up Ventoy...''${NC}"

    # Copy Ventoy installation to writable location
    cp -r ${pkgs.ventoy}/share/ventoy "$WORK_DIR/" || true

    cd "$WORK_DIR/ventoy"

    # Make scripts executable
    chmod +x Ventoy2Disk.sh 2>/dev/null || true
    chmod +x ./tool/x86_64/* 2>/dev/null || true

    # Run Ventoy installation
    echo -e "''${GREEN}Installing Ventoy to $DEVICE...''${NC}"

    if [ -f "Ventoy2Disk.sh" ]; then
      bash Ventoy2Disk.sh -I "$DEVICE"
      if [ $? -eq 0 ]; then
        echo -e "''${GREEN}Success! Ventoy has been installed to $DEVICE''${NC}"
        echo ""
        echo -e "''${YELLOW}Next steps:''${NC}"
        echo "1. Mount the Ventoy partition"
        echo "2. Copy ISO files to the root directory"
        echo "3. Reboot and select the USB drive"
      else
        echo -e "''${RED}Installation failed''${NC}"
        exit 1
      fi
    else
      echo -e "''${RED}Error: Ventoy2Disk.sh not found''${NC}"
      exit 1
    fi
  '';

in
{
  environment.systemPackages = with pkgs; [
    ventoyWrapper
    ventoy
    util-linux
    e2fsprogs
    dosfstools
  ];
}
