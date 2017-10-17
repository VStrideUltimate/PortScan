#!/usr/bin/env bash

IP_ADDRESS="$1"
PORT="$2"

#scan now
(echo  > /dev/tcp/$IP_ADDRESS/$PORT) >& /dev/null &&
echo "Port tcp/$PORT OPEN on host $IP_ADDRESS"

