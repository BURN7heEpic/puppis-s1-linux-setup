# Puppis S1 Linux SteamVR Setup

A Linux setup script for using the Puppis S1 with Steam Link and SteamVR.

## What this does

This installer configures the Linux PC side of the Puppis S1 connection.

Features:
- Automatic Puppis USB Ethernet detection
- NetworkManager shared mode setup
- Ethernet internet sharing
- Automatic boot setup
- Sleep/wake recovery

## Requirements

- Ubuntu (tested on Ubuntu 26.04)
- Puppis S1 already configured
- USB Ethernet connection from Puppis to PC

## First time Puppis setup

If your Puppis S1 has not been configured yet, use:
[https://github.com/xanderwilkins/puppisctl]
It should allow you to configure the Puppis S1 before running this program.

This project does not configure Puppis firmware/settings.

## Linux PC setup

Run:

sudo ./install.sh

Then:
1. Connect Quest to Puppis WiFi
2. Open Steam Link
3. Connect to your Linux PC
4. SteamVR should automatically be open now and running smoothly.



## Tested on

- Ubuntu 26.04

## Extra info / Disclaimer

- This project was created from troubleshooting and testing a Puppis S1 setup on Linux. I am not a Linux networking developer, so feedback, improvements, and bug reports are appreciated.
- This installer has been tested with my setup:
  - Quest Pro headset
  - Valve Index controllers
  - SteamVR
  - VRChat face tracking tools
  - fpsVR
  - OVR advanced Settings
  - OVR Toolkit

- It should work with other SteamVR-compatible setups, but I cannot guarantee compatibility with every headset or VR configuration.
