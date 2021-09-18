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

## Plex

Plex is a nice video server that has support for the CPU. The Odroid HC2 has enough CPU power for light realtime transcoding.

### Repo install

You can read about how to [Install plex from a repository](https://support.plex.tv/articles/235974187-enable-repository-updating-for-supported-linux-server-distributions/)

Here's a quick recap:

    echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
    
    curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
    
    sudo apt-get update

   sudo apt-get install plexmediaserver -y

You may get asked about "Configuration file '/etc/apt/sources.list.d/plexmediaserver.list'" and what to keep... you should choose the package maintainers version, ie. "Y"

### Access the Plex server

Just like any plex install, just [Access the plex web interface](http://plex:32400/web)

### Map a SMB share on another machine

Let's mount a SMB share on another machine, so you can have a big NAS but do the plex transcoding on the Odroid HC2. First instal the tools:

    sudo apt install cifs-utils -y

then reboot to make rpi understand 'cifs' protocol:

    reboot

Login again and test it out

    sudo mkdir /mnt/media
    sudo mount -t cifs -o 'username=video,password=V!d30pass,uid=plex,gid=plex,x-systemd.automount,_netdev' //nas/media/video //mnt/media

    ls -lah /mnt/media

To unmount again:

    sudo umount -f /mnt/media

To make it permanent, add a line to /etc/fstab:

    sudo nano  /etc/fstab

Like this:

    //nas/media/video                               /mnt/media      cifs    username=video,password=V!d30pass,uid=plex,gid=plex,x-systemd.automount,_netdev  0       0

Then mount it for real:

    sudo mount -a
    ls -lah /mnt/media

It *should* now persist over a reboot. Try rebooting and check again, just to make sure.

Links:

* <https://wiki.ubuntu.com/MountWindowsSharesPermanently>
* <https://askubuntu.com/a/1295943>