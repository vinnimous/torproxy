#!/bin/sh

PRIVOXY_CONFIG=/etc/privoxy/config
TOR_CONFIG=/etc/tor/torrc
PIDFILE=/var/run/privoxy.pid


if [ ! -f "${PRIVOXY_CONFIG}" ]; then
	echo "Configuration file ${PRIVOXY_CONFIG} not found!"
	exit 1
fi

if [ ! -f "${TOR_CONFIG}" ]; then
	echo "Configuration file ${TOR_CONFIG} not found!"
	exit 1
fi

echo "Starting tor script"
/etc/tor/run.sh
echo "Starting privoxy script"
/etc/privoxy/run.sh