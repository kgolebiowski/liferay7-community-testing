#!/bin/bash

# script: apply_mod_proxy
# system: centos
#
# description:
#
#

echo "Provisioning from: \"apply_mod_proxy.sh\""

echo "Removing default virtual host: /etc/httpd/conf.d/welcome.conf"
rm /etc/httpd/conf.d/welcome.conf

echo "Creating /etc/httpd/conf.d/vhost.conf"
cp /vagrant/resources/configs/apache/vhost.conf /etc/httpd/conf.d/vhost.conf

echo "Restarting Apache to apply changes"
systemctl restart httpd

echo "Done."
