# httpd
FROM fedora:32
LABEL version="1.0"
LABEL author="Proyecto kubernetes"
LABEL subject="httpdserver"
RUN dnf -y install httpd 
RUN mkdir /opt/docker
COPY index.html /var/www/html/
COPY index.css /var/www/html
COPY timon2.jpg /var/www/html
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
