#!/bin/bash

# script: timezone.sh
# system: centos
#
# description:
# Changes system timezone
#

echo "Provisioning from: \"timezone.sh\""

echo "Setting timezone to Europe/Warsaw:"
timedatectl set-timezone Europe/Warsaw
timedatectl

echo "Setting Locale to pl_PL.UTF8:"
localectl set-locale LANG=pl_PL.UTF8
localectl status

echo "Done."
