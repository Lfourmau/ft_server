# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lfourmau <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/26 12:58:25 by lfourmau          #+#    #+#              #
#    Updated: 2021/01/27 12:10:10 by lfourmau         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM  debian:jessie

RUN apt-get update \
&& apt-get install -y curl \
&& rm -rf /var/lib/apt/lists/* \

RUN apt-get install nginx

CMD :
