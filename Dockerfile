FROM ubuntu:xenial

MAINTAINER Robin Smidsrød <robin@smidsrod.no>

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y update \
 && DEBIAN_FRONTEND=noninteractive apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install apt-utils \
 && DEBIAN_FRONTEND=noninteractive apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" dist-upgrade \
 && DEBIAN_FRONTEND=noninteractive apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install isc-dhcp-server man python3 \
 && DEBIAN_FRONTEND=noninteractive apt-get -q -y autoremove \
 && DEBIAN_FRONTEND=noninteractive apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/*

COPY util/my_init.py /sbin/my_init
COPY util/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
