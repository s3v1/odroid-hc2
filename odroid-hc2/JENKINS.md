# Jenkins

 [Jenkins](https://www.jenkins.io/) is a nice server for devops/CI/CD automation.

## Prerequisites

We assume the OS is installed according to the [Armbian](./ARMBIAN.md) guide.

Then install this first

    sudo apt install openjdk-11-jdk-headless -y

Since Jenkins REQUIRES Java 8 or 11. Any other version will not work

## Install Jenkins

Then follow guide at <https://pkg.jenkins.io/debian-stable/>:

    wget -q -O - 'https://pkg.jenkins.io/debian-stable/jenkins.io.key' | sudo apt-key add - 
    sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update && sudo apt-get install jenkins -y

Jenkins is now installed

## Create worker

It's good practice to do jenkins builds using workers, rather than the server process itself.

While having the worker on another machine or in a docker container is ideal... If you only have one machine, it's still a good idea to have separate accounts/login for the master and the workers.

Here's how to make a worker account:

    sudo adduser jenwork --shell /bin/bash

You'll be asked for password and some more info and then the user is all set.

## Use Jenkins

By default Jenkins runs on localhost:8080

You should be able to see the initial admin password, by running:

    sudo cat /var/lib/jenkins/secrets/initialAdminPassword

## Modify memory usage

Increase or decrease memory by editing this file:

    sudo nano /etc/default/jenkins

The default is:

    #JAVA_ARGS="-Xmx256m"

As an example you can adjusts memory and let it use G1GC it by using:

    JAVA_ARGS="-Xmx512m -XX:+UseG1GC"

Then restart the service:

    sudo service jenkins stop
    sudo service jenkins start
