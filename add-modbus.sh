#!/bin/bash

PHASE_ONE=23318
PHASE_TWO=23320
PHASE_THREE=23322

#IP_REGEX=^(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))$

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

if ! [[ "$IP" =~ ${IP_REGEX} ]]
then
	echo "IP not valid"
	exit 1
fi
THING_UID=`date | sha1sum | cut -c -8`

curl 'http://'$IP'/rest/things' -H 'Host: '$IP -H 'Accept: application/json, text/plain, */*' --compressed -H 'Referer: http://'$IP'/paperui/index.html' -H 'Content-Type: application/json' -H 'DNT: 1' -H 'Connection: keep-alive' --data '{"UID":"modbussmartmeter:modbus-smartmeter-bridge:'$THING_UID'","configuration":{"pollingInterval":1,"timeout":100,"uartConfigPin":0,"uartDevice":"/dev/ttyS0"},"item":{"label":"Modbus Smart Meter Bridge","groupNames":[]},"ID":"'$THING_UID'","label":"Modbus Smart Meter Bridge","thingTypeUID":"modbussmartmeter:modbus-smartmeter-bridge"}'

BRIDGE_UID=$THING_UID
sleep 1
THING_UID=`date | sha1sum | cut -c -8`

curl 'http://'$IP'/rest/things' -H 'Host: '$IP -H 'Accept: application/json, text/plain, */*' --compressed -H 'Referer: http://'$IP'/paperui/index.html' -H 'Content-Type: application/json' -H 'DNT: 1' -H 'Connection: keep-alive' --data '{"UID":"modbussmartmeter:modbus:'$THING_UID'","configuration":{"targetRegisterAddress":'$PHASE_ONE',"targetRegisterLength":2,"targetResolution":0.01},"item":{"label":"Phase 1","groupNames":[]},"ID":"'$THING_UID'","label":"Phase 1","bridgeUID":"modbussmartmeter:modbus-smartmeter-bridge:'$BRIDGE_UID'","thingTypeUID":"modbussmartmeter:modbus"}'

sleep 1
THING_UID=`date | sha1sum | cut -c -8`

curl 'http://'$IP'/rest/things' -H 'Host: '$IP -H 'Accept: application/json, text/plain, */*' --compressed -H 'Referer: http://'$IP'/paperui/index.html' -H 'Content-Type: application/json' -H 'DNT: 1' -H 'Connection: keep-alive' --data '{"UID":"modbussmartmeter:modbus:'$THING_UID'","configuration":{"targetRegisterAddress":'$PHASE_TWO',"targetRegisterLength":2,"targetResolution":0.01},"item":{"label":"Phase 2","groupNames":[]},"ID":"'$THING_UID'","label":"Phase 2","bridgeUID":"modbussmartmeter:modbus-smartmeter-bridge:'$BRIDGE_UID'","thingTypeUID":"modbussmartmeter:modbus"}'

sleep 1
THING_UID=`date | sha1sum | cut -c -8`

curl 'http://'$IP'/rest/things' -H 'Host: '$IP -H 'Accept: application/json, text/plain, */*' --compressed -H 'Referer: http://'$IP'/paperui/index.html' -H 'Content-Type: application/json' -H 'DNT: 1' -H 'Connection: keep-alive' --data '{"UID":"modbussmartmeter:modbus:'$THING_UID'","configuration":{"targetRegisterAddress":'$PHASE_THREE',"targetRegisterLength":2,"targetResolution":0.01},"item":{"label":"Phase 3","groupNames":[]},"ID":"'$THING_UID'","label":"Phase 3","bridgeUID":"modbussmartmeter:modbus-smartmeter-bridge:'$BRIDGE_UID'","thingTypeUID":"modbussmartmeter:modbus"}'
