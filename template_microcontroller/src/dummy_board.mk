# update per change V0002
# board specific settings
PLATFORM = LPC812
C_SOURCES +=
CXX_SOURCES += src/$(BOARD).cpp
S_SOURCES +=
DEFINES += -D$(BOARD)
INCLUDES += -Iinc -I../squantorLibC/inc -I../squantorLibEmbeddedC/inc
ALIBS += -lsqlibembeddedc -lsqlibc
RLIBS +=
DLIBS +=
ALIBDIR +=
RLIBDIR += -L"../squantorLibC/bin/CortexM0/release" \
-L"../squantorLibEmbeddedC/bin/CortexM0/release"
DLIBDIR += -L"../squantorLibC/bin/CortexM0/debug" \
-L"../squantorLibEmbeddedC/bin/CortexM0/debug"

#custom build rules
pre-clean:
	$(MAKE) -C ../squantorLibC clean
	$(MAKE) -C ../squantorLibEmbeddedC clean

pre-release:
	$(MAKE) -C ../squantorLibC release PLATFORM=CortexM0
	$(MAKE) -C ../squantorLibEmbeddedC release PLATFORM=CortexM0 LIBC_INC=../squantorLibC/inc/

pre-debug:
	$(MAKE) -C ../squantorLibC debug PLATFORM=CortexM0
	$(MAKE) -C ../squantorLibEmbeddedC debug PLATFORM=CortexM0 LIBC_INC=../squantorLibC/inc/

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
