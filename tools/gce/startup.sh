#!/bin/bash

# This hook tells via HTTP that we are building,
# so we can trigger a build with aetools/vmproxy.
(while true ; do nc -l -c "echo 'HTTP/1.1 200 OK\r\n\r\nBuilding ...'" -p 80 ; done ) &

# Helper function to fetch project metadata
# Usage:
#   metadata key default-value
metadata() {
	_url="http://metadata.google.internal/computeMetadata/v1/project/$1"
	# Return the value found, or the default value if the metadata value does not exists
	if curl --fail -s "${_url}" -H 'Metadata-Flavor: Google' > /dev/null ; then
		curl --fail -s "${_url}" -H 'Metadata-Flavor: Google'
	else
		echo -n "$2"
	fi
}

# Install build dependencies
apt-get install --yes live-build approx librsvg2-bin mercurial git subversion curl rsync

# Fetch ssh key from metadata server
mkdir -p ~/.ssh
metadata attributes/buildd-private-key "" > ~/.ssh/id_rsa
metadata attributes/buildd-public-key  "" > ~/.ssh/id_rsa.pub
ssh-keyscan -H frs.sourceforge.net > ~/.ssh/known_hosts
chmod 0400 ~/.ssh/*

# Checkout build source
echo "Updating build scripts ..."
git clone git@bitbucket.org:ronoaldo/debian-custom.git || true
cd debian-custom && git pull
yes | tools/configure-local-apt-proxy

echo "Building ..."
tools/buildd --publish
echo "Build finished"

echo "Updating full build log ..."
gsutil cp /var/log/startupscript.log gs://ronoaldo/ronolinux/logs/build-$(date +%Y%m%d-%H%M%S).log

echo "Shutting VM down ..."
shutdown -h now
