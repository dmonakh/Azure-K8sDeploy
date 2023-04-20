FROM alpine:3.14
RUN apk add --no-cache mysql-client

# Set secret for MySQL Server
ENV SERVER_NAME mysql-wpmon.mysql.database.azure.com
ENV USER_NAME monadmonsql@mysql-wpmon
ENV PASSWORD H@Sh1CoR3!

# Connect to the MySQL server and create a new database

CMD mysql -h $SERVER_NAME -u $USER_NAME -p$PASSWORD -P 3306 -e "\
    SHOW DATABASES; \
    CREATE DATABASE IF NOT EXISTS test_manifest12; \
    USE test_manifest12; \
    CREATE TABLE IF NOT EXISTS my_table (id INT PRIMARY KEY, name VARCHAR(50)); \
    INSERT INTO my_table (id, name) VALUES (1, 'John'), (2, 'Jane'), (3, 'Joe');"

FROM alpine:3.14
RUN apk add --no-cache mysql-client
RUN mkdir -p /var/www/html/ && chmod 777 /var/www/html/
# Установить зависимости для WP-CLI
RUN apk add --no-cache \
        less \
        php7 \
        php7-curl \
        php7-json \
        php7-mbstring \
        php7-mysqli \
        php7-phar \
        php7-openssl \
        php7-dom \
        php7-xml \
        php7-xmlwriter \
        php7-simplexml
# Скачать и установить WP-CLI
RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp
# Set the server name and login credentials
ENV SERVER_NAME mysql-wpmon.mysql.database.azure.com
ENV USER_NAME monadmonsql@mysql-wpmon
ENV PASSWORD H@Sh1CoR3!
# Connect to the MySQL server and create a new database
CMD mysql -h $SERVER_NAME -u $USER_NAME -p$PASSWORD -P 3306 -e "\
    CREATE DATABASE IF NOT EXISTS test_manifest12; \
    USE test_manifest12; \
    CREATE TABLE IF NOT EXISTS my_table (id INT PRIMARY KEY, name VARCHAR(50)); \
    INSERT IGNORE  INTO my_table (id, name) VALUES (1, 'John'), (2, 'Jane'), (3, 'Joe');" &&\
# Configure WP-CLI and install plugins and themes
wp core download --path=/var/www/html --allow-root && \
wp --allow-root --path=/var/www/html config create \
  --dbhost=mysql-wpmon.mysql.database.azure.com \
  --dbname=test_manifest12 \
  --dbuser=monadmonsql@mysql-wpmon \
  --dbpass=H@Sh1CoR3! \
  --allow-root && \
wp --allow-root --path=/var/www/html core install \
  --url=http://localhost \
  --title=WP_team \
  --admin_user=admin \
  --admin_password=admin \
  --admin_email=admin@example.com  &&\
wp  plugin install contact-form-7 --activate && \
wp  theme install astra && \
wp  theme activate astra