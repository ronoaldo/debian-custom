#!/bin/bash
echo "Updating full build log ..."
gsutil cp /var/log/startupscript.log gs://ronoaldo/ronolinux/logs/build-$(date +%Y%m%d-%H%M%S).log
