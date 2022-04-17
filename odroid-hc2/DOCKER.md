# Docker

This guide is for normal *as-root* docker. I was unable to get rootless docker running for the Odroid HC2

## Prerequisites

We assume the OS is installed according to the [Armbian](./ARMBIAN.md) guide.

## Official Guide

Guide: <https://docs.docker.com/engine/install/ubuntu/>

However, there's no armhf release for "focal", so you need to replace anywhere it says "$(lsb_release -cs)" with "bionic". That'll use the one for 18.04, which works fine on 20.04/focal too.

See that tip in this bug report: <https://github.com/docker/for-linux/issues/1035#issuecomment-905133113>

## Highlights

    sudo apt-get remove docker docker-engine docker.io containerd runc -y
    sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=armhf signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu bionic stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y

## Test with sudo

    sudo docker run --rm hello-world

## Add user to group

    sudo usermod -aG docker $USER
    newgrp docker

## Test without sudo

    docker run --rm hello-world

## Timing

There's a bit of startup delay, when running docker. It makes even the smallest commmands take 2-3 seconds, so expect results in that timerange.

    docker pull hello-world && time docker run --rm hello-world
    docker pull ubuntu:20.04 && time docker run --rm -it -v "$PWD:/wrk" -w "/wrk" ubuntu:20.04 touch test.txt

Since, it's running as root you'll notive that the 'test.txt' file we just made is owned by root. See below for instructions on how to convert to a rootless installation.

Once it's up and running, performance is as expected, close to native. However, there's a startup time of about 3 seconds added to every command. So if you run a server, it won't matter much, but if you like to dockerize individual commands, you'll feel slowed down. I don't think it's due to arm32 or the SBC in general, since I get a startup delay on my powerful x64 laptop, it's just a lot shorter. My guess is that it's just due to CPU speed. So, if you get an SBC with faster cores, you'll probably get better startup delay times.

## Images

Most images are not made for armhf. Often you'll find images for arm, but they're arm64, like the Raspberry Pi, but not armhf, like the odroid-hc2. Many base OS images have the suppoort however, so you may have to explore how to make docker images yourself for this platform, aka arm32/v7.

## Rootless docker

If you want *rootless* docker, you can modify the docker installation you just made. We'll just follow [official guide to rootless docker](https://docs.docker.com/engine/security/rootless/)... but that doesn't fully work, for example it doesn't include 'slirp4netns', so we had to change the steps. Here are the highlights:

    sudo systemctl disable --now docker.service docker.socket
    sudo apt-get install -y dbus-user-session docker-ce-rootless-extras uidmap slirp4netns
    dockerd-rootless-setuptool.sh install

Then add these variables to your environment:

    echo 'export PATH=/usr/bin:$PATH' >>~/.bashrc
    echo 'export DOCKER_HOST=unix:///run/user/1000/docker.sock' >>~/.bashrc

and then reload the ~/.bashrc like this:

    . ~/.bashrc

It should just work now. Try it out:

    docker pull hello-world && time docker run --rm hello-world
    docker pull ubuntu:20.04 && time docker run --rm -it -v "$PWD:/wrk" -w "/wrk" ubuntu:20.04 touch test.txt

You'll notice that the 'test.txt' file is now written as your own user, making it much easier to work with files using docker.
