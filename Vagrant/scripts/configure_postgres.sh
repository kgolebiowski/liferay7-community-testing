#!/bin/bash

# script: install_postgres
# system: centos
#
# description:
# Script configure access to Postgres

echo "Provisioning from: \"configure_postgres.sh\""

if [ "$#" -ne 3 ]; then
  echo "Wrong number of arguments."
  echo "Usage: "$0" <db_user> <db_password> <db_name_to_create>"
else
  DB_USER=$1
  DB_PASS=$2
  DB_NAME=$3

  PG_CONF="/var/lib/pgsql/data/postgresql.conf"
  PG_HBA="/var/lib/pgsql/data/pg_hba.conf"
  PG_DIR="/var/lib/pgsql/data/"

  postgresql-setup initdb

  systemctl start postgresql

  # Create DB and user/password
  # grant access ('a+x') for user 'postgres' (effectively: everyone) to 'vagrant' user home dir for SELinux not complain during admin operations
  chmod o+x /home/vagrant
  sudo -u postgres createuser --superuser --createdb --createrole $DB_USER
  sudo -u postgres createdb $DB_NAME
  sudo -u postgres psql -d $DB_NAME -c "ALTER ROLE $DB_USER WITH PASSWORD '$DB_PASS'"
  sudo -u postgres psql -d $DB_NAME -c "ALTER DATABASE $DB_NAME OWNER TO $DB_USER"
  # revoke access to vagrant user home dir from others
  chmod o-x /home/vagrant

  # Edit postgresql.conf to change listen address to '*':
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

  # Append to pg_hba.conf to add password auth:
  sudo sed -r -i "s/^(local[[:space:]]+all[[:space:]]+all[[:space:]]+)peer.*$/\1 ident/" "$PG_HBA"
  sudo sed -r -i "s/^(host[[:space:]]+all[[:space:]]+all[[:space:]]+127\.0\.0\.1\/32[[:space:]]+ident).*$/#\1/" "$PG_HBA"
  sudo sed -r -i "s/^(host[[:space:]]+all[[:space:]]+all[[:space:]]+\:\:1\/128[[:space:]]+ident).*$/#\1/" "$PG_HBA"
  echo "host all all ::1/128 md5" | sudo tee --append $PG_HBA
  echo "host all all 127.0.0.1/32 md5" | sudo tee --append $PG_HBA

  # Explicitly set default client_encoding
  echo "client_encoding = utf8" | sudo tee --append "$PG_CONF"

  systemctl restart postgresql
fi

echo "Done."
