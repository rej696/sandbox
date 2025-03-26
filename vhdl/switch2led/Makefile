TOP ?= top
WORKDIR ?= build
PCF ?= goboard.pcf

UID = $(shell id -u)
GID = $(shell id -g)

DOCKER = docker run -it --rm -u $(UID):$(GID) -v $(PWD):/src -w /src
DOCKER-BUILD = $(DOCKER) hdlc/impl:icestorm
DOCKER-PROG = $(DOCKER) hdlc/prog

GHDL = $(DOCKER-BUILD) ghdl
YOSYS = $(DOCKER-BUILD) yosys
NEXTPNR = $(DOCKER-BUILD) nextpnr-ice40
ICEPACK = $(DOCKER-BUILD) icepack
# Don't use docker for programming, device pass through doesn't work
ICEPROG = iceprog

VHDL_SOURCES = $(shell find . -name "*.vhdl")

# Nandland Go Board Settings
GHDL_GENERICS = #-gCLK_FREQUENCY=25000000
PACKAGE = vq100
DEVICE = -hx1k
FREQ = --freq 25

.PHONY: all build sim prog clean

all: $(WORKDIR)/$(TOP).bin

build: $(WORKDIR)/$(TOP).bin

sim: $(VHDL_SOURCES)
	mkdir -p $(WORKDIR)
	$(GHDL) -i -v --workdir=$(WORKDIR) $(VHDL_SOURCES)
	$(GHDL) -m -v --workdir=$(WORKDIR) $(TOP)
	$(GHDL) -r -v --workdir=$(WORKDIR) $(TOP)

prog: $(WORKDIR)/$(TOP).bin
	$(ICEPROG) $<

clean:
	rm -rf $(WORKDIR)

$(WORKDIR)/$(TOP).bin: $(WORKDIR)/$(TOP).asc
	$(ICEPACK) $< $@

$(WORKDIR)/$(TOP).asc: $(WORKDIR)/$(TOP).json
	$(NEXTPNR) --hx1k --json $< $(FREQ) --pcf $(PCF) --pcf-allow-unconstrained --package $(PACKAGE) --asc $@

$(WORKDIR)/$(TOP).json: $(VHDL_SOURCES)
	mkdir -p $(WORKDIR)
	$(GHDL) -i -v --workdir=$(WORKDIR) $(VHDL_SOURCES)
	$(GHDL) -m -v --workdir=$(WORKDIR) $(TOP)
	$(YOSYS) -m ghdl -p "ghdl --workdir=$(WORKDIR) $(TOP); synth_ice40 -json $@"
