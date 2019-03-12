# project name
BIN_NAME = template_microcontroller
MCU = LPC824
BOARD =
C_SOURCES =
CXX_SOURCES = src/startup.cpp src/main.cpp
S_SOURCES =
INCLUDES = -Iinc
ALIBS +=
RLIBS += 
DLIBS += 
ALIBDIR +=
RLIBDIR +=
DLIBDIR +=
DEFINES =
COMPILE_C_FLAGS = -std=gnu11 -Wall -Wextra -Wno-main -fno-common -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections
COMPILE_CXX_FLAGS = -std=c++17 -Wall -Wextra -Wno-main -fno-common -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -fno-rtti -fno-exceptions
COMPILE_ASM_FLAGS = -c -x assembler-with-cpp
LINK_FLAGS =