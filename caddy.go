package main

import (
	"github.com/caddyserver/caddy/caddy/caddymain"

	// plug in plugins here, for example:
	// _ "import/path/here"
	// _ "github.com/tarent/loginsrv/tree/master/caddy"
	_ "github.com/BTBurke/caddy-jwt"
	_ "github.com/caddyserver/dnsproviders/cloudflare"
	_ "github.com/captncraig/caddy-realip"
	_ "github.com/echocat/caddy-filter"
	_ "github.com/tarent/loginsrv/caddy"
)

func main() {
	// optional: disable telemetry
	caddymain.EnableTelemetry = false
	caddymain.Run()
}
