# VHDL w/ GHDL and Nandland Go Board

Followed tutorials for using GHDL https://ghdl.github.io/ghdl/quick_start/index.html

## Docker
Using containers provided here https://github.com/hdl/containers

## Makefile
Adapted Makefile from https://github.com/rej696/nandland-goboard-vhdl-examples for building and programming

Added featuers for multifile projects, simulators. check full_adder.

## iceprog
iceprog is for programming, must be natively installed (not in a container). 

There are scripts located here to install https://github.com/ddm/icetools/tree/master

I built from source:
```bash
git clone https://github.com/YosysHQ/icestorm.git ~/opt/icestorm
cd ~/opt/icestorm
make
sudo make install
```


## Links
- Learn VHDL resources from GHDL: https://github.com/ghdl/ghdl/issues/1291
- VHDL Reference Manual: https://edg.uchicago.edu/~tang/VHDLref.pdf

