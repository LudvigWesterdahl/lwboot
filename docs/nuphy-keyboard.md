
### TODO: create installer
Basically only manual, explain the steps
installer_link: https://nuphy.com/pages/via-usage-guide-for-nuphy-keyboards

This page explains how to show device log in brave which can be reason for not recognizing keyboard in
the usevia.app application:
https://github.com/brave/brave-browser/issues/29411#issuecomment-1534565893

Open device log: brave://device-log/

This post explains how to allow the app to access the keyboard:
https://www.reddit.com/r/Keychron/comments/12f3gat/useviaapp_in_linux_ie_via_support_useful_for/

You then need to configure udev rule under ´/etc/udev/rules.d/´ called ´99-via.rules´ with the
following content:
´KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"´

Then run the following:
´
sudo udevadm control --reload-rules
sudo udevadm trigger
´


Regarding changing the layout. Run the following commands to get the expected output:
[ludvig@archlinux ~]$ localectl --no-convert set-x11-keymap us,se pc105 "" "grp:alt_shift_toggle,compose:ralt"
[ludvig@archlinux ~]$ localectl --no-convert set-keymap us
[ludvig@archlinux ~]$ localectl status
System Locale: LANG=en_US.UTF-8
    VC Keymap: us
   X11 Layout: us,se
    X11 Model: pc105
  X11 Options: grp:alt_shift_toggle,compose:ralt

Also see the backup of the vconsole file here

