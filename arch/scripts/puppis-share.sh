#!/bin/bash

set -e

LOG="/var/log/puppis-share.log"

PUPPIS_INTERFACE=$(cat /etc/puppis/pup-device)
INTERNET_INTERFACE=$(cat /etc/puppis/internet-device)
PUPPIS_CONNECTION=$(cat /etc/puppis/pup-connection)

echo "$(date): Starting Puppis sharing" >> "$LOG"


echo 1 > /proc/sys/net/ipv4/ip_forward


nmcli connection up "$PUPPIS_CONNECTION" >> "$LOG" 2>&1 || true


iptables -t nat -C POSTROUTING \
-s 192.168.137.0/24 \
-o "$INTERNET_INTERFACE" \
-j MASQUERADE 2>/dev/null || \
iptables -t nat -A POSTROUTING \
-s 192.168.137.0/24 \
-o "$INTERNET_INTERFACE" \
-j MASQUERADE


iptables -C FORWARD \
-i "$PUPPIS_INTERFACE" \
-o "$INTERNET_INTERFACE" \
-j ACCEPT 2>/dev/null || \
iptables -A FORWARD \
-i "$PUPPIS_INTERFACE" \
-o "$INTERNET_INTERFACE" \
-j ACCEPT


iptables -C FORWARD \
-i "$INTERNET_INTERFACE" \
-o "$PUPPIS_INTERFACE" \
-m state --state RELATED,ESTABLISHED \
-j ACCEPT 2>/dev/null || \
iptables -A FORWARD \
-i "$INTERNET_INTERFACE" \
-o "$PUPPIS_INTERFACE" \
-m state --state RELATED,ESTABLISHED \
-j ACCEPT


echo "$(date): Puppis sharing active" >> "$LOG"
