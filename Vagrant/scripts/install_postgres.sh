#!/bin/bash

# script: install_postgres
# system: centos
#
# description:
# Script adds Postgres's repository and installs database engine

echo "Privisionning from: \"install_postgres.sh\""

yum -y install postgresql-server.x86_64

systemctl enable postgresql

echo "Done."
