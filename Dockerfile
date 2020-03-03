FROM golang:alpine

# Edit this list below, defining your plugins with a space-seperated list
ENV CADDYPLUGINS='github.com/echocat/caddy-filter github.com/captncraig/caddy-realip github.com/caddyserver/dnsproviders/cloudflare' GO111MODULE='on'

WORKDIR /var

COPY caddy.go /var/caddy.go

RUN apk add --update --no-cache git \
  && go get github.com/caddyserver/caddy/caddy@v1.0.3 $CADDYPLUGINS \
  && go mod init caddy \
  && go build \
  && mv caddy /usr/bin/ \
  && rm -fr $GOPATH/src \
  && apk del git

COPY Caddyfile /etc/Caddyfile

COPY index.html /srv/index.html

EXPOSE 80 443 2015

VOLUME /root/.caddy

WORKDIR /srv

ENTRYPOINT ["/usr/bin/caddy"]

CMD ["-agree", "-conf", "/etc/Caddyfile", "-log", "stdout", "-root", "/tmp"]
