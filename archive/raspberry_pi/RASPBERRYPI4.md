# Raspberry Pi 4

The Raspberry Pi 4 is a nice SBC. Here are some instructions:

Get the raspberry pi imager
Once you start it, press ctrl-shift-X to get the special config menu. Here's you can set wifi and SSH options.

## Configure OS basics

login as:

    ssh pi@rpi42g

Replace hostname above with yours.
The "pi" user has sudo rights, without password.

### Update and upgrade

Run these commands to update the OS:

    sudo apt update && sudo apt upgrade -y && sudo apt-get dist-upgrade && sudo apt autoremove -y

### Install some tools

Install some of my favourite tools and utilities. Avahi announces hostname on the network. Glances is a good alternative to htop.

    sudo apt install -y git nano htop mc build-essential glances curl avahi-daemon pigz unattended-upgrades

### Unattended upgrades

You can configure unattended-upgrades on ubuntu/debian systems to also update normal packages, instead of just security packages.

It's not required and it's not a good idea for production systems, but nice for something like your personal jenkins or plex server (see later sections)

Here is the guide: [How to Enable Unattended Upgrades on Ubuntu/Debian](https://haydenjames.io/how-to-enable-unattended-upgrades-on-ubuntu-debian/)

Quick bits from the article: F

First edit config file:

    sudo nano /etc/apt/apt.conf.d/50unattended-upgrades

Uncomment the line that says

    //"${distro_id}:${distro_codename}-updates";

Then edit:

    sudo nano /etc/apt/apt.conf.d/20auto-upgrades

Add this line:

    APT::Periodic::AutocleanInterval "7";

You're done with configuring unattended-upgrades
