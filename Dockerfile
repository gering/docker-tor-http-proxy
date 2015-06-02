FROM debian:jessie

MAINTAINER Robert Gering "http://robertgering.de"

RUN echo "deb http://deb.torproject.org/torproject.org trusty main" >> /etc/apt/sources.list
RUN gpg --keyserver keys.gnupg.net --recv 886DDD89
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

RUN apt-get update -qq && apt-get install -y supervisor privoxy deb.torproject.org-keyring tor

# Add custom supervisor config
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add custom configs
ADD ./privoxy/ /etc/privoxy/
ADD ./tor/ /etc/tor/

# Ports
EXPOSE 8118
EXPOSE 9050
EXPOSE 9053

CMD ["/usr/bin/supervisord"]

