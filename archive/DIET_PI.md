# DietPi

DietPi is based on Debian and has nice support for a lot of ARM-based SBC's, even though it has "pi" in the name.

[DietPi homepage](https://dietpi.com)

## Get and write the OS image

Get an image for you SBC from the page listed above.

Write it the SD-card, using something like [Balena Etcher](https://www.balena.io/etcher/).

Then insert the SD-Card and plug in the power to start the machine.

## Login for the first time

The defaults are:

* Hostname: dietpi
* Log in: root
* Password: dietpi

You can login with:

    ssh root@dietpi

...and use the password above. As soon as you login, there's a "first setup" flow. Just follow along for a bit, then:

* Choose a new default software password, when asked
* Choose a new unix user password, when asked
* Say "OK" to disable serial console

After some time, you can use the dietpi config system to install software

I suggest you don't choose anything for now. Choose install at the bottom and accept the "do you only want minimal" prompt. It'll start installing the defaults.

After a bit it will let you into the command prompt.

You can then run:

    sudo dietpi-software

To configure the system.

...

## Post-scriptum

I stopped using dietpi pretty quickly. It worked fine, I didn't have any issues. The software config tools/installeres were fine and I got a few things running. There was a missing feature, since it could not install / (root) to a harddrive, only the user files, but that was not why I stopped. I guess, maybe the custom scripting and setup was not my flavor. I think I prefer the default installers and then having th ehassle of setting it up myself. Or maybe it was because it was debian instead og ubuntu based? Not sure, just felt subtly wrong.
