AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS  = -DUNICODE -fPIC 
AM_LDFLAGS = -L. -lpdh \
	--enable-stdcall-fixup

bin_PROGRAMS = format-message \
	       perfctrs-enum-objects \
	       perfctrs-enum-object-items

format_message_SOURCES = src/format-message.c
perfctrs_enum_objects_SOURCES = src/perfctrs-enum-objects.c
perfctrs_enum_object_items_SOURCES = src/perfctrs-enum-object-items.c

