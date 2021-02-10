# mysql -uroot -p
CREATE DATABASE IF NOT EXISTS ft_server DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'bob'@'localhost' IDENTIFIED BY 'foot';
GRANT ALL ON *.* TO 'bob'@'localhost' IDENTIFIED BY 'foot';
FLUSH PRIVILEGES;
\q
