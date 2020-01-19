OBJDIR=build
bin=perfctrs-enum-objects
bin_EXE=$(OBJDIR)/$(bin)

bin_SRCS=$(wildcard src/*.c)
bin_OBJS=$(bin_SRCS:src/%.c=$(OBJDIR)/%.o)

ifndef PREFIX
install_PREFIX=/usr/local
else
install_PREFIX=$(PREFIX)
endif

install_bin_DIR=$(install_PREFIX)/bin

CC       = x86_64-w64-mingw32-gcc
CFLAGS  += -DUNICODE -O3 -fPIC -I./include
LDFLAGS += -lpdh
       # -Wl,--out-implib=libpdh.a

.PHONY: help all clean install uninstall $(install_bin_DIR)/$(bin)

all: $(bin_EXE)

help:
	$(info usage: `make help/clean/install/uninstall` or just `make`.)
	$(info use `make PREFIX=/usr/local install` or `PREFIX=/usr/local make install` to override default install location.)


clean: 
	rm -rf $(OBJDIR)

$(install_bin_DIR): 
	mkdir -p $(install_bin_DIR)

install: | $(install_bin_DIR)
install: $(bin_EXE)
	cp $(bin_EXE) $(install_bin_DIR)/

uninstall: $(install_bin_DIR)/$(bin)
	rm -f $(install_bin_DIR)/$(bin)

$(OBJDIR): 
	mkdir -p $(OBJDIR)

$(bin_EXE): $(bin_OBJS)
	$(LINK.c) -o $(bin_EXE) $(bin_OBJS)

$(bin_OBJS): | $(OBJDIR)

$(OBJDIR)/%.o: src/%.c
	$(COMPILE.c) -o $@ $<




