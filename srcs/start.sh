#!/bin/sh
bash autoindex.sh
service nginx start
service php7.3-fpm start
service mysql restart
aptitude -y install expect
sleep infinity
