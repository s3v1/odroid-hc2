# Samba

Samba enables filesharing. Here we'll make a share for videos that is read/write for everyone/guests

## Prerequisites

We assume the OS is installed according to the [Armbian](./ARMBIAN.md) guide.

## Install

Prepare a file share

    sudo mkdir -p /data/video
    sudo chown -R nobody:video /data/video
    sudo chmod -R 775 /data/video
    sudo chmod g+s /data/video

Install samba

    sudo apt install samba -y

Edit config:

    sudo nano /etc/samba/smb.conf

Add this to the end of the text file:

    [video]
        comment = Video files
        browsable = yes
        path = /data/video
        public = yes
        writable = yes
        guest ok = yes

And then save (ctrl-x) and then run:

    testparm

To check if the config has syntax errors.

The share should be browseable from a windows machine.
