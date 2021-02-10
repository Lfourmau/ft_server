if [ "${AUTOINDEX}" = "off" ]
then
  sed -i "s/autoindex on/autoindex off/" /etc/nginx/sites-enabled/nginx.conf;
fi
