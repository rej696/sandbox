
.PHONY: all flash dump

BUILD ?= build
BINARY ?= rom.bin


all: $(BUILD)/$(BINARY)

$(BUILD)/$(BINARY): makerom.py
	@mkdir -p $(@D)
	python3 makerom.py $@

flash: $(BUILD)/$(BINARY)
	minipro -p AT28C256 -w $<

dump: $(BUILD)/$(BINARY)
	hexdump -C $<

clean:
	rm -rf $(BUILD)

