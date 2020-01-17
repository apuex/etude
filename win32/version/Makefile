version_SRCS=$(wildcard src/*.c)
version_OBJS=$(version_SRCS:src/%.c=dist/%.o)

OBJDIR=dist
version_EXE=$(OBJDIR)/version

install_PREFIX=/usr/local
install_bin_DIR=$(PREFIX)/bin

.PHONY: all clean install uninstall

all: $(version_EXE)

clean: 
	rm -rf $(OBJDIR)

$(OBJDIR): 
	mkdir -p $(OBJDIR)

$(version_EXE): $(version_OBJS)
	@$(LINK.c) $(LDFLAGS) -o $@ $<

$(version_OBJS): $(OBJDIR)

$(version_OBJS): $(version_SRCS)
	@$(COMPILE.c) $(CFLAGS) -o $@ $<




