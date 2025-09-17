#wordpress
FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt-get install wget -y && apt-get install sendmail -y

#install php et ses dependances
RUN apt-get install php8.2 php-fpm php-mysql mariadb-client -y
RUN apt install curl -y
#install wordpress et le decompresse dans /var/www -> le dossier ou recup nginx 
RUN curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && mkdir -p /tmp/wordtemp \
    && tar -xzf /tmp/wordpress.tar.gz -C /tmp/wordtemp --strip-components=1 \
    && rm /tmp/wordpress.tar.gz \
    && mkdir -p /var/www/wordpress

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/
COPY ./tools/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh
#installation CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

CMD ["/usr/local/bin/auto_config.sh"]
