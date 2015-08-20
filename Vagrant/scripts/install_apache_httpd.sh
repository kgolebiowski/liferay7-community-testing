#!/bin/bash

# script: install_apache_httpd
# system: centos7
#
# description:
# Script installs latest Apache HTTPD
#

echo "Provisioning from: \"install_apache_httpd.sh\""

# Install fresh package
sudo yum -y install httpd.x86_64

# Start at boot time
sudo /usr/bin/systemctl enable httpd

# Start daemon
sudo /usr/bin/systemctl start httpd

echo "Done."
