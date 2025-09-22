ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
ROOT_REL_PATH := $(shell realpath -m --relative-to=$(PROJ_DIR) $(ROOT_DIR))/
PROJ_REL_PATH := $(subst $(ROOT_DIR),,$(basename $(PROJ_DIR)))
PROJ_PATH := $(ROOT_DIR)$(PROJ_REL_PATH)

TOP ?= top
TESTBENCH ?= $(TOP)_tb
BOARD ?= goboard
UVX ?= uvx
PYTHON ?= python3

UID = $(shell id -u)
GID = $(shell id -g)
PWD = $(shell pwd)

DOCKER = docker run --rm -u $(UID):$(GID) -v $(ROOT_DIR):/src -w /src/$(PROJ_REL_PATH)
DOCKER-BUILD = $(DOCKER) hdlc/impl:icestorm
DOCKER-PROG = $(DOCKER) hdlc/prog

GHDL = $(DOCKER-BUILD) ghdl
YOSYS = $(DOCKER-BUILD) yosys
NEXTPNR = $(DOCKER-BUILD) nextpnr-ice40
ICEPACK = $(DOCKER-BUILD) icepack
# Don't use docker for programming, device pass through doesn't work
ICEPROG = iceprog
TINYPROG = $(UVX) tinyprog
GTKWAVE = gtkwave

GHDL_FLAGS = --std=08 --workdir=$(WORKDIR)

VHDL_SOURCES = $(shell find . -name "*.vhdl")
# VHDL_SOURCES_PATH = $(patsubst %,$(PROJ_REL_PATH)%,$(VHDL_SOURCES))

ifeq ($(BOARD),goboard)
# Nandland Go Board Settings
PCF ?= $(ROOT_REL_PATH)constraints/goboard.pcf
GHDL_GENERICS = #-gCLK_FREQUENCY=25000000
PACKAGE = vq100
DEVICE = hx1k
FREQ = 25
PROG = $(ICEPROG)

else ifeq ($(BOARD),tinyfpga)
# Nandland Go Board Settings
#
PCF ?= $(ROOT_REL_PATH)constraints/tinyfpga.pcf
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

.PHONY: all build synth pnr sim wave prog clean report root

build: $(WORKDIR)/$(TOP).bin

root:
	@echo $(ROOT_DIR)
	@echo $(ROOT_REL_PATH)
	@echo $(PROJ_DIR)
	@echo $(PROJ_PATH)
	@echo $(PROJ_REL_PATH)

synth: $(WORKDIR)/$(TOP).json

pnr: $(WORKDIR)/$(TOP).asc

report: pnr
	$(Q) $(PYTHON) -m json.tool $(PNR_REPORT)

sim: $(VHDL_SOURCES)
	$(Q) echo "Simulating"
	$(Q) mkdir -p $(WORKDIR)
	$(Q) $(GHDL) -i $(VERBOSE_GHDL) $(GHDL_FLAGS) $(VHDL_SOURCES)
	$(Q) $(GHDL) -m $(VERBOSE_GHDL) $(GHDL_FLAGS) $(TESTBENCH)
	$(Q) $(GHDL) -r $(VERBOSE_GHDL) $(GHDL_FLAGS) $(TESTBENCH) --vcd=$(WORKDIR)/$(TESTBENCH).vcd --wave=$(WORKDIR)/$(TESTBENCH).ghw

wave: | sim
	$(Q) $(GTKWAVE) $(WORKDIR)/$(TESTBENCH).ghw &


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
	$(Q) $(GHDL) -i $(VERBOSE_GHDL) $(GHDL_FLAGS) $(VHDL_SOURCES)
	$(Q) $(GHDL) -m $(VERBOSE_GHDL) $(GHDL_FLAGS) $(TOP)
	$(Q) $(YOSYS) $(VERBOSE_YOSYS) -m ghdl -p "ghdl $(GHDL_FLAGS) $(TOP); synth_ice40 -json $@"
