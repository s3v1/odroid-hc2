# Podman

Podman is an alternative to Docker, that runs entirely in user space. It requires no daemon and no root access.

[Podman homepage](https://podman.io/)

## Pre-requisites

You should check the [Armbian OS Setup guide](README.md) first.

## Upgrade kernel

You can run docker, but Upgrade Kernel to 5.x

You can upgrade the kernel to 5.x, run armbian-config

	sudo armbian-config

	* Choose "System"
	* Choose "Other", then "Yes, I understand"
	#* Choose the latest "linux-image-current" kernel
	* Choose Armbian 21.05.6 Focal kernel

# Reboot

	sudo reboot
	


PODMAN time

https://podman.io/getting-started/installation

https://build.opensuse.org/package/show/devel:kubic:libcontainers:stable/podman

	. /etc/os-release
	echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
	curl -L "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key" | sudo apt-key add -
	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y install podman slirp4netns
	sudo ln -s /run/podman/podman.sock /var/run/docker.sock	##Symlink to cheat compose
	
## Test podman

	podman run --rm hello-world

	alias docker=podman

* Test docker

	docker pull hello-world && time docker run --rm hello-world
	docker pull ubuntu:20.04 && time docker run --rm -it -v "$PWD:/wrk" -w "/wrk" ubuntu:20.04 touch test.txt

* Verify that test.txt is owned by your user, not root.

	ls -lah

	
