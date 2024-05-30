FROM docker:20.10

RUN apk add --no-cache bash aws-cli

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
