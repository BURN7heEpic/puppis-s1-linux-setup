# Puppis S1 Linux Setup

Automatic setup scripts for sharing a Linux PC's internet connection with the Puppis S1 device over Ethernet.

Supports:

- Ubuntu / Debian based systems
- Arch Linux
- SteamOS

The installer automatically detects your Linux distribution and runs the correct setup.

---

## Installation

Clone the repository and run the installer:

```bash
git clone https://github.com/BURN7heEpic/puppis-s1-linux-setup.git
cd puppis-s1-linux-setup
sudo ./install.sh
```

## SteamOS Notes

SteamOS is supported.

The installer may need to install missing dependencies using pacman. 
If SteamOS package keys are not initialized, the installer will automatically initialize the package keyring.

For SteamOS, you may need to disable the read-only filesystem first:

```bash
sudo steamos-readonly disable
```

## Contact

For questions, issues, or suggestions, feel free to contact me.

GitHub:
https://github.com/BURN7heEpic

For bugs, opening a GitHub issue is preferred so problems and solutions can be tracked at:  
https://github.com/BURN7heEpic/puppis-s1-linux-setup/issues
