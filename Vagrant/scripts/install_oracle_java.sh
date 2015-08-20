#!/bin/bash

# script: install_oracle_java
# system: centos
#
# description:
# Script installs Oracle's Java 7 JDK

echo "Privisionning from: \"install_oracle_java.sh\""

if [ "$#" -ne 3 ]; then
  echo "Wrong number of arguments."
  echo "Usage: "$0" <java_major_version> <java_minor_version> <java_build_version>"
else

	J_MAJOR=$1
	J_MINOR=$2
	J_BUILD=$3

  INSTALLS_FOLDER=/vagrant/resources/installs

	JDK_RPM="jdk-"$J_MAJOR"u"$J_MINOR"-linux-x64.rpm"
	JDK_URL="http://download.oracle.com/otn-pub/java/jdk/"$J_MAJOR"u"$J_MINOR"-b"$J_BUILD"/jdk-"$J_MAJOR"u"$J_MINOR"-linux-x64.rpm"

	if [ -f $INSTALLS_FOLDER/$JDK_RPM ]
		then
		echo "Java JDK $JDK_RPM exists, installing..."
	else
		echo "Java JDK $JDK_RPM not exists, downloading..."
		wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O $INSTALLS_FOLDER/$JDK_RPM $JDK_URL
	fi

	yum -y --nogpgcheck localinstall $INSTALLS_FOLDER/$JDK_RPM

fi
echo "Done."
