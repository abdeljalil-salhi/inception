FROM alpine:3.14

# Install packages
RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client

# Get the config in place
COPY ./tools/setup.sh /tmp/setup.sh

# Run the setup script
ENTRYPOINT ["sh", "/tmp/setup.sh"]
