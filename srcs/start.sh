#!/bin/sh
service nginx start
service php7.3-fpm start
tail -F /var/log/mysql/error.log
