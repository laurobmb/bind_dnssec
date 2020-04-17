FROM centos:centos8
MAINTAINER Lauro de Paula
LABEL www.laurodepaula.com.br="10.0.0-beta"
LABEL vendor="DNSSEC 1.0"
RUN dnf -y install bind bind-utils bind-pkcs11-utils rsync
RUN dnf clean all 

ENV dominio_de_aurotidade="conectado.local"
ENV ips=192.168.123.1

ADD ./files /opt/dnssec
EXPOSE 53/udp 53/tcp
ENTRYPOINT [ "/opt/dnssec/entrypoint.sh" ]
