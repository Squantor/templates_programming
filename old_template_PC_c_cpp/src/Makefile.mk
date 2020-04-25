# update per change V0007

# project name
BIN_NAME = template_c_cpp
PLATFORM = PC

# project settings
C_SOURCES = src/test.c
CXX_SOURCES = src/main.cpp src/test.cpp
S_SOURCES =
INCLUDES = -Iinc
DEFINES +=
ALIBS +=
RLIBS +=
DLIBS +=
ALIBDIR +=
RLIBDIR +=
DLIBDIR +=
COMPILE_C_FLAGS += -std=gnu11 -Wall -Wextra
COMPILE_CXX_FLAGS += -std=c++17 -Wall -Wextra
COMPILE_ASM_FLAGS += -c -x assembler-with-cpp
LINK_FLAGS += -flto -Wl,--gc-sections -Wl,-print-memory-usage

#custom build rules
pre-clean:

pre-release:

pre-debug:

.PHONY: pre-clean pre-release pre-debug
