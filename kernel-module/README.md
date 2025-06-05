# Kernel Modules

## [low level learning youtube tutorial](https://www.youtube.com/playlist?list=PLc7W4b0WHTAX4F1Byvs4Bp7c8yCDSiKa9)

```bash
# build
make

# install
sudo insmod test-kernel-module.ko

# list / show impact
lsmod | grep test-kernel-module
sudo dmesg

# remove
sudo rmmod test-kernel-module
```
