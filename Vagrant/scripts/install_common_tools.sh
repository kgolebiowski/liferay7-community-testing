#!/bin/bash

# script: install_common_tools
# system: centos
#
# description:
# Installs latest version of common tools from repository
#

echo "Provisioning from: \"install_common_tools.sh\""
yum -y install perl unzip mc vim telnet

echo "Installing packages from CentOS REPO"
yum -y install epel-release

echo "Installing packages from EPEL REPO"
yum -y install htop apachetop

echo "Done."
