#!/bin/sh

# Lancer MariaDB en arrière-plan
mysqld_safe &
echo "Waiting for MariaDB to start..."
until [ -S /run/mysqld/mysqld.sock ]; do
    sleep 1
done
echo "MariaDB is up."

# Exécuter les commandes
# USER ET DATABASE CONFIGURATION
mysql -u root -p"${SQL_ROOT_PASSWD}" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -u root -p"${SQL_ROOT_PASSWD}" -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWD}';"
mysql -u root -p"${SQL_ROOT_PASSWD}" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';"
mysql -u root -p"${SQL_ROOT_PASSWD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWD}';"
mysql -u root -p"${SQL_ROOT_PASSWD}" -e "FLUSH PRIVILEGES;"

# Arrêter MariaDB pour laisser mysqld_safe reprendre
mysqladmin -u root -p"${SQL_ROOT_PASSWD}" shutdown

# exec remplace le process du shell par mysqld_safe pour que le container reste actif
exec mysqld_safe
