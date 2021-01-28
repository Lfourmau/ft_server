# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lfourmau <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/26 12:58:25 by lfourmau          #+#    #+#              #
#    Updated: 2021/01/28 13:45:11 by lfourmau         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#image de base
FROM  debian:jessie
#nginx
RUN apt-get update\
&& apt-get -y install nginx
#Wget->mysql
RUN apt-cache search wget\
&& apt-cache search wget | grep wget\
&& apt-get -y install wget
#Lsb->mysql
RUN apt-get update\
&& apt-get -y install lsb-release\
&& apt-get -y install lsb
#try php my admin
RUN apt-get update\
&& apt-get -y install php-mbstring php-zip php-gd\
&& wget https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz\
&& tar xvf phpMyAdmin-4.9.7-all-languages.tar.gz\
mv phpMyAdmin-4.9.7-all-languages/ /usr/share/phpmyadmin
#myql
RUN apt-get update\
&& apt-get install gnupg\
&& cd /tmp\
&& wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb\
&& dpkg -i mysql-apt-config*\
&& apt-get -y update\
&& apt-get -y install mysql-server
