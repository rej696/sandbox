#!/bin/bash
# https://ghdl.github.io/ghdl/quick_start/simulation/hello/index.html
../ghdl -a hello.vhdl
../ghdl -e hello_world
../ghdl -r hello_world
