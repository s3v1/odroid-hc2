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

Once it's up and running, performance is as expected, close to native. Just like an x86 system

## Images

Most images are not made for armhf. Often you'll find images for arm, but they're arm64, like the Raspberry Pi, but not armhf, like the odroid-hc2

You may have to learn how to make these images yourself if you need them.
