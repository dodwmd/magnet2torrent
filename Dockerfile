FROM alpine:edge

MAINTAINER Michael Dodwell <michael@dodwell.us>

RUN apk add --no-cache aria2 tzdata && \
	cp /usr/share/zoneinfo/Australia/Brisbane /etc/localtime && \
	echo "Australia/Brisbane" > /etc/timezone

CMD ["/usr/bin/aria2c"]
