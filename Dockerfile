# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lfourmau <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/26 12:58:25 by lfourmau          #+#    #+#              #
#    Updated: 2021/02/01 12:28:10 by lfourmau         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM  debian:buster
#nginx
RUN apt-get update
RUN apt-get install -y nginx
#wget
RUN apt search wget && apt-get install -y  wget
RUN apt-get update
#Wordfess
RUN cd /var/www && wget http://fr.wordpress.org/latest-fr_FR.tar.gz && tar -xzvf latest-fr_FR.tar.gz
RUN mv /var/www/wordpress blog && rm /var/www/latest-fr_FR.tar.gz
#RUN adduser blog && chown -R blog:www-data /var/www/blog && chmod -R o-rwx /var/www/blog 
#PHP
RUN apt-get update
RUN apt-get -y install php-cli php-mysql php-curl php-gd php-intl
RUN apt-get install -y php-fpm
#RUN touch /etc/php/7.4/fpm/pool.d/blog.conf
#MARIA db
RUN apt-get install -y mariadb-server mariadb-client
#phpmyadmin
RUN wget -P Downloads https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
#ssl
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y certbot
RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 4096 && chmod 600 /etc/ssl/certs/dhparam.pem
#ENTRYPOINT /srcs/script.sh
