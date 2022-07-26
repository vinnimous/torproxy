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
RUN addgroup -S anon \
&& adduser -S anon -G anon \
&& chown anon:anon /etc/tor \
&& chown -R anon:anon /etc/tor/* \
&& chown anon:anon /etc/privoxy \
&& chown -R anon:anon /etc/privoxy/*

# Copy over the start up script
COPY start.sh /
RUN chown -R anon start.sh

# Set `tor` as the default user during the container runtime
USER anon

# Set entrypoint
ENTRYPOINT [ "/bin/sh", "-c" ]

# Starts everything
CMD ["start.sh"]