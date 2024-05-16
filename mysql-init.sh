#!/bin/bash

# Start MySQL temporarily
/usr/libexec/mysqld --skip-networking &

# Wait for MySQL to start
sleep 10s

# Set the root password and import the database schema
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root_password'; FLUSH PRIVILEGES;" | mysql -u root
mysql -u root -p'root_password' < /home/bluebirdhotel.sql

# Stop MySQL
pkill mysqld