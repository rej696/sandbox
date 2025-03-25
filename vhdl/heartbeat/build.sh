#!/bin/bash
# https://ghdl.github.io/ghdl/quick_start/simulation/heartbeat/index.html
../ghdl -a heartbeat.vhdl
../ghdl -r heartbeat --wave=wave.ghw
