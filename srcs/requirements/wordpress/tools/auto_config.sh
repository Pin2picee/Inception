#!/bin/sh

until mysql -h mariadb -u"$SQL_USER" -p"$SQL_PASSWD" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "Waiting for MariaDB..."
    sleep 2
done

SRC_DIR="/tmp/wordtemp"
DEST_DIR="/var/www/wordpress"
found=$(find /var/www/wordpress -mindepth 1 -not -name "index.nginx-debian.html" | wc -l)
if [ "$found" -lt 1 ]; then
    echo "$DEST_DIR est vide, copie des fichiers WordPress..."
    cp -R "$SRC_DIR"/. "$DEST_DIR"/
    chown -R www-data:www-data "$DEST_DIR"
else
    echo "$DEST_DIR n'est pas vide, copie ignorée."
fi
if [ ! -f /var/www/wordpress/wp-config.php ]; then
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

fi

if ! wp user get $WPUSER --allow-root --path='/var/www/wordpress' >/dev/null 2>&1; then
    echo "Creating adil..."
    wp user create  adil adil.belmohammadi30@gmail.com --allow-root \
        --role=subscriber \
        --user_pass="$WPPASSWD" \
        --path='/var/www/wordpress'
else
    echo "User adil already exists."
fi
echo "Wordpress launched ..."

#autorisation des commentaires par default
wp option update comment_registration '1' --allow-root --path='/var/www/wordpress'
wp post list --post_type=post --format=ids --allow-root --path='/var/www/wordpress' | xargs -I % wp post update % --comment_status=open --allow-root --path='/var/www/wordpress'
wp plugin install wp-mail-smtp --activate --allow-root --path=/var/www/wordpress
php-fpm8.2 -F -y /etc/php/8.2/fpm/php-fpm.conf
