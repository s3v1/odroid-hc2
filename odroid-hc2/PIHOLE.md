# Pi-hole

 [Pi-Hole](https://pi-hole.net/) is an ad-blocking and malware-blocking DNS server

## Prerequisites

We assume the OS is installed according to the [Armbian](./ARMBIAN.md) guide.

## Install

Then follow guide at [Pi-hole's install page](https://github.com/pi-hole/pi-hole/#one-step-automated-install):

    curl -sSL https://install.pi-hole.net | bash

You'll be asked a lot of questions by the installer. The defaults are fine... except:

* Note down the *admin* password. It's shown after the install

That's all, just access the server and configure your dns settings.
