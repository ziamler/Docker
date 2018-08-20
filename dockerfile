FROM ubuntu:latest
MAINTAINER khushal "khushal@example.com"
RUN apt-get update -y
RUN apt-get install nginx -y \
     && apt-get install -y supervisor procps vim net-tools less tcpdump wget curl lsof htop nmon telnet openssl libssl-dev ca-certificates --no-install-recommends && rm -rf /var/lib/apt/lists/*
ADD global.conf /var/www/html/website/
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 80
HEALTHCHECK --interval=10s --retries=2 --timeout=15s --start-period=5s CMD curl -I -f “http://localhost:80” || exit 1
CMD ["/usr/bin/supervisord"]


==========================================================================================================================================
vim supervisord.conf

[supervisord]
nodaemon=true

[program:nginx]
command=/usr/sbin/nginx
autostart=true
==========================================================================================================================================
