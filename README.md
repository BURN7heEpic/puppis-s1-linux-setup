# Puppis S1 Linux Setup

Automatic setup scripts for sharing a Linux PC's internet connection with the Puppis S1 device over Ethernet.

Supports:

- Ubuntu / Debian based systems
- Arch Linux
- SteamOS

The installer automatically detects your Linux distribution and runs the correct setup.

---

## Installation

Open a terminal and run the following commands:

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

## Manual Distribution Override

The installer automatically detects your Linux distribution.

If automatic detection fails, you can manually select the installer:

```bash
sudo ./install.sh --ubuntu     (Ubuntu/Debian)
sudo ./install.sh --arch       (Arch/SteamOS)
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

## Alternative Puppis S1 Setup

The Puppis S1 can also be configured using the official PrismXR methods:

- Windows application (Requires access to a Windows installation)
    - PrismXR Windows desktop application can be downloaded [here](https://cdn.shopify.com/s/files/1/0769/5368/2221/files/PrismXR_Desktop.exe?v=1756793839) (Will download instantly)
- PrismXR mobile app 
    - PDF with instructions can be found [here](https://cdn.shopify.com/s/files/1/0769/5368/2221/files/P1411_Puppis_S1_User_Manual_V1.1_43e7fd23-2c4b-4e8e-8bf0-b4050369a7ff.pdf?v=1713714347#page=14)

These methods can be used to configure settings such as the S1's SSID and password.

This Linux installer does not replace the official configuration tools. It focuses on configuring the Linux PC's Ethernet sharing and networking setup required to use the Puppis S1 with Linux systems.

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
