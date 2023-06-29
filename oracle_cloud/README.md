

4 core CPU ARM64/ 24 GB rAM / 150 GB SSD
Ubuntu 22.04

#Connect

ssh ubuntu@selfhost.vilstrup.me

sudo adduser sv
sudo usermod -aG sudo sv
sudo su - sv

#    mkdir $HOME/.ssh
#    chmod 700 $HOME/.ssh
#    echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEOUWK5GhGu42n434IH2e6wQXrP5SzZLROdSZpEyalB6 #myemail@domain.com' >> $HOME/.ssh/authorized_keys
#    chmod -R 600 $HOME/.ssh/*

exit

#Copy keys from windows

C:\Users\sv>scp -r .ssh sv@selfhost.vilstrup.me:

#Reconnect

ssh sv@selfhost.vilstrup.me

chmod 700 $HOME/.ssh
chmod -R 600 $HOME/.ssh/*

mkdir ~/prj
cd ~/prj

git clone git@github.com:s3v1/selfhost.git




sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

#if new kernel
sudo reboot

sudo apt install -y git nano htop mc build-essential glances curl pigz unattended-upgrades zstd

sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
#uncomment   "${distro_id}:${distro_codename}-updates";

sudo nano /etc/apt/apt.conf.d/20auto-upgrades
#Add this line:
#    APT::Periodic::AutocleanInterval "7";



## Docker rootless
    #curl -fsSL https://get.docker.com/rootless -o get-docker.sh
    #sh get-docker.sh

sudo apt-get install -y uidmap
curl -fsSL https://get.docker.com/rootless | bash

sudo loginctl enable-linger sv
echo "export PATH=/home/sv/bin:\$PATH" >> ~/.bashrc && source ~/.bashrc

docker run --rm -it hello-world

