# Set alpine as a base for speed and size
FROM alpine:latest

LABEL maintainer="vinnimous"

# Update the package repository and install Tor and privoxy
RUN apk update --no-cache && apk add tor privoxy

# Expose required ports
EXPOSE 8118 9050

# Copy over the torrc created above and set the owner to `tor`
COPY services/tor/config /etc/tor/torrc
COPY services/tor/run.sh /etc/tor/run.sh
RUN chown -R tor /etc/tor/*

# Copy over the privoxy_configurations
COPY services/privoxy/config /etc/privoxy/config
COPY services/privoxy/run.sh /etc/privoxy/run.sh
RUN chown -R tor /etc/privoxy/*

# Copy over the start up script
COPY start.sh /
RUN chown -R tor start.sh

# Set `tor` as the default user during the container runtime
USER tor

# Set `tor` as the entrypoint for the image
# ENTRYPOINT ["tor"]

# Set the default container command
# This can be overridden later when running a container
CMD ["start.sh"]