# Set alpine as a base for speed and size
FROM alpine:latest

LABEL maintainer="vinnimous"

# Update the package repository and install Tor and privoxy
RUN apk update --no-cache && apk add tor privoxy

# Copy over the torrc created above and set the owner to `tor`
COPY services/tor/config /etc/tor/torrc
COPY services/tor/run.sh /etc/tor/run.sh

# Copy over the privoxy_configurations
COPY services/privoxy/config /etc/privoxy/config
COPY services/privoxy/run.sh /etc/privoxy/run.sh

# Create user group
RUN addgroup -S tor \
&& adduser -S tor -G tor \
&& chown tor:tor /etc/tor \
&& chown -R tor:tor /etc/tor/* \
&& chown tor:tor /etc/privoxy \
&& chown -R tor:tor /etc/privoxy/*

# Copy over the start up script
COPY start.sh /
RUN chown -R tor start.sh

# Set `tor` as the default user during the container runtime
USER tor

# Starts everything
CMD ["start.sh"]