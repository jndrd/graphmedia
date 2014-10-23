AC_INIT([graphmedia],
        [0.0],
        [http://somesite.com],
        [graphmedia],
        [https://somesite.com/bugs])

AC_CONFIG_SRCDIR([src/main.vala])

AC_CONFIG_AUX_DIR([build-aux])

AM_INIT_AUTOMAKE([1.11 foreign no-dist-gzip dist-xz])
AM_SILENT_RULES([yes])
LT_INIT

AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_CC_STDC
AM_PROG_VALAC([0.24])
AC_PROG_INSTALL

AC_PATH_PROG(GLIB_COMPILE_RESOURCES, glib-compile-resources)
AC_PATH_PROG(GLIB_COMPILE_SCHEMAS, glib-compile-schemas)

GLIB_GSETTINGS

#Paquetes para gee
GRAPHMEDIA_PACKAGES="--pkg gee-0.8 --pkg sqlite3 --pkg gtk+-3.0 --pkg gdk-x11-3.0 "
PKG_CHECK_MODULES(GRAPHMEDIA, [ gee-0.8 sqlite3 gtk+-3.0  gdk-x11-3.0])

AC_SUBST(GRAPHMEDIA_CFLAGS)
AC_SUBST(GRAPHMEDIA_LIBS)
AC_SUBST(GRAPHMEDIA_PACKAGES)

-GTK_REQUIRED=3.14.0
+GTK_REQUIRED=3.14.0
RSVG_REQUIRED=2.32.0
CANBERRA_GTK_REQUIRED=0.26
CLUTTER_REQUIRED=1.0.0

	
GETTEXT_PACKAGE=AC_PACKAGE_NAME
AC_SUBST(GETTEXT_PACKAGE)
AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE, "${GETTEXT_PACKAGE}", [The name of the gettext domain])

AC_CONFIG_FILES([
	Makefile
])

AC_OUTPUT
