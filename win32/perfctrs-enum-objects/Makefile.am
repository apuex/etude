AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS  = -DUNICODE -fPIC
AM_LDFLAGS = -L. -lpdh \
	--enable-stdcall-fixup

bin_PROGRAMS = format-message \
	       perfctrs

format_message_SOURCES = src/format-message.c
perfctrs_SOURCES = src/perfctrs.c \
		   src/perfctrs-enum-objects.c \
		   src/perfctrs-enum-object-items.c

