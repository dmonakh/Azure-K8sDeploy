#!/bin/sh

mysql -h $SERVER_NAME -u $USER_NAME -p$PASSWORD -P 3306 -e "\
   CREATE DATABASE IF NOT EXISTS test_manifest12; \
    USE test_manifest12; \
    CREATE TABLE IF NOT EXISTS my_table (id INT PRIMARY KEY, name VARCHAR(50)); \
    INSERT IGNORE INTO my_table (id, name) VALUES (1, 'John'), (2, 'Jane'), (3, 'Joe');" 
if [  -f /var/www/html/wp-config.php ]; then  
    wp --allow-root --path=/var/www/html plugin install contact-form-7 --activate && \
    wp --allow-root --path=/var/www/html theme install hestia    && \
    wp --allow-root --path=/var/www/html theme activate hestia     
else    
    # Configure WP-CLI and install plugins and themes
    wp core download --path=/var/www/html --allow-root && \
    wp --allow-root --path=/var/www/html config create \
      --dbhost=mysql-wpmon.mysql.database.azure.com\
      --dbname=test_manifest12 \
      --dbuser=monadmonsql@mysql-wpmon \
      --dbpass=H@Sh1CoR3! \
      --allow-root && \
    wp --allow-root --path=/var/www/html core install \
      --url=http://wp-team.pp.ua/  \
      --title=WPsite \
      --admin_user=dmonakh \
      --admin_password=3108Dmon \
      --admin_email=den3108mon@gmail.com && \
    wp --allow-root --path=/var/www/html plugin install contact-form-7 --activate && \
    wp --allow-root --path=/var/www/html theme install twentytwentytwo  && \
    wp --allow-root --path=/var/www/html theme activate twentytwentytwo     
fi