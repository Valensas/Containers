FROM alpine:3.19.0

RUN apk add --no-cache rsyslog=8.2310.0-r0 lsof
ENTRYPOINT [ "rsyslogd", "-n"]