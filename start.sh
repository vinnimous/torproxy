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

nohup ping google.com &>/dev/null & nohup ping google.com &>/dev/null &
/usr/sbin/privoxy --no-daemon --pidfile "${PIDFILE}" "${CONFFILE}"
