# DNSSEC in podman with CentOS 8

##### note
note: The keys must be in the code before uploading the container, these within the project serve as an example.

## Configure
In the file ***files/authority.zone*** configure the zone that the DNS must respond to, as well as the IP addresses of the hosts.

In the file ***files/reverse.zone*** configure the reverse zone that the DNS must respond to, as well as the IP addresses of the hosts.

#### Gerar Chave KSK e ZSK
The configuration of the keys is very important for the functioning of DNSSEC, execute:

***dnssec-keygen -r /dev/urandom -a RSASHA256 -b 4096 -f KSK -n ZONE [ domínio que você escolheu ]***

***dnssec-keygen -r /dev/urandom -a RSASHA256 -b 1024 -n ZONE [ domínio que você escolheu ]***

Include the generated keys in the file ***files/authority.zone*** (already have an example inside the file)

Run the scripts to create the domain DSSET and the first signature:

- reassina.sh
- reassina.reverse.sh

The file ***files/entrypoint.sh*** needs changes, in it you put the IP addresses so that when the container goes up, the podman can re-sign the zone.

***files/named.conf*** needs changes too, here you must enter the domain.

> zone "[ domínio que você escolheu ]" IN {
>     type master;
>     file "authority.zone.signed";
>     allow-update { none; };
> };
> 
> zone "123.168.192.in-addr.arpa" IN {
>     type master;
>     file "reverse.zone";
>     allow-update { none; };
> };
