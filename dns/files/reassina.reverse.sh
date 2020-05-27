#!/bin/bash
# Lauro de Paula Gomes
ZONE="$1"
ZONEFILE="$2"
SERIAL=`named-checkzone $ZONE $ZONEFILE | grep "loaded serial"| awk '{print $5}'| head -n1`
DATA_DIA_ATUAL=`date +%Y%m%d01`
DATA=`date +%Y%m%d`
SERIAL_NOVO=0

if [[ "${SERIAL,,}" == *"$DATA"* ]] ;then
	echo -e "\e[92mIncrementando o serial\e[39m"
	SERIAL_NOVO=$(($SERIAL+1))
	sed -i s/$SERIAL/"$SERIAL_NOVO"/g $ZONEFILE
	echo -e "\e[92mchecando a $ZONE \e[39m"
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
	echo -e "\e[92mchecando a zona $ZONE \e[39m"
        if named-checkzone $ZONE $ZONEFILE; then
                echo -e "\e[92mZona OK\e[39m"
                exit 0
        else
                echo -e "\e[91mFalha no arquivo de zona OFF\e[39m"
                exit 1
        fi
fi

