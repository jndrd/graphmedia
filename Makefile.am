AUTOMAKE_OPTIONS = subdir-objects

noinst_LTLIBRARIES = src/libmodelos.la

src_libmodelos_la_SOURCES = \
	src/controlador/graphmedia.vala \
	src/controlador/appgui.vala \
	src/controlador/apppreferences.vala \
	src/controlador/dialogos.vala \
	src/controlador/dialogoalbum.vala \
	src/controlador/dialogoarchivo.vala \
	src/db/basedatos.vala \
	src/db/tablas.vala \
	src/db/persona.vala \
	src/db/artista.vala \
	src/db/archivo.vala \
	src/db/cancion.vala \
	src/db/imagen.vala \
	src/db/album.vala \
	src/db/albumcanciones.vala \
	src/db/epoca.vala \
	src/db/sentimientos.vala \
	src/test/generador.vala \
	$(NULL)

src_libmodelos_la_VALAFLAGS = \
	--target-glib=2.38	\
	--pkg gmodule-2.0 \
	--vapi src/modelos.vapi \
	--header src/modelos.h \
	--gresources $(gresource_file)		\
	@GRAPHMEDIA_PACKAGES@		\
	$(NULL)

src_libmodelos_la_CFLAGS =		\
	@GRAPHMEDIA_CFLAGS@		\
	-w
	-export-dynamic	\
	-dynamic-export \
	-rdynamic \
	$(NULL)

src_libmodelos_la_LIBADD =		\
	@GRAPHMEDIA_LIBS@		\
	$(NULL)

bin_PROGRAMS = bin/graphmedia 

bin_graphmedia_SOURCES = 		\
	src/main.vala \
	src/modelos.vapi \
	src/resources.c \
	$(NULL)

bin_graphmedia_VALAFLAGS =		\
	--target-glib=2.38	\
	--gresources $(gresource_file)		\
	--pkg gmodule-2.0 \
	@GRAPHMEDIA_PACKAGES@		\
	$(NULL)

bin_graphmedia_CFLAGS =		\
	@GRAPHMEDIA_CFLAGS@		\
	-I$(srcdir)/src \
	-export-dynamic	\
	-w
	$(NULL)

bin_graphmedia_LDADD =		\
	@GRAPHMEDIA_LIBS@		\
	src/libmodelos.la \
	$(NULL)

gresource_file = $(top_srcdir)/src/ui/graphmedia.gresource.xml
resource_files = 				\
	$(top_srcdir)/src/ui/window.ui		\
	$(top_srcdir)/src/ui/gears-menu.ui		\
	$(top_srcdir)/src/ui/app-menu.ui		\
	$(top_srcdir)/src/ui/dialogs.ui		\
	$(top_srcdir)/src/ui/prefs.ui		\
	$(top_srcdir)/src/ui/home.ui		\
	$(top_srcdir)/src/ui/context.ui		\
	$(top_srcdir)/src/ui/details.ui		\
	$(top_srcdir)/src/ui/dialogoarchivo.ui		\
	$(top_srcdir)/src/ui/dialogoalbums.ui		\
	$(NULL)

src/resources.c: $(gresource_file) $(resource_files)
	$(AM_V_GEN) $(GLIB_COMPILE_RESOURCES) 	\
		--target=$@			\
		--sourcedir=$(top_srcdir)/src/ui	\
		--generate-source $<

schema_file = $(top_srcdir)/src/ui/org.gtk.graphmedia.gschema.xml

gsettings_SCHEMAS =				\
	$(schema_file)				\
	$(NULL)

@GSETTINGS_RULES@

data/gschemas.compiled: $(schema_file)
	$(GLIB_COMPILE_SCHEMAS) $(top_srcdir)/src/ui


bin_PROGRAMS += test/run

test_run_SOURCES =		\
	src/test/testcase.vala \
	src/test/testpersona.vala \
	src/test/testgenerador.vala \
	src/test/testbasedatos.vala \
	src/test/testartistas.vala \
	src/test/testalbums.vala \
	src/test/testsentimientos.vala \
	src/test/testcanciones.vala \
	src/test/testimagenes.vala \
	src/test/main.vala \
	src/modelos.vapi \
	$(NULL)

test_run_VALAFLAGS =		\
	--target-glib=2.38	\
	@GRAPHMEDIA_PACKAGES@		\
	$(NULL)

test_run_CFLAGS =		\
	@GRAPHMEDIA_CFLAGS@		\
	-I$(srcdir)/src \
	-w \
	$(NULL)

test_run_LDADD =		\
	@GRAPHMEDIA_LIBS@		\
	src/libmodelos.la \
	$(NULL)


noinst_DATA =					\
	$(gresource_file)			\
	$(resource_files)			\
	$(NULL)

EXTRA_DIST =					\
	src/ui/graphmedia.desktop.in		\
	src/ui/graphmedia.gresource.xml		\
	$(resource_files)			\
	$(schema_file)				\
	$(NULL)


DISTCLEANFILES =				\
	$(src/ui_desktop_DATA)
