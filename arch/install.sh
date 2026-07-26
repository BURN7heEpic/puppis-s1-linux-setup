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

if [ ! -f /etc/arch-release ]; then
    echo "ERROR: This installer is for Arch Linux."
    exit 1
fi

echo "[+] Installing dependencies..."

pacman -Sy --needed --noconfirm ethtool usbutils networkmanager iptables dnsmasq

systemctl enable --now NetworkManager

echo "[+] Checking Puppis adapter..."

if ! lsusb | grep -q "0b95:1790"; then
    echo "ERROR: Puppis AX88179 adapter not detected."
    echo "Plug in Puppis and try again."
    exit 1
fi

echo "Puppis detected."



echo "[+] Finding Puppis network interface..."

PUPPIS_INTERFACE=$(for dev in $(ls /sys/class/net); do
    if [ -e "/sys/class/net/$dev/device" ]; then
        if udevadm info --query=property --path="/sys/class/net/$dev" 2>/dev/null | grep -q "ID_VENDOR_ID=0b95"; then
            echo "$dev"
            break
        fi
    fi
done)

if [ -z "$PUPPIS_INTERFACE" ]; then
    echo "ERROR: Could not find AX88179 network interface."
    exit 1
fi

echo "Puppis interface: $PUPPIS_INTERFACE"


echo "[+] Finding internet interface..."

INTERNET_INTERFACE=$(ip route show default | awk '{print $5}' | head -1)

if [ -z "$INTERNET_INTERFACE" ]; then
    echo "ERROR: Could not find internet interface."
    exit 1
fi

echo "Internet interface: $INTERNET_INTERFACE"


echo "[+] Finding NetworkManager connection..."

PUPPIS_CONNECTION=$(nmcli -t -f NAME,DEVICE connection show | grep ":$PUPPIS_INTERFACE$" | cut -d: -f1)

if [ -z "$PUPPIS_CONNECTION" ]; then
    echo "ERROR: Could not find NetworkManager connection."
    exit 1
fi

echo "Puppis connection: $PUPPIS_CONNECTION"



echo "[+] Saving Puppis configuration..."

mkdir -p /etc/puppis

echo "$PUPPIS_INTERFACE" > /etc/puppis/pup-device
echo "$INTERNET_INTERFACE" > /etc/puppis/internet-device
echo "$PUPPIS_CONNECTION" > /etc/puppis/pup-connection


echo "[+] Configuring NetworkManager shared mode..."

nmcli connection modify "$PUPPIS_CONNECTION" ipv4.method shared
nmcli connection modify "$PUPPIS_CONNECTION" ipv4.addresses 192.168.137.1/24
nmcli connection modify "$PUPPIS_CONNECTION" connection.autoconnect yes
nmcli connection down "$PUPPIS_CONNECTION" || true
nmcli connection up "$PUPPIS_CONNECTION"


echo "[+] Enabling IP forwarding..."

cat > /etc/sysctl.d/99-puppis.conf <<EOF
net.ipv4.ip_forward=1
EOF

sysctl --system >/dev/null


echo "[+] Installing Puppis sharing script..."

install -Dm755 scripts/puppis-share.sh /usr/local/bin/puppis-share.sh


echo "[+] Creating systemd service..."

cat > /etc/systemd/system/puppis-share.service <<EOF
[Unit]
Description=Puppis S1 Ethernet Sharing
After=NetworkManager.service
Wants=NetworkManager.service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/puppis-share.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF


systemctl daemon-reload

systemctl enable puppis-share.service


echo "[+] Starting Puppis service..."

systemctl restart puppis-share.service

echo "[+] Installing resume recovery..."

install -Dm755 scripts/puppis-resume.sh /usr/local/bin/puppis-resume.sh

cat > /etc/systemd/system/puppis-resume.service <<EOF
[Unit]
Description=Puppis S1 Resume Recovery
After=suspend.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/puppis-resume.sh

[Install]
WantedBy=suspend.target
EOF

systemctl daemon-reload
systemctl enable puppis-resume.service
systemctl start puppis-resume.service || true

echo ""
echo "================================="
echo " Puppis setup complete!"
echo " Reboot recommended."
echo "================================="
