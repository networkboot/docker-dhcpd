# Dockerized DHCP Server Configuration for Network Builds

This repo was forked from [networkboot/docker-dhcpd](https://github.com/networkboot/docker-dhcpd).
See the [original README](SRC-README.md) for more details.

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
