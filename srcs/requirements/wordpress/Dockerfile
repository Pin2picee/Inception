#wordpress
FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt-get install wget -y

#install php et ses dependances
RUN apt-get install php8.2 php-fpm php-mysql mariadb-client -y
RUN apt install less -y
#install wordpress et le decompresse dans /var/www -> le dossier ou recup nginx 

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/
COPY ./tools/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh
#installation CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

CMD ["/usr/local/bin/auto_config.sh"]