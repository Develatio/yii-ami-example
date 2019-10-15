#!/usr/bin/env bash

# WARNING: This script will be executed as the "admin" user.
# If you want to run it as another user, use su/sudo.

cd /var/www/webapp/src

sudo setfacl -R -d -m u:admin:rwx ./tmp ./log
sudo setfacl -R -d -m g:www-data:rwx ./tmp ./log
sudo setfacl -R -d -m o::r-x ./tmp ./log

sudo setfacl -R -m u:admin:rwx ./tmp ./log
sudo setfacl -R -m g:www-data:rwx ./tmp ./log
sudo setfacl -R -m o::r-x ./tmp ./log

# Install some dependencies
composer install

# Maybe collect statics?
#RAILS_ENV=production rails assets:precompile

# Maybe run migrations?
#RAILS_ENV=production rails db:migrate