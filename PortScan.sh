#!/usr/bin/env bash

#Name: PortScan.sh
#Author(s): Dylan Wagner

source ip_util.sh

IP_ADDR_RANGE="$1"
PORT_RANGE="$2"

# takes in raw ip information for processing
function ip(){

	local IP_DATA="$1"
	local IP_START
	local IP_END
	
	if [[ "$(echo $IP_DATA | grep -o - | grep -c .)" == 1 ]]; then
		IP_START=$(echo $IP_DATA | cut -d "-" -f1)
		IP_END=$(echo $IP_DATA | cut -d "-" -f2)
	else
		IP_START=$(echo $IP_DATA | cut -d "/" -f1)
		local START_INT=$(int_ip $IP_START)
		local PREFIX=$(echo $IP_DATA | cut -d "/" -f2)
		if [ "$PREFIX" == "$IP_START" ]; then
			IP_END=$IP_START
		else
			local MAX_SIZE=$((2**(32-PREFIX)-1))
			IP_END=$(str_ip $(echo $((MAX_SIZE|START_INT))))
		fi
	fi
	echo $IP_START $IP_END #[start ip] [end ip]
}

# takes in raw port information for processing
function port(){

	local PORT_DATA="$1"
	local OUT_STR	

	if [[ "$(echo $PORT_DATA | grep -o - | grep -c .)" == 1 ]]; then
		local START=$(echo $PORT_DATA | cut -d "-" -f1)
		local END=$(echo $PORT_DATA | cut -d "-" -f2)
		OUT_STR=$(seq -s " " $START $END)
	else
		 OUT_STR=${PORT_DATA//,/ }
	fi
	
	echo $OUT_STR	
}

#Create for loop within for loop 

# | parallel -k -P 0 
PRO_IP_RNG=$(ip $IP_ADDR_RANGE)
IP_INT_SRT=$(int_ip $(echo $PRO_IP_RNG | cut -d " " -f1))
IP_INT_END=$(int_ip $(echo $PRO_IP_RNG | cut -d " " -f2))  
PRO_IP_RNG=$(seq -f "%.0f" -s " " $IP_INT_SRT $IP_INT_END)
PORT_RNG_FIN=$(port $PORT_RANGE)

for ip in $PRO_IP_RNG
do
	for port in $PORT_RNG_FIN
	do
		echo "./scan_ip_port.sh $(str_ip $ip) $port"
	done
done | parallel -j 55 --timeout 200%
