FROM golang:alpine as builder

# Edit this list below, defining your plugins with a space-seperated list
ENV CADDYPLUGINS='github.com/BTBurke/caddy-jwt github.com/echocat/caddy-filter github.com/captncraig/caddy-realip github.com/caddyserver/dnsproviders/cloudflare' GO111MODULE='on'

WORKDIR /var

COPY caddy.go /var/caddy.go

RUN apk add --update --no-cache git \
  && go get github.com/caddyserver/caddy/caddy@v1.0.4 $CADDYPLUGINS \
  && go mod init caddy \
  && go build \
  && mv caddy /usr/bin/ \
  && rm -fr $GOPATH/src \
  && apk del git

## Run stage - Install dependencies and copy caddy binary from builder
FROM alpine

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="John Belisle" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="caddy" \
  org.label-schema.description="Containerized, multiarch verion of caddy" \
  org.label-schema.version=$VERSION \
  org.label-schema.url="https://github.com/jmb12686/docker-caddy" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/jmb12686/docker-caddy" \
  org.label-schema.vendor="jmb12686" \
  org.label-schema.schema-version="1.0"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

COPY Caddyfile /etc/Caddyfile

COPY index.html /srv/index.html

EXPOSE 80 443 2015

VOLUME /root/.caddy

WORKDIR /srv

ENTRYPOINT ["/usr/bin/caddy"]

CMD ["-agree", "-conf", "/etc/Caddyfile", "-log", "stdout", "-root", "/tmp"]
