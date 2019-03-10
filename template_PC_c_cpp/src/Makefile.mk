# project settings
BIN_NAME = frame_console_c_cpp
C_SOURCES = src/test.c
CXX_SOURCES = src/main.cpp src/test.cpp
S_SOURCES =
INCLUDES = -Iinc
COMPILE_C_FLAGS += -std=gnu11 -Wall -Wextra
COMPILE_CXX_FLAGS += -std=c++17 -Wall -Wextra
COMPILE_ASM_FLAGS += -c -x assembler-with-cpp
LINK_FLAGS += -flto -Xlinker --gc-sections -Xlinker -print-memory-usage