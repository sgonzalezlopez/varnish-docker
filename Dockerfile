FROM        ubuntu:14.04.2
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"
ENV REFRESHED_AT 2014-10-18
#ENV http_proxy http://10.185.4.54:3128
# Update the package repository and install applications
RUN apt-get update -y && \
#  apt-get upgrade -yqq && \
  apt-get install varnish -y && \
  apt-get clean -y

# Make our custom VCLs available on the container
ADD default.vcl /etc/varnish/default.vcl

ENV VARNISH_BACKEND_PORT 80
ENV VARNISH_BACKEND_IP 172.17.42.1
ENV VARNISH_PORT 80

# Expose port 80
EXPOSE 80

# Expose volumes to be able to use data containers
#VOLUMES ["/var/lib/varnish", "/etc/varnish"]

ADD start.sh /start.sh

RUN chmod -R 777 /etc/varnish

#CMD ["/start.sh"]
ENTRYPOINT ["/bin/bash"]
