OBJDIR=build
version=version
version_EXE=$(OBJDIR)/$(version)

version_SRCS=$(wildcard src/*.c)
version_OBJS=$(version_SRCS:src/%.c=$(OBJDIR)/%.o)

ifndef PREFIX
install_PREFIX=/usr/local
else
install_PREFIX=$(PREFIX)
endif

install_bin_DIR=$(install_PREFIX)/bin

CC       = clang
CFLAGS  += -O3 -fPIC -I include/version
LDFLAGS +=

.PHONY: help all clean install uninstall $(install_bin_DIR)/$(version)

all: $(version_EXE)

help:
	$(info usage: `make help/clean/install/uninstall` or just `make`.)
	$(info use `make PREFIX=/usr/local install` or `PREFIX=/usr/local make install` to override default install location.)


clean: 
	rm -rf $(OBJDIR)

$(install_bin_DIR): 
	mkdir -p $(install_bin_DIR)

install: | $(install_bin_DIR)
install: $(version_EXE)
	cp $(version_EXE) $(install_bin_DIR)/

uninstall: $(install_bin_DIR)/$(version)
	rm -f $(install_bin_DIR)/$(version)

$(OBJDIR): 
	mkdir -p $(OBJDIR)

$(version_EXE): $(version_OBJS)
	$(LINK.c) -o $(version_EXE) $(version_OBJS)

$(version_OBJS): | $(OBJDIR)

$(OBJDIR)/%.o: src/%.c
	$(COMPILE.c) -o $@ $<




