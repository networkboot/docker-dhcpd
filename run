#!/bin/bash
pushd $(dirname $0) >/dev/null
data_dir="$(pwd)/data"
docker run -ti --rm --init --net host -v "$data_dir":/data networkboot/dhcpd "$@"
popd >/dev/null
