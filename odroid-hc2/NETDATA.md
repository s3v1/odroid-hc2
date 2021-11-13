# Netdata monitoring

Netdata is a nice monitoring tool.

[Here's how to install the client](https://learn.netdata.cloud/docs/get-started#install-on-linux-with-one-line-installer-recommended)

The short version is:

    bash <(curl -Ss https://my-netdata.io/kickstart.sh) --stable-channel --disable-telemetry

It may take a while, since there's no precompiled version for this platform and it has to compile all the agents. After installation [You can view local netdata on http://hostname:19999](http://ohc21:19999) or add it to your "war room" at <https://app.netdata.cloud>
