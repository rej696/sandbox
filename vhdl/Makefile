TOP ?= top
BOARD ?= goboard
UVX ?= uvx
PYTHON ?= python3

UID = $(shell id -u)
GID = $(shell id -g)
PWD = $(shell pwd)

DOCKER = docker run -it --rm -u $(UID):$(GID) -v $(PWD):/src -w /src
DOCKER-BUILD = $(DOCKER) hdlc/impl:icestorm
DOCKER-PROG = $(DOCKER) hdlc/prog

GHDL = $(DOCKER-BUILD) ghdl
YOSYS = $(DOCKER-BUILD) yosys
NEXTPNR = $(DOCKER-BUILD) nextpnr-ice40
ICEPACK = $(DOCKER-BUILD) icepack
# Don't use docker for programming, device pass through doesn't work
ICEPROG = iceprog
TINYPROG = $(UVX) tinyprog

VHDL_SOURCES = $(shell find . -name "*.vhdl")

ifeq ($(BOARD),goboard)
# Nandland Go Board Settings
PCF ?= ../constraints/goboard.pcf
GHDL_GENERICS = #-gCLK_FREQUENCY=25000000
PACKAGE = vq100
DEVICE = hx1k
FREQ = 25
PROG = $(ICEPROG)

else ifeq ($(BOARD),tinyfpga)
# Nandland Go Board Settings
#
PCF ?= ../constraints/tinyfpga.pcf
GHDL_GENERICS = #-gCLK_FREQUENCY=16000000
PACKAGE = cm81
DEVICE = lp8k
FREQ = 16
PROG = $(TINYPROG) -p

endif

VERBOSE ?= 0

ifeq ($(VERBOSE),1)
Q=
VERBOSE_GHDL = -v
VERBOSE_PNR =
VERBOSE_YOSYS =
else
Q=@
VERBOSE_GHDL =
VERBOSE_PNR = --quiet
VERBOSE_YOSYS = -q
endif

WORKDIR = build/$(BOARD)
PNR_REPORT = $(WORKDIR)/pnr-report.json

.PHONY: all build synth pnr sim prog clean report

all: $(WORKDIR)/$(TOP).bin

build: $(WORKDIR)/$(TOP).bin

synth: $(WORKDIR)/$(TOP).json

pnr: $(WORKDIR)/$(TOP).asc

report: pnr
	$(Q) $(PYTHON) -m json.tool $(PNR_REPORT)

sim: $(VHDL_SOURCES)
	$(Q) echo "Simulating"
	$(Q) mkdir -p $(WORKDIR)
	$(Q) $(GHDL) -i $(VERBOSE_GHDL) --workdir=$(WORKDIR) $(VHDL_SOURCES)
	$(Q) $(GHDL) -m $(VERBOSE_GHDL) --workdir=$(WORKDIR) $(TOP)_tb
	$(Q) $(GHDL) -r $(VERBOSE_GHDL) --workdir=$(WORKDIR) $(TOP)_tb

prog: $(WORKDIR)/$(TOP).bin
	$(Q) echo "Programming $(BOARD)"
	$(Q) $(PROG) $<

clean:
	$(Q) rm -rf build

$(WORKDIR)/$(TOP).bin: $(WORKDIR)/$(TOP).asc
	$(Q) echo "Generating Bitstream"
	$(Q) $(ICEPACK) $< $@

$(WORKDIR)/$(TOP).asc: $(WORKDIR)/$(TOP).json
	$(Q) echo "Place'n'Route"
	$(Q) $(NEXTPNR) $(VERBOSE_PNR) --$(DEVICE) --json $< --freq $(FREQ) --pcf $(PCF) --pcf-allow-unconstrained --package $(PACKAGE) --report $(PNR_REPORT) --asc $@

$(WORKDIR)/$(TOP).json: $(VHDL_SOURCES)
	$(Q) echo "Synthesizing"
	$(Q) mkdir -p $(WORKDIR)
	$(Q) $(GHDL) -i $(VERBOSE_GHDL) --workdir=$(WORKDIR) $(VHDL_SOURCES)
	$(Q) $(GHDL) -m $(VERBOSE_GHDL) --workdir=$(WORKDIR) $(TOP)
	$(Q) $(YOSYS) $(VERBOSE_YOSYS) -m ghdl -p "ghdl --workdir=$(WORKDIR) $(TOP); synth_ice40 -json $@"
