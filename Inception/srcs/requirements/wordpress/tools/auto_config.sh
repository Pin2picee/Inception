#!/bin/sh

until mysql -h mariadb -u"$SQL_USER" -p"$SQL_PASSWD" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "Waiting for MariaDB..."
    sleep 2
done

if [ ! -f /var/www/wordpress/wp-config.php ]; then

    wp core download --allow-root --path='/var/www/wordpress'
    chown -R www-data:www-data /var/www/wordpress && chmod -R 755 /var/www/wordpress
    wp config create	--allow-root \
    --dbname=$SQL_DATABASE \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASSWD \
    --dbhost=mariadb:3306 \
    --path='/var/www/wordpress'
fi

if ! wp core is-installed --allow-root --path='/var/www/wordpress'; then

    wp core install     --allow-root \
    --url=https://abelmoha.42.fr \
    --title=Inception \
    --admin_user="$ADMIN_USER" \
    --admin_password="$ADMIN_PASSWD"\
    --admin_email=bendejo@gmail.com \
    --path='/var/www/wordpress'

    wp user create  adil  adil.belmohammadi30@gmail.com --allow-root \
    --role=subscriber \
    --user_pass="$USER_PASSWD" \
    --path='/var/www/wordpress'

fi
echo "Wordpress launched ..."
php-fpm8.2 -F -y /etc/php/8.2/fpm/php-fpm.conf
