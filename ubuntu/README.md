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
- Puppis S1 already configured (If not follow Github below)
- Ethernet connection from PC to Puppis S1 (If you don't have access to ethernet, the github below will help)

## First time Puppis setup

If your Puppis S1 has not been configured yet, use:
[https://github.com/xanderwilkins/puppisctl]
It should allow you to configure the Puppis S1 before running this program.

This project does not configure Puppis firmware/settings.

## Linux PC setup

1. Download `puppis-linux-setup.zip`

2. Extract the zip file.

3. Open a terminal inside the extracted folder.

4. Run:

```bash
sudo ./install.sh
```

## Uninstalling

If you want to remove the Puppis Linux setup:

1. Open a terminal inside the `puppis-linux-setup` folder.

2. Run:

```bash
sudo ./uninstall.sh
```



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

## Support / Feedback

This is a community-made project. Feedback, bug reports, and improvements are welcome.

If you run into issues, please open a GitHub Issue and include:
- Linux distribution and version
- Hardware setup
- Any error messages
- Installer output

For general questions, you can also contact me on Discord:
`burn7heepic`



**This project is community-made and is not affiliated with Puppis.**
