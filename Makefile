PREFIX ?= /usr/local

GIT_VERSION = $(shell git describe --tags )
VERSION = "1.0-zocker"

lure:
	CGO_ENABLED=0 go build -ldflags="-s -w -X 'lure.sh/lure/internal/config.Version=$(VERSION)'"

lureARM:
	CGO_ENABLED=0 GOARCH=arm64 go build -ldflags="-s -w -X 'lure.sh/lure/internal/config.Version=$(VERSION)'"

clean:
	rm -f lure

install: lure installmisc
	install -Dm755 lure $(DESTDIR)$(PREFIX)/bin/lure

installmisc:
	install -Dm755 scripts/completion/bash $(DESTDIR)$(PREFIX)/share/bash-completion/completions/lure
	install -Dm755 scripts/completion/zsh $(DESTDIR)$(PREFIX)/share/zsh/site-functions/_lure

uninstall:
	rm -f /usr/local/bin/lure

.PHONY: install clean uninstall installmisc lure
