#Installation et configuration de NGINX

#Avant derniere version de Debian == Debian 12
FROM debian:bookworm

#Mise a jour apt et installation nginx
RUN apt update -y && apt upgrade -y && apt install nginx -y

#creation du dossier pour stocker la certif
RUN mkdir -p /etc/nginx/ssl

RUN apt install vim -y && apt install nano -y
#installation OpenSSL + creation du certificat ssl auto signe qui nous genere la cle publique et private du server nginx
RUN apt install openssl -y && openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=Occitanie/L=Perpignan/O=42/OU=42perpignan/CN=abelmoha.42.fr/UID=abelmoha"

#on ecrase le fichier de base de configuration de notre server pour le config sois meme
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN chown www-data:www-data /etc/nginx/nginx.conf
COPY ./tools/setup.sh /etc/nginx/setup.sh
RUN chmod +x /etc/nginx/setup.sh
# NGINX par default utilise www-data donc je modifie les droits d'acces au dossier html pour qu'il puisse lire et executer
RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

ENTRYPOINT ["/etc/nginx/setup.sh"]