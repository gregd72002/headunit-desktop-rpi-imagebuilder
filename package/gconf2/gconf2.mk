################################################################################
#
# gconf2
#
################################################################################

GCONF2_VERSION = 2.32.4 
GCONF2_SOURCE = GConf-$(GCONF_VERSION).tar.xz
GCONF2_SITE = http://ftp.gnome.org/pub/gnome/sources/GConf/2.32
GCONF2_CONF_OPTS = --disable-orbit
GCONF2_DEPENDENCIES = dbus dbus-glib libglib2 libxml2 \
	host-intltool $(TARGET_NLS_DEPENDENCIES)
GCONF2_LICENSE = LGPL-2.0+
GCONF2_INSTALL_STAGING = YES
GCONF2_LICENSE_FILES = COPYING

$(eval $(autotools-package))
