#!/bin/bash
# https://ghdl.github.io/ghdl/quick_start/simulation/heartbeat/index.html
ghdl() {
    docker run -it --rm -u $(id -u):$(id -g) -v $PWD:/src -w /src hdlc/impl:icestorm ghdl $@
}
ghdl -a heartbeat.vhdl
ghdl -r heartbeat --wave=wave.ghw
