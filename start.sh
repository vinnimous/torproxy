#!/bin/sh

PRIVOXY_CONFIG=/etc/privoxy/config
TOR_CONFIG=/etc/tor/torrc
PIDFILE=/var/run/privoxy.pid
RUN_PRIVOXY="/etc/privoxy/run.sh ${PRIVOXY_CONFIG}"
RUN_TOR="/etc/tor/run.sh ${TOR_CONFIG}"

find_configs()
{
	if [ ! -f "${PRIVOXY_CONFIG}" ]; then
		echo "Configuration file ${PRIVOXY_CONFIG} not found!"
		exit 1
	else
		echo "Configuration file ${PRIVOXY_CONFIG} found"
	fi

	if [ ! -f "${TOR_CONFIG}" ]; then
		echo "Configuration file ${TOR_CONFIG} not found!"
		exit 1
	else
		echo "Configuration file ${TOR_CONFIG} found"
	fi
}

start_privoxy()
{
	echo "Starting privoxy script"
	RUN_PRIVOXY
}

start_tor()
{
	echo "Starting tor script"
	RUN_TOR
}

find_configs
start_privoxy
start_tor