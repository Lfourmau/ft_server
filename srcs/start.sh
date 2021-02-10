#!/bin/sh
service nginx start
service php7.3-fpm start
service mysql restart
aptitude -y install expect
#tail -F /var/log/mysql/error.log
sleep infinity
