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

Alternatively, download the ZIP from the Releases page, extract it, open a terminal in the extracted folder, and run:

```bash
sudo ./install.sh
```

---

## SteamOS Notes

SteamOS is supported.

The installer may need to install missing dependencies using pacman.

If SteamOS package keys are not initialized, the installer will automatically initialize the package keyring.

For SteamOS, you may need to disable the read-only filesystem first:

```bash
sudo steamos-readonly disable
```

After installation, you can re-enable it if desired:

```bash
sudo steamos-readonly enable
```

---

## Related Puppis S1 Linux Projects

There is also an existing open-source project focused on configuring the Puppis S1 device itself:

https://github.com/xanderwilkins/puppisctl

`puppisctl` focuses on configuration features such as viewing device information and changing Puppis S1 settings that are normally handled through the official Windows application.

This project focuses on a different part of Linux support: configuring Ethernet sharing and routing so the Puppis S1 can be used with Linux systems for applications such as SteamVR and Steam Link.

The two projects solve different parts of the Linux support problem and can complement each other.

---

## Uninstall

To remove the Puppis S1 Linux setup:

```bash
sudo ./uninstall.sh
```

---

## Contact

For questions, issues, or suggestions, feel free to contact me.

GitHub:

https://github.com/BURN7heEpic

For bugs, opening a GitHub issue is preferred so problems and solutions can be tracked:

https://github.com/BURN7heEpic/puppis-s1-linux-setup/issues
