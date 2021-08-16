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

## Access the server

Just like any plex install, just [Access the plex web interface](http://plex:32400/web)