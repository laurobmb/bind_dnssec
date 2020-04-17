FROM centos:centos7
MAINTAINER Lauro de Paula
LABEL www.laurodepaula.com.br="10.0.0-beta"
LABEL vendor="DNSSEC 1.0"
ENV dominio="olinda.com.br"
RUN yum -y update
RUN yum -y install bind bind-utils bind-chroot bash-completion bind-dnssec-utils rsync
ADD ./files /opt/dnssec
EXPOSE 53/udp 53/tcp
ENTRYPOINT [ "/opt/dnssec/entrypoint.sh" ]
CMD ["/usr/sbin/named"]
