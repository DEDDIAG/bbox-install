#!/bin/bash
while getopts "p:" opt; do
	case $opt in
		p ) IP="$OPTARG";;
	esac
done
if [ -z "$IP" ]
then
	echo "IP is not set. use -p IP"
	exit 1
fi

THING_UID=`date | sha1sum | cut -c -8`

curl 'http://'$IP'/rest/things' -H 'Host: '$IP -H 'Accept: application/json, text/plain, */*' --compressed -H 'Referer: http://'$IP'/paperui/index.html' -H 'Content-Type: application/json' -H 'DNT: 1' -H 'Connection: keep-alive' --data '{"UID":"tplink-smarthome:tplink-smarthome-bridge:'$THING_UID'","configuration":{"pollingInterval":1,"timeout":10,"broadcastAddress":"255.255.255.255","port":9999},"item":{"label":"TP-Link SmartHome Bridge","groupNames":[]},"ID":"'$THING_UID'","label":"TP-Link SmartHome Bridge","thingTypeUID":"tplink-smarthome:tplink-smarthome-bridge"}'
