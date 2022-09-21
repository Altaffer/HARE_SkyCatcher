#!/bin/bash


# this find the ipv4 address of the interface
IP=$(ifconfig wlp0s20f3 | grep -E -o -m 1 "(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])" | head -1)

echo "waiting for jetson to connect"
sleep 10

echo "looking for jetson"
# find the jetson ip
IP_COUNT=0
while (($IP_COUNT == 0))
do 
echo "jetson not found yet"
CONNECTED_IP=$(nmap -p 22 $IP/24 --exclude $IP)
echo "scanning ips of connected devices"
IP_COUNT=$(echo $CONNECTED_IP | grep -E -c "(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])")
done
echo "jetson found"
JETSON_IP=$(echo $CONNECTED_IP | grep -E -o "(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])" | tail -1)

# start an ssh session with the jetson
ssh -t -l jetson $JETSON_IP < /dev/tty

