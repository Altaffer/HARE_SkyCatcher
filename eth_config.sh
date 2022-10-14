#!/bin/bash

# MUST BE CONFIGURED FOR JETSON. DELETE ME WHEN THIS IS DONE
# DISCONNECT FROM CURRENT ON WLAN0
# CONNECT MICASENSE

# ethernet
IP_NAME=test_ip
INTERFACE_NAME=enx98fc84e33b2f

COUNT=COUNT=$(nmcli connection | grep -c $IP_NAME)

if (("$COUNT" > 0))
then 
echo "turning off ipv4 configurations"
sudo nmcli con down id "$IP_NAME"
nmcli connection delete "$IP_NAME"
else
echo "creating and turning on ipv4 configurations"
sudo nmcli con add type ethernet con-name "$IP_NAME" ifname $INTERFACE_NAME ipv4.method manual ipv4.addresses 128.114.204.116 gw4 255.255.255.0
sudo nmcli con up id "$IP_NAME"

fi




