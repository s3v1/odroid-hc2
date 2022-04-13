# Pi-hole + unbound

Running **unbound** dns, will you do your own highlevel DNS lookups and avoid using DNS services like Googles 8.8.8.8 and Cloudflares 1.1.1.1 or your ISP

Running Pi-hole will let you run a nice blacklist and avoid advertisement as well as some malware.

## Pre-requisites

- The server has a fixed IP or a DHCP reservation

## Install unbound

Follow the [unbound install guide](https://docs.pi-hole.net/guides/dns/unbound/) on pi-hole's homepage. Here's a short version:

    sudo apt install -y unbound

Then edit the config file:

    sudo nano /etc/unbound/unbound.conf.d/pi-hole.conf

Then:

- Copy and paste the config section from the homepage

Restart and validate:

    sudo service unbound restart
    dig pi-hole.net @127.0.0.1 -p 5335

Validate DNSSEC:

    dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5335 | grep SERVFAIL
    dig sigok.verteiltesysteme.net @127.0.0.1 -p 5335 | grep NOERROR

## Install pi-hole

Follow the [pihole install guide](https://docs.pi-hole.net/main/basic-install/) on pi-hole's homepage

Here's a short version:

    curl -sSL https://install.pi-hole.net | bash

During the installation, choose the defaults, **EXCEPT** when it asks for upstream DNS.
You should tell pi-hole to use unbound at this time by:

- Setting the custom upstream DNS to  **127.0.0.1#5335**

At the end, you should:

- Note down the web adress of the admin interface
- Note down the admin interface password

For example 'http://192.168.86.190/admin' and 'QDGfGDi2'

## Removing/resetting the admin password

Reset the password like this:

    pihole -a -p

## Update pi-hole

Update the pihole like this:

    pihole -up
