FROM alpine:3.14
RUN apk add --no-cache mysql-client

# Set secret for MySQL Server
ENV SERVER_NAME mysql-wpmon.mysql.database.azure.com
ENV USER_NAME mysqladminun@mysql-wpmon
ENV PASSWORD H@Sh1CoR3!

CMD mysql -h $SERVER_NAME -u $USER_NAME -p$PASSWORD -P 3306 -e "\
    CREATE DATABASE IF NOT EXISTS test_manifest12; \
    USE test_manifest12; \
    CREATE TABLE IF NOT EXISTS my_table (id INT PRIMARY KEY, name VARCHAR(50)); \
    INSERT INTO my_table (id, name) VALUES (1, 'John'), (2, 'Jane'), (3, 'Joe');"