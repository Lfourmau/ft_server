#!/bin/sh
bash autoindex.sh
service nginx start
service php7.3-fpm start
service mysql restart
sleep infinity
