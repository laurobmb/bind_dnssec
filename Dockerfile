FROM centos:centos8
MAINTAINER Lauro de Paula
LABEL www.laurodepaula.com.br="10.0.0-beta"
LABEL vendor="DNSSEC 1.0"
ENV dominio="conectado.local"
RUN dnf -y install bind bind-utils bind-pkcs11-utils rsync
RUN dnf clean all 
ADD ./files /opt/dnssec
EXPOSE 53/udp 53/tcp
ENTRYPOINT [ "/opt/dnssec/entrypoint.sh" ]
#USER named
#CMD ["/sbin/named -4 -c /etc/named.conf -u named -f"]
