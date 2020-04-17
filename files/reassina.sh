#!/bin/bash
# Lauro de Paula Gomes

#Gerar Chave KSK -> dnssec-keygen -r /dev/urandom -a RSASHA256 -b 4096 -f KSK -n ZONE olinda.com.br
#Gerar chave ZSK -> dnssec-keygen -r /dev/urandom -a RSASHA256 -b 1024 -n ZONE olinda.com.br

ZONE="$1"
ZONEFILE="$2"
SERIAL=`named-checkzone $ZONE $ZONEFILE | grep "loaded serial"| awk '{print $5}'| head -n1`
DATA_DIA_ATUAL=`date +%Y%m%d01`
SERIAL_NOVO=0
DATA=`date +%Y%m%d`

if [[ "${SERIAL,,}" == *"$DATA"* ]] ;then
	echo -e "\e[92mIncrementando o serial\e[39m"
	SERIAL_NOVO=$(($SERIAL+1))
	sed  -i s/$SERIAL/"$SERIAL_NOVO"/g $ZONEFILE
        echo -e "\e[92mChecando a Zona $ZONE\e[39m"
	dnssec-signzone -S -z -o $ZONE $ZONEFILE K$ZONE.*.private
	if named-checkzone $ZONE $ZONEFILE; then
		echo -e "\e[92mZona OK\e[39m"
		exit 0
	else
		echo -e "\e[91mFalha no arquivo de zona OFF\e[39m"
		exit 1
	fi
else
	echo -e "\e[92mRealização a primeira atualização diaria\e[39m"
	sed -i s/$SERIAL/"$DATA_DIA_ATUAL"/g $ZONEFILE
	echo -e "\e[92mChecando a Zona $ZONE\e[39m"
        dnssec-signzone -S -z -o $ZONE $ZONEFILE K$ZONE.*.private
        if named-checkzone $ZONE $ZONEFILE; then
                echo -e "\e[92mZona OK\e[39m"
                exit 0
        else
                echo -e "\e[91mFalha no arquivo de zona OFF\e[39m"
                exit 1
        fi

fi


#FONTES
#https://www.digitalocean.com/community/tutorials/how-to-setup-dnssec-on-an-authoritative-bind-dns-server--2
#https://laurobmb.wordpress.com/2017/04/16/configuracao-dnssec-centos-7/
,
