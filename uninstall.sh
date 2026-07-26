#!/bin/bash

set -e

cd "$(dirname "$0")"

echo "================================="
echo " Puppis S1 Linux Setup Uninstaller "
echo "================================="

if [ "$EUID" -ne 0 ]; then
    echo "Run with:"
    echo "sudo ./uninstall.sh"
    exit 1
fi


# Manual override

case "$1" in
    --ubuntu)
        echo "[+] Manual override: Ubuntu/Debian"
        ./ubuntu/uninstall.sh
        exit 0
        ;;

    --arch)
        echo "[+] Manual override: Arch Linux/SteamOS"
        ./arch/uninstall.sh
        exit 0
        ;;
esac


# Detect Linux distribution

if [ ! -f /etc/os-release ]; then
    echo "ERROR: Cannot detect Linux distribution."
    exit 1
fi

source /etc/os-release


echo "[+] Detected distro: $ID"


case "$ID" in

    ubuntu|debian|linuxmint)
        echo "[+] Using Ubuntu/Debian uninstaller"
        ./ubuntu/uninstall.sh
        ;;


    arch|steamos)
        echo "[+] Using Arch/SteamOS uninstaller"
        ./arch/uninstall.sh
        ;;


    *)
        echo ""
        echo "ERROR: Unsupported distribution: $ID"
        echo ""
        echo "Supported:"
        echo "- Ubuntu/Debian"
        echo "- Arch Linux"
        echo "- SteamOS"
        echo ""
        echo "Manual override:"
        echo "sudo ./uninstall.sh --ubuntu"
        echo "sudo ./uninstall.sh --arch"
        exit 1
        ;;

esac
