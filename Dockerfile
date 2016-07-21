FROM ubuntu:xenial

MAINTAINER Robin Smidsrød <robin@smidsrod.no>

RUN apt-get -q -y update \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" dist-upgrade \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install isc-dhcp-server man python3\
 && apt-get -q -y autoremove \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/*

COPY util/my_init.py /sbin/my_init
COPY util/entrypoint.sh /entrypoint.sh

RUN rmdir /etc/dhcp/ddns-keys \
 && ln -s /data/ddns-keys /etc/dhcp/ddns-keys

ENTRYPOINT ["/entrypoint.sh"]
