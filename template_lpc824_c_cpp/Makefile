# Project settings
BIN_NAME = template_lpc824_c_cpp
MCU = lpc824
BOARD = BOARD_COBALT_ANT
C_SOURCES = src/crp.c src/mtb.c src/sysinit.c
CPP_SOURCES = src/cr_cpp_config.cpp src/cr_startup_lpc82x.cpp src/template_lpc824_c_cpp.cpp
INCLUDES = -Iinc -I../lpc_chip_8xx/inc
LDSCRIPT = -T"ld/nxp_$(MCU).ld"
RLIBDIR = -L"../lpc_chip_8xx/bin/release"
RLIBS = -llpc_chip_8xx
DLIBDIR = -L"../lpc_chip_8xx/bin/debug"
DLIBS = -llpc_chip_8xx

# Toolchain settings
MAKE = make
MKDIR = mkdir
RM = rm
CXX = gcc
CPP = g++
TOOLCHAIN_PREFIX = arm-none-eabi-
SIZE = size
AR = ar
OBJDUMP = objdump
OBJCOPY = objcopy

# Toolchain flags
COMPILE_CXX_FLAGS = -std=gnu11 -Wall -Wextra 
COMPILE_CPP_FLAGS = -std=c++17 -Wall -Wextra
# used for embedded projects
DEFINES = -D__NEWLIB__ -D__CODE_RED -DCORE_M0PLUS -D__MTB_BUFFER_SIZE=256 -D__USE_ROMDIVIDE -D__USE_LPCOPEN -DNO_BOARD_LIB -DCPP_NO_HEAP -D__LPC82X__
RDEFINES = -DNDEBUG
DDEFINES = -DDEBUG
CXX_RCOMPILE_FLAGS = $(DEFINES) $(RDEFINES) -Os -fno-common -g -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m0 -mthumb
CXX_DCOMPILE_FLAGS = $(DEFINES) $(DDEFINES) -O0 -fno-common -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m0 -mthumb
CPP_RCOMPILE_FLAGS = $(DEFINES) $(RDEFINES) -Os -fno-common -Os -g -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -fno-rtti -fno-exceptions -mcpu=cortex-m0 -mthumb
CPP_DCOMPILE_FLAGS = $(DEFINES) $(DDEFINES) -O0 -fno-common -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -fno-rtti -fno-exceptions -mcpu=cortex-m0 -mthumb


# used for embedded
LINK_FLAGS = -nostdlib -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0 -mthumb
RLINK_FLAGS =
DLINK_FLAGS =


# Clear built-in rules
.SUFFIXES:

# Function used to check variables. Use on the command line:
# make print-VARNAME
# Useful for debugging and adding features
print-%: ; @echo $*=$($*)

# Combine compiler and linker flags
release: export CXXFLAGS := $(CXXFLAGS) $(COMPILE_CXX_FLAGS) $(CXX_RCOMPILE_FLAGS)
release: export CPPFLAGS := $(CPPFLAGS) $(COMPILE_CPP_FLAGS) $(CPP_RCOMPILE_FLAGS)
release: export LDFLAGS := $(LINK_FLAGS) $(RLINK_FLAGS) $(LIBDIR) $(RLIBDIR) $(LDSCRIPT)
release: export LIBS := $(LIBS) $(RLIBS)
debug: export CXXFLAGS := $(CXXFLAGS) $(COMPILE_CXX_FLAGS) $(CXX_DCOMPILE_FLAGS)
debug: export CPPFLAGS := $(CPPFLAGS) $(COMPILE_CPP_FLAGS) $(CPP_DCOMPILE_FLAGS)
debug: export LDFLAGS := $(LINK_FLAGS) $(DLINK_FLAGS) $(LIBDIR) $(DLIBDIR) $(LDSCRIPT)
debug: export LIBS := $(LIBS) $(DLIBS)

# Build and output paths
release: export BUILD_PATH := build/release
release: export BIN_PATH := bin/release
debug: export BUILD_PATH := build/debug
debug: export BIN_PATH := bin/debug

# export what target we are building, used for size logs
release: export BUILD_TARGET := release
debug: export BUILD_TARGET := debug

# Set the object file names, with the source directory stripped
# from the path, and the build path prepended in its place
OBJECTS = $(C_SOURCES:%.c=$(BUILD_PATH)/%.c.o)
OBJECTS += $(CPP_SOURCES:%.cpp=$(BUILD_PATH)/%.cpp.o)
# Set the dependency files that will be used to add header dependencies
DEPS = $(OBJECTS:.o=.d)

# Standard, non-optimized release build
.PHONY: release
release: dirs
	# make lpc_chip library if needed
	$(MAKE) -C ../lpc_chip_8xx release
	$(MAKE) all --no-print-directory

# Debug build for gdb debugging
.PHONY: debug
debug: dirs
	# make lpc_chip library if needed
	$(MAKE) -C ../lpc_chip_8xx debug
	$(MAKE) all --no-print-directory

# Create the directories used in the build
.PHONY: dirs
dirs:
	$(MKDIR) -p $(BUILD_PATH)
	$(MKDIR) -p $(BIN_PATH)

# Removes all build files
.PHONY: clean clean_debug clean_release
clean_debug:
clean_release:
clean:
	$(RM) -r build
	$(RM) -r bin

# Main rule, checks the executable and symlinks to the output
all: $(BIN_PATH)/$(BIN_NAME).axf

# create the archive
$(BIN_PATH)/$(BIN_NAME).axf: $(OBJECTS)
	$(TOOLCHAIN_PREFIX)$(CPP) $(LDFLAGS) $(OBJECTS) -Xlinker -Map="$@.map" -o $@ $(LIBS)
	# dump size and log to file
	$(TOOLCHAIN_PREFIX)$(SIZE) $@
	date >> size$(BUILD_TARGET).log
	$(TOOLCHAIN_PREFIX)$(SIZE) $@ >> size$(BUILD_TARGET).log
	# create the various output files
	$(TOOLCHAIN_PREFIX)$(OBJCOPY) -R .stack -O binary $@ $(BIN_PATH)/$(BIN_NAME).bin
	$(TOOLCHAIN_PREFIX)$(OBJDUMP) -h -S "$@" > "$(BIN_PATH)/$(BIN_NAME).lss"

# Add dependency files, if they exist
-include $(DEPS)

# Source file rules
# After the first compilation they will be joined with the rules from the
# dependency files to provide header dependencies
# if the source file is in a subdir, create this subdir in the build dir
$(BUILD_PATH)/%.c.o: ./%.c
	$(MKDIR) -p $(dir $@) 
	$(TOOLCHAIN_PREFIX)$(CXX) $(CXXFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@

$(BUILD_PATH)/%.cpp.o: ./%.cpp
	$(MKDIR) -p $(dir $@) 
	$(TOOLCHAIN_PREFIX)$(CPP) $(CPPFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@
