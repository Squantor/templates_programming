# update per change V0002
TOOLCHAIN_PREFIX =
C_SOURCES += platform/00_start.c
CXX_SOURCES +=
S_SOURCES += platform/startup.s
DEFINES +=
COMPILE_C_FLAGS += -nostdlib -fomit-frame-pointer -fno-stack-protector -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-unroll-loops -fmerge-all-constants -fno-ident -mfpmath=sse -mfancy-math-387 -ffunction-sections -fdata-sections
COMPILE_CXX_FLAGS += -nostdlib -fno-exceptions -fno-rtti
COMPILE_ASM_FLAGS += -c -x assembler-with-cpp
ALIBS +=
LINK_FLAGS += -Wl,-static -Wl,-nostdlib -Wl,-z -Wl,norelro -Wl,--hash-style=sysv -Wl,--build-id=none -Wl,--gc-sections
LINK_FLAGS_RELEASE += -s
LINKER = ld
