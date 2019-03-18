# Dockerized DHCP Server Configuration for Network Builds

This repo was forked from [networkboot/docker-dhcpd](https://github.com/networkboot/docker-dhcpd).
See the [original README](SRC-README.md) for more details.

**Very Important Note**

Since this is forked from another repo, make certain you are using the `pts-master` branch (instead of `master`). The `master` branch needs to remain in-sync with the original source.

How to use this:

1. Install [Docker](https://www.docker.com/) if you haven't already
1. Clone this repo
1. Build the Docker container: `./build`
1. Update the DHCP Server Configuration [data/dhcpd.conf](data/dhcpd.conf) for the network build you are working on
1. Setup your network stack and connect your laptop using a wired connection
1. Configure the LAN connection on your laptop with a static IP within the Management Network subnet (e.g. 172.16.1.150).
1. Run the Docker container: `./run`
1. When you are finished, stop and remove the container with **Ctrl-C**


## Updating the DHCP Server Configuration
The configuration provided in the repo assumes the standard network layout.
If the build you are working on calls for a different layout, be certain to
revise this configuration **before** running the container.

If a Unifi Cloud Key is part of the build, be certain to replace the MAC Address
in the `host uck` stanza.
=======
The most common use-case is to provide DHCP service to the host network of
the machine running Docker.  For that you need to create a configuration for
the DHCP server, start the container with the `--net host` docker run
option and specify the network interface you want to provide DHCP service
on.

 1. Create `data` folder.
 2. Create `data/dhcpd.conf` with a subnet clause for the specified
    network interface.  If you need assistance, you can run
    `docker run -it --rm networkboot/dhcpd man dhcpd.conf` for a description
    of the configuration file syntax.
 3. Run `docker run -it --rm --init --net host -v "$(pwd)/data":/data networkboot/dhcpd eth0`.
    `dhcpd` will automatically start and display its logs on the console.
    You can press Ctrl-C to terminate the server.

A simple `run` script is also included which makes it quick to iterate on a
configuration until you're satisfied.

Notes
=====

The entrypoint script in the docker image takes care of running the DHCP
server as the same user that owns the `data` folder.  This ensures that the
permissions on the files inside the `data` folder is kept consistent.  If
the `data` folder is owned by root, dhcpd is run as the normal dhcpd user.

If you forget to run the docker container with the `--net host` option a
warning will be emitted informing you that you've probably forgotten it.

If a `/data` volume is not provided with a `dhcpd.conf` inside it, the
container will exit early with an error message.

An additional Dockerfile has been added that allows building an image with
the tag `:ldap` which contains the **isc-dhcp-server-ldap** package in
addition to the normal DHCP server package.  Other than that it behaves in
exactly the same way as the `:latest` tag.  Utility build and run scripts
have also been added to work with this variant.

Acknowledgements
================

This image uses the following software components:

 * Ubuntu Linux distribution from <https://www.ubuntu.com>.
 * ISC DHCP server from <https://www.isc.org/downloads/dhcp/>.
 * Dumb-init from <https://github.com/Yelp/dumb-init>.

Copyright & License
===================

This project is copyright 2017 Robin Smidsrød <robin@smidsrod.no>.

It is licensed under the Apache 2.0 license.

See the file LICENSE for full legal details.
