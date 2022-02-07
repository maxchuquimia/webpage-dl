prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib
buildroot = $(shell swift build -c release --show-bin-path)

build: configure
	xcrun swift build -c release --disable-sandbox

install: build
	# Seems like brew hasn't created this yet and it confuses 'install' so...
	mkdir -p "$(bindir)"
	mkdir -p "$(libdir)"
	# Install the binary
	install "$(buildroot)/webpage-dl" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/webpage-dl"

clean:
	rm -rf .build

.PHONY: build install uninstall clean configure
