FROM    debian:bookworm

RUN apt update -y  && apt upgrade -y && apt-get install mariadb-server -y

COPY ./conf/50-server.cnf   /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod 754 /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/database.sh    /usr/local/bin/database.sh

RUN chmod +x /usr/local/bin/database.sh

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

ENTRYPOINT ["./usr/local/bin/database.sh"]