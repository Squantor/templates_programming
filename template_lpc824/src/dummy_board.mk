# update per change V0002
# board specific settings
MCU = LPC812
C_SOURCES +=
CXX_SOURCES += src/$(BOARD).cpp
S_SOURCES +=
DEFINES += -D$(BOARD)
INCLUDES += -Iinc
ALIBS +=
RLIBS +=
DLIBS +=
ALIBDIR +=
RLIBDIR +=
DLIBDIR +=

#custom build rules
pre-clean:

pre-release:

pre-debug:

#project hardware specific commands
gdbusbdebug: debug
	$(TOOLCHAIN_PREFIX)$(GDB) -x ./gdb_scripts/bmpUSBdebug.txt

gdbusbrelease: release
	$(TOOLCHAIN_PREFIX)$(GDB) -x ./gdb_scripts/bmpUSBrelease.txt

tpwrdisable:
	$(TOOLCHAIN_PREFIX)$(GDB) -x ./gdb_scripts/bmpusb_tpwr_disable.txt

tpwrenable:
	$(TOOLCHAIN_PREFIX)$(GDB) -x ./gdb_scripts/bmpusb_tpwr_enable.txt

.PHONY: pre-clean pre-release pre-debug gdbusbdebug gdbusbrelease tpwrdisable tpwrenable