#!/bin/bash

# script: install_liferay
#
# description:
# Script installs liferay portal

echo "Provisioning from: \"install_liferay.sh\""

if [ "$#" -ne 3 ]; then
  echo "Wrong number of arguments."
  echo "Usage: "$0" <liferay_user> <liferay_zip_archive> <lr_download_path>"
else
	LR_USER=$1
	LR_FILE=$2
  LR_DOWNLOAD_PATH=$3

  INSTALLS_FOLDER=/vagrant/resources/installs
  CONFIGS_FOLDER=/vagrant/resources/configs

	if [ -f $INSTALLS_FOLDER/$LR_FILE ]; then
    echo "Liferay archive has already been downloaded."
  else
    echo "Liferay archive not exists, downloading..."
    wget $LR_DOWNLOAD_PATH -O $INSTALLS_FOLDER/$LR_FILE
  fi

	echo "Unzipping..."
	unzip -q $INSTALLS_FOLDER/$LR_FILE -d /home/$LR_USER/

  LR_PATH=`find /home/$LR_USER/ -type d -iname 'liferay-portal*'`
  echo "Liferay installed in: \"$LR_PATH\""

  if [ -d $LR_PATH ]; then
	   ln -s $LR_PATH /home/$LR_USER/liferay

     if [ -f $CONFIGS_FOLDER/liferay/portal-ext.properties ]; then
       echo "Copying portal-ext.properties to \"$LR_PATH\""
       cp $CONFIGS_FOLDER/liferay/portal-ext.properties $LR_PATH/
     fi

     echo "Copying setenv.sh to \"$LR_PATH/tomcat-7.0.62/bin/\""
     cp $CONFIGS_FOLDER/liferay/tomcat/bin/setenv.sh $LR_PATH/tomcat-7.0.62/bin/

     sudo chown -R $LR_USER:$LR_USER /home/$LR_USER/
  fi
fi
echo "Done."
