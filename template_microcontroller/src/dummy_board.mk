# board specific settings
MCU = LPC812
CXX_SOURCES += src/$(BOARD).cpp
DEFINES += -D$(BOARD)