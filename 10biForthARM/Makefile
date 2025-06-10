CROSS_COMPILE ?= arm-none-eabi-
CC := $(CROSS_COMPILE)gcc
AS := $(CROSS_COMPILE)as
LD := $(CROSS_COMPILE)ld
OBJCOPY := $(CROSS_COMPILE)objcopy
OBJDUMP := $(CROSS_COMPILE)objdump

LDSCRIPT ?= forth.ld
SRC ?= .
BUILD ?= build
TARGET ?= $(BUILD)/firmware
FIFO ?= $(BUILD)/cmdfifo
PROG ?= examples/add

AFLAGS ?= -c -mcpu=arm926ej-s -g
LDFLAGS ?= -T$(LDSCRIPT)

QEMU ?= qemu-system-arm
QEMUPORT ?= 4444
QEMUFLAGS ?= -M versatilepb -m 128M -nographic -audio none
QEMUFLAGS_TCP ?= -serial tcp:localhost:$(QEMUPORT),server
QEMUFLAGS_DBG ?= -s -S

# SOURCES := $(shell find $(SRC) -name '*.S')
SOURCES := $(SRC)/forth.S $(SRC)/$(PROG).S
OBJECTS := $(SOURCES:$(SRC)/%.S=$(BUILD)/%.o)

.PHONY: all run dbg tcp tcpdbg dump dumpprog printprog send
all: $(BUILD)/forth.bin

$(BUILD)/%.o: $(SRC)/%.S
	@mkdir -p $(@D)
	$(AS) $(AFLAGS) -c $< -o $@

$(BUILD)/forth.elf: $(BUILD)/forth.o $(BUILD)/placeholder.o
	$(LD) $(LDFLAGS) $^ -o $@

$(BUILD)/forth.bin: $(BUILD)/forth.elf
	$(OBJCOPY) -O binary $< $@

$(TARGET).elf: $(OBJECTS)
	$(LD) $(LDFLAGS) $^ -o $@

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary -j .text $< $@

clean:
	rm -rf $(BUILD)

run: $(BUILD)/forth.bin
	$(QEMU) $(QEMUFLAGS) -kernel $<

dbg: $(BUILD)/forth.bin
	$(QEMU) $(QEMUFLAGS) $(QEMUFLAGS_DBG) -kernel $<

tcp: $(BUILD)/forth.bin
	$(QEMU) $(QEMUFLAGS) $(QEMUFLAGS_TCP) -kernel $<

tcpdbg: $(BUILD)/forth.bin
	$(QEMU) $(QEMUFLAGS) $(QEMUFLAGS_TCP) $(QEMUFLAGS_DBG) -kernel $<

qemutest: $(TARGET).bin
	$(QEMU) $(QEMUFLAGS) -kernel $<

dump: $(BUILD)/forth.elf
	$(OBJDUMP) -dh $<

dumpprog: $(TARGET).elf
	$(OBJDUMP) -dh $<

printprog: $(TARGET).elf
	@CODE="$$($(OBJDUMP) -j .text -d $<)"; \
	echo "$$CODE" | head -n 10 | tail -n 3; \
	echo "... ..."; \
	echo "$$CODE" | tail -n 3;

trigger:
	echo "00" | xxd -r -p | nc -q 3 -N localhost $(QEMUPORT) | xxd -p -c 1

recv:
	nc -q 3 -N localhost $(QEMUPORT) | xxd -p -c 1

send: $(TARGET).bin printprog
	# @FROM=$$(echo $$(xxd -e $< | sed -E 's/^.*: (.{8}) (.{8}) (.{8}) (.{8}).*$$/\1\2\3\4/') | sed 's/ //g');
	@FROM=$$(echo $$(xxd -p $< ) | sed 's/ //g'); \
	echo "Original: $$FROM"; \
	TO="$$(echo $$(echo $$FROM | sed 's/../& /g' | sed -e 's/\(..\) /01\1/g') | sed 's/ //g')"; \
	echo "Sending: $$TO"; \
	echo "Receiving:"; \
	echo $$TO | xxd -r -p | nc -N localhost $(QEMUPORT) | xxd -p
