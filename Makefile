# Makefile for skinkcov (coverage report tool for `skink -cov` builds)
#
# Usage:
#   make          - build the skinkcov binary
#   make check    - type-check skinkcov without linking
#   make install  - install skinkcov to $(BINDIR)
#   make clean    - remove build artifacts

SKINK_PREFIX ?= $(HOME)/.local/skink
BINDIR       ?= $(SKINK_PREFIX)/bin
SKINK        ?= skink
SKINK_HOME   ?= $(SKINK_PREFIX)/std

SKINKCOV_BIN  := skinkcov
SKINKCOV_MAIN := skinkcov.skink

.DEFAULT_GOAL := all
.PHONY: all build check install clean help

all: build

build:
	@echo "Building skinkcov..."
	SKINK_HOME=$(SKINK_HOME) $(SKINK) -o $(SKINKCOV_BIN) $(SKINKCOV_MAIN)
	@echo "Built: $(SKINKCOV_BIN)"

check:
	SKINK_HOME=$(SKINK_HOME) $(SKINK) -check $(SKINKCOV_MAIN)
	@echo "type check passed"

install: build
	mkdir -p $(BINDIR)
	cp $(SKINKCOV_BIN) $(BINDIR)/$(SKINKCOV_BIN)
	@echo "installed $(SKINKCOV_BIN) to $(BINDIR)"

clean:
	rm -f $(SKINKCOV_BIN)
	rm -f *.ll *.o __skink_*

help:
	@echo "Targets: build, check, install, clean"
