#!/bin/bash
# NB: run script with sudo

apt update
apt -y upgrade

# Replace default Wireshark for compatibility with xfce4
apt remove -y wireshark-common
apt install -y wireshark-gtk

# Set Wireshark to be runnable by non-root user
#groupadd wireshark
# NB: dpkg-reconfigure will pop up interactive window
dpkg-reconfigure wireshark-common 
chgrp wireshark /usr/bin/dumpcap
usermod -a -G wireshark ubuntu
chmod 754 /usr/bin/dumpcap

# NOTE: Additional non-scripted changes done to baseline image include:

# Fix no-tab-autocomplete in terminal bug.
# 1. Open Application Menu > Settings > Window Manager.
# 2. Click on 'Keyboard' tab.
# 3. Clear the 'Switch window for same application' setting.
# Credits: instructions from:
# https://askubuntu.com/questions/545540/terminal-autocomplete-doesnt-work-properly
#          bug confirmation:
# https://www.starnet.com/xwin32kb/tab-key-not-working-when-using-xfce-desktop/

# Remove the toolbar icon for Wireshark and create new one that's
# a shortcut to wireshark-gtk .