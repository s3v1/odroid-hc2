# Netdata monitoring

Netdata is a nice monitoring tool.

## Prerequisites

We assume the OS is installed according to the [Armbian](./ARMBIAN.md) guide.

## Install

[Here's how to install the client](https://learn.netdata.cloud/docs/get-started#install-on-linux-with-one-line-installer-recommended)

The short version is:

    wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh /tmp/netdata-kickstart.sh --stable-channel --disable-telemetry

It may take a while, just accept the defaults when asked. After installation [You can view local netdata on http://hostname:19999](http://hostname:19999) or add it to your "war room" at <https://app.netdata.cloud>
