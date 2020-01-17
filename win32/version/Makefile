version_SRCS=$(wildcard src/*.c)
version_OBJS=$(version_SRCS:src/%.c=dist/%.o)

OBJDIR=dist
version_EXE=$(OBJDIR)/version

install_PREFIX=/usr/local
install_bin_DIR=$(PREFIX)/bin

CC       = clang
CFLAGS  += -O3 -fPIC
LDFLAGS += -lm

.PHONY: all clean install uninstall

all: $(version_EXE)

clean: 
	rm -rf $(OBJDIR)

$(OBJDIR): 
	mkdir -p $(OBJDIR)

$(version_EXE): $(version_OBJS)
	$(LINK.c) -o $(version_EXE) $(version_OBJS)

$(version_OBJS): | $(OBJDIR)

dist/%.o: src/%.c
	$(COMPILE.c) -o $@ $<




