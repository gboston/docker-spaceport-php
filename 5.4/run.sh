#!/bin/bash

cd /app
composer install  --optimize-autoloader --ignore-platform-reqs
bundle install

cp /app/package.json /root/
cd /root && npm install -q
rsync -rlzuIO --ignore-errors /root/node_modules/ /app/node_modules > /dev/null 2>&1
cd /app

bower install --allow-root
gulp build
app/console assets:install --symlink --env=docker
app/console assetic:dump --env=docker

php5-fpm
