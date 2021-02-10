# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lfourmau <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/10 09:37:16 by lfourmau          #+#    #+#              #
#    Updated: 2021/02/10 13:53:18 by lfourmau         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #
FROM  debian:buster
COPY /srcs .
ENV AUTOINDEX="on"
#nginx
RUN apt-get update && apt upgrade -y
RUN apt-get install -y nginx
#wget
RUN apt-get install -y  wget
#RUN adduser blog && chown -R blog:www-data /var/www/blog && chmod -R o-rwx /var/www/blog 
#PHP
RUN apt-get -y install php-cli php-mysql php-curl php-gd php-intl php-json php-mbstring php-zip php-pear php-gettext php-xml php-gd php-cgi php-fpm
#RUN touch /etc/php/7.4/fpm/pool.d/blog.conf
#MARIA db et mysql
RUN apt-get install -y mariadb-server mariadb-client
RUN service mysql start
#phpmyadmin
RUN mkdir /var/www/html/phpmyadmin
RUN cd /var/www/html/ && wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
RUN cd /var/www/html/ && tar xvf phpMyAdmin-latest-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
RUN mv config.inc.php /var/www/html/phpmyadmin/
RUN cd /var/www/html/phpmyadmin/ && chmod 660 config.inc.php && rm config.sample.inc.php
RUN rm /etc/nginx/sites-enabled/default
RUN mv nginx.conf /etc/nginx/sites-enabled/
RUN chmod 444 /var/www/html/phpmyadmin/config.inc.php
RUN chown -R www-data:www-data /var/www/html/phpmyadmin/
RUN mkdir /var/www/html/phpmyadmin/tmp && chmod 777 /var/www/html/phpmyadmin/tmp
#ssl
RUN apt-get install -y openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=FR/ST=France/L=Lyon/emailAddress=lfourmau@student.42lyon.fr" -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
#Wordfess
RUN cd /var/www/html && wget http://fr.wordpress.org/latest-fr_FR.tar.gz && tar -xzvf latest-fr_FR.tar.gz
RUN rm /var/www/html/latest-fr_FR.tar.gz && rm /var/www//html/wordpress/wp-config-sample.php && mv wp-config.php /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html/wordpress/
RUN service mysql restart && mysql < /var/www/html/phpmyadmin/sql/create_tables.sql
RUN service mysql restart && mysql < wp_database.sql
EXPOSE 80 443
ENTRYPOINT ["bash", "start.sh"]
