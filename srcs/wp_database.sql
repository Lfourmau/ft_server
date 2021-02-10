# mysql -uroot -p
CREATE DATABASE ft_server DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root';
FLUSH PRIVILEGES;
\q
