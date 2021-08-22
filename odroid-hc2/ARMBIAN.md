# Armbian

Armbian is based on Debian or Ubuntu and has nice support for a lot of ARM-based SBC's

[Armbian page for the HC2](https://www.armbian.com/odroid-hc1/)

## Get and write the OS image

Get an image from the armbian page listed above.

I suggest you get the default **Armbian Focal**, which is based on Ubuntu LTS 20.04, It currently uses the 4.x kernal and has the best support and compatibility:

[Here is a direct link to download the image](https://redirect.armbian.com/odroidxu4/Focal_legacy)

Write it the SD-card, using something like [Balena Etcher](https://www.balena.io/etcher/).

Then insert the SD-Card and plug in the power to start the machine.

## Login for the first time

The defaults are:

* Hostname: odroidxu4
* Log in: root
* Password: 1234

You can login with:

    ssh root@odroidxu4

...and use the password above. As soon as you login, you are prompted to change this password (remember, it's still using US-Keyboard setting at this point).

### Create normal/non-root user

Right after changing the password, you are asked to create a normal user-account for your everyday tasks. It will have *sudo* rights.

* **Make sure to NOT select using local language**

When it says *"Set user language based on your location? [Y/n]"* - **SAY NO!!**

## Initial setup of the OS

Here comes a few steps that are good to do in the beginning, to get a good start on a freshly installed OS.

### Update and upgrade

Once you've created the user, you'll still be logged in as *root*. Run these commands to update the OS:

    sudo apt update && sudo apt upgrade -y && sudo apt-get dist-upgrade && sudo apt autoremove -y

### Install some tools

Install some of my favourite tools and utilities. Avahi announces hostname on the network. Glances is a good alternative to htop.

    sudo apt install -y git nano htop mc build-essential glances curl avahi-daemon pigz

### Change hostname

To change the hostname, run this command:

    sudo hostnamectl set-hostname odroid-hc2

You can optionally change the name in /etc/hosts to set the hostname to 127.0.0.1, if you want to use it locally:

## Set HC2 optimized config

"This board is stripped Odroid XU4 and we use the same images, however, we provide a specially optimized config (for kernel 4.14.y or higher) which has to be applied manually. This results in shorter boot time and lower consumption. Run armbian-config utility and go to section system -> DTB and select optimized board configuration for Odroid HC1. The same config is valid for HC2 and MC1."

    sudo armbian-config

* Choose "System"
* Choose "DTB"
* Choose "Odroid HC1/HC2"

### OPTIONAL: Install HDD/SSD

You *can* install the root file system to the HDD/SSD (but you don't have to). That will save wear and tear on the SD-card, probably give you much more space in "/" and maybe enven make it faster to run. The boot partition will remain on the SD-card, so you'll still need to tleave it in the machine. The Odroid-HC2 cannot boot purely from the HDD/SSD.

Here are some guides, but you can skip them and just read the steps below.

* Delete partitions, see how here <https://phoenixnap.com/kb/delete-partition-linux>
* Create a single partition, ext4. See <https://linuxize.com/post/fdisk-command-in-linux/>
* [Install to harddisk/SSD using this guide](https://docs.armbian.com/User-Guide_Getting-Started/#how-to-install-to-emmc-nand-sata-usb)

To wipe all partitions and create a new one on the drive, first run:

    sudo fdisk /dev/sda

* Then use the **"d"** command in the fdisk tool to delete the partions, one-by-one if you have several. You'll need to run the **"d"** command once for each partition
* Use the **"g"** command to create a new GPT partition table
* USe the **"n"** command to create a new partion. Accept the defaults.
* Use the **"w"** command to write changes to disk and exit.

You're now done with fdisk.

Then run:

    nand-sata-install

...and then follow the obvious path. I prefer **ext4** over btrfs, for maximum compatibility.

## Reboot

To have all the updates take effect:

    reboot

Wait couple of minutes, until it's had a chance to restart.

## Configuring and using the new user

From now on, you should start using the new user you created earlier, instead of *root*

### Login

SSH login as the new user, in my case 'sv':

    ssh sv@odroid-hc2

### Set public key for the regular user

Then add you own public key, in my case:

    mkdir $HOME/.ssh
    chmod 700 $HOME/.ssh
    echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEOUWK5GhGu42n434IH2e6wQXrP5SzZLROdSZpEyalB6 myemail@domain.com' >> $HOME/.ssh/authorized_keys
    chmod -R 600 $HOME/.ssh/*

### Add sudo without a password

With great power comes great responsibility.
If you feel lazy and don't care about security, you set the user to not need a password for sudo. This is not recommended, but here's the recipe if you like living dangerously:

    echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER

### Unattended upgrades

You can configure unattended-upgrades on ubuntu/debian systems to also update normal packages, instead of just security packages.

It's not required and it's not a good idea for production systems, but nice for something like your personal jenkins or plex server (see later sections)

Here is the guide: [How to Enable Unattended Upgrades on Ubuntu/Debian](https://haydenjames.io/how-to-enable-unattended-upgrades-on-ubuntu-debian/)

### All done with OS

Now the OS is configured and you are ready to start using the server.
Check out these other OPTIONAL services:

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

### Access the server

Just like any plex install, just [Access the plex web interface](http://plex:32400/web)

## Jenkins

 [Jenkins](https://www.jenkins.io/) is a nice server for devops/CI/CD automation.

### Pre-requisites for Jenkins

You install this first

    sudo apt install openjdk-11-jdk-headless -y

### Install Jenkins

Then follow guide at <https://pkg.jenkins.io/debian-stable/>:

  wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
  deb https://pkg.jenkins.io/debian-stable binary/
  sudo apt-get update
  sudo apt-get install jenkins -y

Jenkins is now installed

### Use Jenkins

By default Jenkins runs on localhost:8080

You should be able to see the initial admin password, by running:

    cat /var/jenkins_home/secrets/initialAdminPassword
