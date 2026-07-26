#!/bin/bash

set -e

cd "$(dirname "$0")"

echo "================================="
echo " Puppis S1 Linux Setup Installer "
echo "================================="

if [ "$EUID" -ne 0 ]; then
    echo "Run with:"
    echo "sudo ./install.sh"
    exit 1
fi

case "$1" in
    --ubuntu)
        echo "[+] Manual override: Ubuntu/Debian"
        ./ubuntu/install.sh
        exit 0
        ;;

    --arch)
        echo "[+] Manual override: Arch Linux/SteamOS"
        ./arch/install.sh
        exit 0
        ;;
esac

if [ ! -f /etc/os-release ]; then
    echo "ERROR: Cannot detect Linux distribution."
    exit 1
fi

source /etc/os-release


echo "[+] Detected distro: $ID"


case "$ID" in

    ubuntu|debian|linuxmint)
        echo "[+] Using Ubuntu/Debian installer"
        ./ubuntu/install.sh
        ;;


    arch|steamos)
        echo "[+] Using Arch/SteamOS installer"
        ./arch/install.sh
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
        echo "sudo ./install.sh --ubuntu"
        echo "sudo ./install.sh --arch"
        exit 1
        ;;

esac
