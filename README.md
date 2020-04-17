# DNSSEC with Docker

## Execute to install

./setup.sh

## Test

cd /var/named/ 

named-checkzone olinda.com.br authority.zone.signed

named-checkzone 15.168.192.in-addr.arpa reverse.zone

named-checkconf -z /etc/named.conf

