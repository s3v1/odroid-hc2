# Docker

This guide is for getting *rootless* docker to work. I much prefer it over the as-root way of running docker

## Prerequisites

We assume the OS is installed according to the [Armbian](./ARMBIAN.md) guide.

The kernel must be at least 5.4 for docker rootless to work.

## Regular docker install

First we have to install the normal as-root docker. Later we will convert it to "rootless"

The script at https://get.docker.com doesn't work so we will have to 
follow the standard guide: <https://docs.docker.com/engine/install/ubuntu/>

Stop when you have succesfully run the "hello-world" step.

## Rootless docker

To convert to *rootless* docker, you can modify the docker installation you just made. We'll just follow [official guide to rootless docker](https://docs.docker.com/engine/security/rootless/)... but that doesn't fully work, for example it doesn't include 'slirp4netns', so we had to change the steps. Here are the highlights:

First some pre-requisites:

    sudo apt-get install -y dbus-user-session docker-ce-rootless-extras uidmap slirp4netns

Then stop and disable the service:

    sudo systemctl disable --now docker.service docker.socket

Do the rootless setup:

    dockerd-rootless-setuptool.sh install

As the script tells you at the end... enable service lingering to enable rootless docker to run when you're not logged in. If you don't it will pause the demons if you're not connected via terminal:

    sudo loginctl enable-linger $USER

Also, you should listen to the script and add these variables to your environment:

    echo 'export PATH=/usr/bin:$PATH' >>~/.bashrc
    echo 'export DOCKER_HOST=unix:///run/user/1000/docker.sock' >>~/.bashrc

and then reload the ~/.bashrc like this:

    . ~/.bashrc

It should just work now. Try it out:

    docker pull hello-world && time docker run --rm hello-world
    docker pull ubuntu:20.04 && time docker run --rm -it -v "$PWD:/wrk" -w "/wrk" ubuntu:20.04 touch test.txt

You'll notice that the 'test.txt' file is now written as your own user, making it much easier to work with files using docker.

## Run rootless docker on ports <= 1024

To run on privileged ports when using docker rootkless you need to allow it, see <https://docs.docker.com/engine/security/rootless/#exposing-privileged-ports>

    sudo setcap cap_net_bind_service=ep $(which rootlesskit)

and then

    systemctl --user restart docker

to restart the docker daemon

## Docker compose

[Docker compose v2](https://docs.docker.com/compose/cli-command/) is great for managing complex docker setups. It's a new version that is a plugin to the main docker command, rather than a wrapper. It's already in the repos of the OS, so you can just use install it like this:

    sudo apt-get install docker-compose-plugin -y

and then test it like this:

    docker compose version

In other words, compose is now a plugin to the main docker command, instead of a separate command. So you call it using 'docker compose' without the dash '-', instead of 'docker-compose' like you used to.
