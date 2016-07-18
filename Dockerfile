FROM        openshift/base-centos7
MAINTAINER  Sergio Gonzalez "sergio.l.gonzalez@axa-medla.com"

# Update the package repository and install applications
RUN yum update -y && \
  yum install varnish -y

# Make our custom VCLs available on the container
ADD default.vcl /etc/varnish/default.vcl

ENV VARNISH_BACKEND_PORT 8080
ENV VARNISH_BACKEND_IP 172.17.42.1
ENV VARNISH_FRONT_PORT 8080

EXPOSE 8080

RUN chmod -R 777 /etc/varnish \
 && chmod -R 777 /var/lib/varnish

ADD start.sh /start.sh
RUN chmod +x /start.sh


CMD ["/start.sh"]

