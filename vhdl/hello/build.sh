#!/bin/bash
# https://ghdl.github.io/ghdl/quick_start/simulation/hello/index.html
ghdl() {
    docker run -it --rm -u $(id -u):$(id -g) -v $PWD:/src -w /src hdlc/impl:icestorm ghdl $@
}
ghdl -a hello.vhdl
ghdl -e hello_world
ghdl -r hello_world
