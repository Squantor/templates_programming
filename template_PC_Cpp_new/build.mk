# MIT License

# Copyright (c) 2020 Bart Bilos

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Build engine, inspired by: https://github.com/bronson/makefile-death
#
# Version: 20200424

# transform build specific variables to variables used by the build
COPYVARS += SOURCE CFLAGS CXXFLAGS INCLUDES LIBS
$(foreach V,$(COPYVARS),$(eval $(V) += $$($(V)_$(CONFIG))))

BIN_PATH := bin/$(CONFIG)
OBJ_PATH := build/$(CONFIG)
EXECUTABLE := $(BIN_PATH)/$(PRJNAME).elf

OBJECTS += $(addprefix $(OBJ_PATH)/, $(addsuffix .o,$(FILES)))
DEPS = $(OBJECTS:.o=.d)
COMMONDEPS+= $(OBJ_PATH)/build-tag $(BIN_PATH)/build-tag

all: $(EXECUTABLE)
	
.PHONY: all

-include $(DEPS)

$(BIN_PATH)/build-tag:
	$(MKDIR) -p $(BIN_PATH)
	$(TOUCH) $@

$(OBJ_PATH)/build-tag:
	$(MKDIR) -p $(OBJ_PATH)
	$(TOUCH) $@

$(EXECUTABLE): $(OBJECTS)
	$(TOOLCHAIN_PREFIX)$(CXX_COMPILER) $(LDFLAGS) $(OBJECTS) -Xlinker -Map="$@.map" -o $@ $(LIBS)
	$(TOOLCHAIN_PREFIX)$(SIZE) -x --format=SysV $@ 
	date >> size$(CONFIG).log
	$(TOOLCHAIN_PREFIX)$(SIZE) $@ >> size$(CONFIG).log
	$(TOOLCHAIN_PREFIX)$(OBJCOPY) -R .stack -O binary $@ $(BIN_PATH)/$(PRJNAME).bin
	$(TOOLCHAIN_PREFIX)$(OBJDUMP) -h -S "$@" > "$(BIN_PATH)/$(PRJNAME).lss"

$(OBJ_PATH)/%.c.o: %.c $(COMMONDEPS)
	$(MKDIR) -p $(dir $@) 
	$(TOOLCHAIN_PREFIX)$(C_COMPILER) $(CFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@

$(OBJ_PATH)/%.cpp.o: ./%.cpp $(COMMONDEPS)
	$(MKDIR) -p $(dir $@) 
	$(TOOLCHAIN_PREFIX)$(CXX_COMPILER) $(CXXFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@

$(OBJ_PATH)/%.s.o: ./%.s $(COMMONDEPS)
	$(MKDIR) -p $(dir $@) 
	$(TOOLCHAIN_PREFIX)$(C_COMPILER) $(ASMFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@

clean: $(COMMONDEPS)
	$(RM) -r $(BIN_PATH)
	$(RM) -r $(OBJ_PATH)
.PHONY: clean

