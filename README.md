# docker-caddy
Multiarch version of Caddy for use on amd64 and arm devices (raspberrypi)

## Simple Usage


```sh
docker run -d -p 2015:2015 jmb12686/caddy:latest
```

Browse to to `http://127.0.0.1:2015`

## Advanced Example

```sh
$ docker run -d \
    --name caddy \
    --restart unless-stopped \
    -p 80:80 -p 443:443 \
    -v /var/www:/srv \
    -v $YOUR_CADDYFILEPATH:/etc/Caddyfile \
    -v /etc/ssl/caddy:/root/.caddy \
    -e CLOUDFLARE_EMAIL=$YOUR_CF_EMAIL \
    -e CLOUDFLARE_API_KEY=$YOUR_CF_API_KEY \
    -e SITE_DOMAIN=$YOUR_SITE_DOMAIN \
    -e BASICAUTH_USERNAME=$SECRET_USERNAME \
    -e BASICAUTH_PASSWORD=$SECRET_PASSWORD \
    jmb12686/caddy:latest \
    -email=$EMAIL_FOR_LETSENCRYPT_SIGNUP
```

## Build and Publish

This image is designed to support multiarchitecture images for usage on both ARM and amd64 hosts.  Setup local environment to support Docker experimental feature for building multi architecture images, [buildx](https://docs.docker.com/buildx/working-with-buildx/).  Follow instructions [here](https://engineering.docker.com/2019/04/multi-arch-images/)

Clone repo and Build multiarch image:

```bash
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t jmb12686/caddy:latest --push .
```
