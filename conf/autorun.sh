#!/usr/bin/env bash

# WARNING: This script will be executed as the "admin" user.
# If you want to run it as another user, use su/sudo.

echo -n "netdata:" | sudo tee /var/www/webapp/conf/netdata/password
echo "$(curl -s http://169.254.169.254/latest/meta-data/instance-id | mkpasswd --stdin --method=sha-256)" | sudo tee -a /var/www/webapp/conf/netdata/password

cd /var/www/webapp/src

sudo setfacl -R -d -m u:admin:rwx ./web/assets ./runtime
sudo setfacl -R -d -m g:www-data:rwx ./web/assets ./runtime
sudo setfacl -R -d -m o::r-x ./web/assets ./runtime

sudo setfacl -R -m u:admin:rwx ./web/assets ./runtime
sudo setfacl -R -m g:www-data:rwx ./web/assets ./runtime
sudo setfacl -R -m o::r-x ./web/assets ./runtime

# Install some dependencies
composer install

# Maybe run migrations?
# ./yii migrate