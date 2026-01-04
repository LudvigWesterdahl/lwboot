# Installation of Arch Linux

### 1. Create bootable USB
Download the ISO file from the arch linux site.

Use a tool like BalenaEtcher on Mac to create the bootable medium.

### 2. Set up Wi-Fi
After booting from the USB you need to connect to a network.

Run `ip addr show` to check if you have an IP address, check wlan0.

Run the following commands:
1. Open the prompt: `iwctl`
2. Find the network: `station wlan0 get-networks`
3. Exit from the prompt: `exit`
4. Connect to the network: `iwctl --passphrase "PASS" station wlan0 connect "NETWORK"`
5. Check if successful: `ip addr show`

### 3. Options
Run `archinstall` script and after all the options select `Install`.

Choose the following options or similar if installer changed the names.

#### 3.1. Archinstall language
This is just the language to use during installation.

Leave at default English. 

#### 3.2. Mirrors
Choose the server that is closest to you.

Select Sweden.

#### 3.3. Locales
Choose the appropriate keyboard layout.

Choose locale language `en_US` and encoding `UTF-8`.

#### 3.4. Disk configuration
Choose `best-effort default partition layout` and then select the hard drive.

For the filesystem choose `ext4`.

Choose `yes` for a separate partition for `/home` which ensures that user files
are in their own partition.

#### 3.5. Bootloader
Leave at the default `Systemd-boot`.

#### 3.6. Unified kernel images
Leave at default `False`.

#### 3.7. Swap
Select `Yes` and `swap on zram` it compresses RAM

#### 3.8. Hostname
Leave at default `archlinux`.

#### 3.9. Root password
Go through this step and set a strong password.

#### 3.10. User account
Go through this step. Make sure the user gets superuser privileges.

#### 3.11. Profile
This is the type of installation.

Select `Desktop` then `kde`.

Graphics drivers, find out which GPU is in the computer. Typically, it's a choice
between if you have Intel, AMD or Nvidia. Choose `AMD / ATI (open-source)`.

For greeter select `gdm`.

#### 3.12. Audio
For audio server choose `Pipewire`.

#### 3.13. Kernels
Choose `linux` and `linux-lts`. 

The reason for choosing two kernels is that
if one breaks you can still boot your system from the other kernel to recover
the system.

#### 3.14. Additional packages
Leave this empty.

#### 3.15. Network configuration
Select `Use NetworkManager`

#### 3.16. Timezone
Choose the appropriate value.

#### 3.17. Automatic time sync (NTP)
Choose the default value `True`.

#### 3.18. Optional repositories
Leave this empty.

**Sources**
- [How To Install Arch Linux The First Time - Complete Walkthrough](https://www.youtube.com/watch?v=FxeriGuJKTM)
