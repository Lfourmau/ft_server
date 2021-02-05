# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lfourmau <lfourmau@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/26 12:58:25 by lfourmau          #+#    #+#              #
#    Updated: 2021/02/05 09:29:47 by lfourmau         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM  debian:buster
COPY /srcs .
#nginx
RUN apt-get update
RUN apt-get install -y nginx
#wget
RUN apt search wget && apt-get install -y  wget
RUN apt-get update
#RUN adduser blog && chown -R blog:www-data /var/www/blog && chmod -R o-rwx /var/www/blog 
#PHP
RUN apt-get update
RUN apt-get -y install php-cli php-mysql php-curl php-gd php-intl php-json php-mbstring php-zip php-pear php-gettext php-xml php-gd php-cgi php-fpm
#RUN touch /etc/php/7.4/fpm/pool.d/blog.conf
#MARIA db et mysql
RUN apt-get install -y mariadb-server mariadb-client
RUN service mysql start && sh mysql.sh
RUN service mysql restart && mysql -u root
#phpmyadmin
RUN mkdir /var/www/html/phpmyadmin
RUN cd /var/www/html/ && wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
RUN cd /var/www/html/ && tar xvf phpMyAdmin-latest-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
RUN mv config.inc.php /var/www/html/phpmyadmin/
RUN cd /var/www/html/phpmyadmin/ && chmod 660 config.inc.php && rm config.sample.inc.php
RUN rm /etc/nginx/sites-available/default
RUN mv default /etc/nginx/sites-available
RUN chown -R www-data:www-data /var/www/html/phpmyadmin/*
#Wordfess
RUN cd /var/www/html && wget http://fr.wordpress.org/latest-fr_FR.tar.gz && tar -xzvf latest-fr_FR.tar.gz
RUN rm /var/www/html/latest-fr_FR.tar.gz && rm /var/www//html/wordpress/wp-config-sample.php && mv wp-config.php /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html/wordpress/*
RUN service mysql restart && mysql -u root < wp_database.sql
#ssl
#RUN apt-get update
#RUN apt-get install -y software-properties-common
#RUN apt-get install -y certbot
#RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 4096 && chmod 600 /etc/ssl/certs/dhparam.pem
ENTRYPOINT ["bash", "start.sh"]
