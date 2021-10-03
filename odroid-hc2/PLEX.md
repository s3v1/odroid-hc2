# Plex

Plex is a nice video server that has support for the CPU. The Odroid HC2 has enough CPU power for light realtime transcoding.

## Repo install

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

Test it out

    sudo mkdir /mnt/media
    sudo mount -t cifs -o 'username=video,password=V!d30pass,uid=plex,gid=plex,x-systemd.automount,_netdev' //nas/media/video //mnt/media

    ll /mnt/media

To unmount again:

    sudo umount -f /mnt/media

To make it permanent, add a line to /etc/fstab:

    sudo nano  /etc/fstab

Like this:

    //nas/media/video                               /mnt/media      cifs    username=video,password=V!d30pass,uid=plex,gid=plex,x-systemd.automount,_netdev  0       0

Then mount it for real:

    sudo mount -a

and test it:

    ll /mnt/media

It *should* now persist over a reboot.

Links:

* <https://wiki.ubuntu.com/MountWindowsSharesPermanently>
* <https://askubuntu.com/a/1295943>
