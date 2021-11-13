# Jellyfin

Jellyfin is a video server, similar to Plex or Emby. However, It's all open-source nad has support for playing DVD ISO's too.

[Jellyfin homepage](https://jellyfin.org)

## Prerequisites

We assume the OS is installed according to the [Armbian](./ARMBIAN.md) guide.

## Install

Since the OS is based on Ubuntu, not debian we use that guide:

[Installation guide for Ubuntu](https://jellyfin.org/docs/general/administration/installing.html#ubuntu)

Here are the highlights at the time of writing:

    sudo apt install apt-transport-https
    sudo add-apt-repository universe
    wget -O - https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | sudo apt-key add -
    echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/ubuntu $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list
    sudo apt update
    sudo apt install jellyfin -y

Service control:

    sudo service jellyfin status
    sudo systemctl restart jellyfin
    sudo /etc/init.d/jellyfin stop

## Usage

[Quick start guide](https://jellyfin.org/docs/general/quick-start.html)

Access the web interface at http://yourhostname:8096

## Uninstall

To uninstall, do this:

    sudo apt remove jellyfin-server jellyfin-web jellyfin -y
    sudo rm /etc/apt/sources.list.d/jellyfin.list
    sudo apt autoremove -y
    sudo apt update

## Troubleshooting

If you forget the password, go to this:

    http://yourhostname:8096/web/index.html#!/forgotpassword.html

to reset it. Even works for the admin user.
