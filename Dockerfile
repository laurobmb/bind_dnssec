FROM centos:centos8
MAINTAINER Lauro de Paula
LABEL www.laurodepaula.com.br="10.0.0-beta"
LABEL vendor="DNSSEC 1.0"
ENV dominio="conectado.local"
RUN dnf -y install bind bind-utils bind-chroot bash-completion bind-pkcs11-utils rsync
ADD ./files /opt/dnssec
USER named
EXPOSE 53/udp 53/tcp
ENTRYPOINT [ "/opt/dnssec/entrypoint.sh" ]
CMD ["/usr/sbin/named"]
