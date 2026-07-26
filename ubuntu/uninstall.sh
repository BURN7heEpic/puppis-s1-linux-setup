#!/bin/bash

set -e

echo "================================="
echo " Puppis S1 Linux Setup Uninstaller "
echo "================================="

if [ "$EUID" -ne 0 ]; then
    echo "Run with:"
    echo "sudo ./uninstall.sh"
    exit 1
fi


echo "[+] Stopping services..."

systemctl stop puppis-share.service 2>/dev/null || true
systemctl stop puppis-resume.service 2>/dev/null || true


echo "[+] Disabling services..."

systemctl disable puppis-share.service 2>/dev/null || true
systemctl disable puppis-resume.service 2>/dev/null || true


echo "[+] Removing systemd services..."

rm -f /etc/systemd/system/puppis-share.service
rm -f /etc/systemd/system/puppis-resume.service

systemctl daemon-reload


echo "[+] Removing scripts..."

rm -f /usr/local/bin/puppis-share.sh
rm -f /usr/local/bin/puppis-resume.sh


echo "[+] Removing firewall rules..."

if [ -f /etc/puppis/pup-device ] && [ -f /etc/puppis/internet-device ]; then

    PUPPIS_INTERFACE=$(cat /etc/puppis/pup-device)
    INTERNET_INTERFACE=$(cat /etc/puppis/internet-device)

    iptables -t nat -D POSTROUTING \
    -s 192.168.137.0/24 \
    -o "$INTERNET_INTERFACE" \
    -j MASQUERADE 2>/dev/null || true


    iptables -D FORWARD \
    -i "$PUPPIS_INTERFACE" \
    -o "$INTERNET_INTERFACE" \
    -j ACCEPT 2>/dev/null || true


    iptables -D FORWARD \
    -i "$INTERNET_INTERFACE" \
    -o "$PUPPIS_INTERFACE" \
    -m state --state RELATED,ESTABLISHED \
    -j ACCEPT 2>/dev/null || true

fi


echo "[+] Removing sysctl configuration..."

rm -f /etc/sysctl.d/99-puppis.conf

sysctl --system >/dev/null


echo "[+] Resetting NetworkManager Puppis connection..."

if [ -f /etc/puppis/pup-connection ]; then

    PUPPIS_CONNECTION=$(cat /etc/puppis/pup-connection)

    nmcli connection modify "$PUPPIS_CONNECTION" ipv4.method auto 2>/dev/null || true
    nmcli connection modify "$PUPPIS_CONNECTION" ipv4.addresses "" 2>/dev/null || true

    nmcli connection down "$PUPPIS_CONNECTION" 2>/dev/null || true
    nmcli connection up "$PUPPIS_CONNECTION" 2>/dev/null || true

fi


echo "[+] Removing Puppis configuration..."

rm -rf /etc/puppis


echo ""
echo "================================="
echo " Puppis setup removed."
echo "================================="
