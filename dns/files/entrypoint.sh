#!/bin/bash

echo "Assinando zonas de DNSSEC"
cd /opt/dnssec/
./reassina.sh conectado.local authority.zone
./reassina.reverse.sh 123.168.192.in-addr.arpa reverse.zone

echo "Copiando os arquivos para as pastas"
rsync --progress -avzh /opt/dnssec/named.conf /etc/named.conf
rsync --progress -avzh /opt/dnssec/ /var/named
rsync --progress -avzh /opt/dnssec/named.conf /etc/named.conf
rsync --progress -avzh /opt/dnssec/ /var/named

echo "Setando permissoes"
chown named.named -R /etc/named.conf
chown named.named -R /var/named/
chown named.named -R /etc/named.conf
chown named.named -R /var/named/
chown named.named -R /run/named/
touch /var/log/security.log
chown named.named /var/log/security.log

echo "Checando arquivos de zonas"
cd /var/named 
named-checkzone conectado.local authority.zone.signed
named-checkzone 123.168.192.in-addr.arpa reverse.zone
named-checkconf -z /etc/named.conf

echo "Ajustando resolv.conf"
echo "nameserver 127.0.0.1" > /etc/resolv.conf

echo "Executando o serviço de DNS"
/sbin/named -4 -c /etc/named.conf -u named -f

