#!/bin/bash

# script: create_system_user
#
# args:
# username - user to add
# password - password for user (decrypted)
# salt - salt for password encryption
#
# description:
# script creates new user account in system with
# bash shell and standard user directory in /home
#

echo "Provisioning from: \"create_system_user.sh\""

if [ "$#" -ne 3 ]; then
  echo "Wrong number of arguments."
  echo "Usage: "$0" username password salt"
else
  echo Creating system user: \"$1\" with password: \"$2\" and salt: \"$3\"
  useradd -m -s /bin/bash -p $(perl -e'print crypt('$2', '$3')') $1
fi

echo "Done."
