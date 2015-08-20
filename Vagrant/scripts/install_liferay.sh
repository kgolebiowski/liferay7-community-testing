#!/bin/bash

# script: install_liferay
#
# description:
# Script installs liferay portal

echo "Provisioning from: \"install_liferay.sh\""

if [ "$#" -ne 2 ]; then
  echo "Wrong number of arguments."
  echo "Usage: "$0" <liferay_user> <liferay_zip_archive>"
else

	LR_USER=$1
	LR_FILE=$2

	if [ -f /vagrant/resources/installs/$LR_FILE ]; then
		echo "Liferay archive exists, unzipping..."
		unzip -q /vagrant/resources/installs/$LR_FILE -d /home/$LR_USER/

    LR_PATH=`find /home/$LR_USER/ -type d -iname 'liferay-portal*'`
    echo "Liferay installed in: \"$LR_PATH\""

    if [ -d $LR_PATH ]; then
  	   ln -s $LR_PATH /home/$LR_USER/liferay

       if [ -f /vagrant/resources/configs/portal-ext.properties ]; then
         cp /vagrant/resources/configs/portal-ext.properties /home/$LR_USER/liferay
       fi

       sudo chown -R $LR_USER:$LR_USER /home/$LR_USER/
    fi

	else
		echo "Liferay archive not exists, skipping"
	fi

fi
echo "Done."
