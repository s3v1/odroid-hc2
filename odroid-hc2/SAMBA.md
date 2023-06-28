# Samba

Samba enables filesharing. Here we'll make a share for videos that is read/write for everyone/guests

## Prerequisites

We assume the OS is installed according to the [Armbian](./ARMBIAN.md) guide.

## Install

Prepare a file share

    sudo mkdir -p /data/video
    sudo chown -R nobody:video /data/video
    sudo chmod -R 775 /data/video
    sudo chmod -R g+s /data/video

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

## Map a SMB share on another machine

Let's mount a SMB share on another machine, so you can have a big NAS but do the plex transcoding on the Odroid HC2. First instal the tools:

    sudo apt install cifs-utils -y

Make some credentials

    echo >/home/$USER/.smbcredentials-guest "username=guest"
    echo >>/home/$USER/.smbcredentials-guest "password="

Mount using credentials file, so you don't have to put your password in /etc/fstab:

    sudo mkdir -p /mnt/video
    sudo mount -t cifs -o "credentials=/home/$USER/.smbcredentials-guest,iocharset=utf8,gid=1000,uid=1000,file_mode=0777,x-systemd.automount,_netdev" //video/video //mnt/video
    ll /mnt/video

To unmount again:

    sudo umount -f /mnt/media

Other example - using password:

    sudo mkdir /mnt/media
    sudo mount -t cifs -o 'username=video,password=<yourpasswordhere>,gid=1000,uid=1000,file_mode=0777,x-systemd.automount,_netdev' //nas/media/video //mnt/media
    ll /mnt/media

Other example - using guest with no password:

    sudo mkdir -p /mnt/video
    sudo mount -t cifs -o 'username=guest,password=,iocharset=utf8,gid=1000,uid=1000,file_mode=0777,x-systemd.automount,_netdev' //video/video //mnt/video
    ll /mnt/video

Example: Make some other credentials

    echo >/home/$USER/.smbcredentials-sv "username=sv"
    echo >>/home/$USER/.smbcredentials-sv "password=<yourpasswordhere>"
    nano /home/$USER/.smbcredentials-sv # Change the password

To make it permanent, add a line to /etc/fstab:

    sudo nano  /etc/fstab

Like this:

    //video/video       /mnt/video  cifs    credentials=/home/sv/.smbcredentials-guest,iocharset=utf8,gid=1000,uid=1000,file_mode=0777,x-systemd.automount,_netdev  0   0
    //nas/shared        /mnt/shared  cifs    credentials=/home/sv/.smbcredentials-sv,iocharset=utf8,gid=1000,uid=1000,file_mode=0777,x-systemd.automount,_netdev  0   0 

Then mount it for real:

    sudo mount -a

and test it:

    ll /mnt/media

It *should* now persist over a reboot.

Links:

* <https://wiki.ubuntu.com/MountWindowsSharesPermanently>
* <https://askubuntu.com/a/1295943>