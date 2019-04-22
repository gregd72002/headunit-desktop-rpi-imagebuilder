################################################################################
#
# qt-gstreamer
#
################################################################################

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BASE),y)
QT_GSTREAMER_VERSION = a0e95b2
QT_GSTREAMER_REPO_URL = https://github.com/GStreamer/qt-gstreamer
QT_GSTREAMER_SITE_METHOD = git
QT_GSTREAMER_GIT_SUBMODULES = y
QT_GSTREAMER_SITE = $(call qstrip,$(QT_GSTREAMER_REPO_URL))
else
QT_GSTREAMER_VERSION = 0.10.3
QT_GSTREAMER_SOURCE = qt-gstreamer-$(QT_GSTREAMER_VERSION).tar.gz
QT_GSTREAMER_SITE = http://gstreamer.freedesktop.org/src/qt-gstreamer
endif
QT_GSTREAMER_DEPENDENCIES = boost
QT_GSTREAMER_LICENSE = LGPLv2.1
QT_GSTREAMER_LICENSE_FILES = COPYING
QT_GSTREAMER_INSTALL_STAGING = YES
QT_GSTREAMER_CONF_OPTS = -DUSE_GST_PLUGIN_DIR=ON -DUSE_QT_PLUGIN_DIR=ON \
	-DQTGSTREAMER_QTQUICK1_INSTALL_DIR=/usr/imports -DQTGSTREAMER_QTQUICK2_INSTALL_DIR=/usr/qml

ifeq ($(BR2_PREFER_STATIC),y)
QT_GSTREAMER_CONF_OPTS += -DQTGSTREAMER_STATIC=ON
endif

ifeq ($(BR2_PACKAGE_QT_GSTREAMER_EXAMPLES),y)
QT_GSTREAMER_CONF_OPTS += -DQTGSTREAMER_EXAMPLES=ON
endif

ifeq ($(BR2_PACKAGE_QT5DECLARATIVE),y)
QT_GSTREAMER_DEPENDENCIES += qt5declarative
endif

ifeq ($(BR2_PACKAGE_QT5BASE),y)
QT_GSTREAMER_DEPENDENCIES += qt5base
QT_GSTREAMER_CONF_OPTS += -DQT_VERSION=5
else
ifeq ($(BR2_PACKAGE_QT),y)
QT_GSTREAMER_DEPENDENCIES += qt
QT_GSTREAMER_CONF_OPTS += -DQT_VERSION=4
endif
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BASE),y)
QT_GSTREAMER_DEPENDENCIES += gst1-plugins-base
QT_GSTREAMER_GST_VERSION = gstreamer-1.0
else
ifeq ($(BR2_PACKAGE_GST_PLUGINS_BASE),y)
QT_GSTREAMER_DEPENDENCIES += gst-plugins-base
QT_GSTREAMER_GST_VERSION = gstreamer-0.10
endif
endif

# QtQuick2 is only support in Qt-Gstreamer 1.2
ifeq ($(BR2_PACKAGE_QT5DECLARATIVE)$(BR2_PACKAGE_GST1_PLUGINS_BASE),yy)
define QT_GSTREAMER_INSTALL_TARGET_QML
	cp -a $(STAGING_DIR)/usr/qml/QtGStreamer $(TARGET_DIR)/usr/qml
endef
endif

ifeq ($(BR2_PACKAGE_QT5QUICK1),y)
define QT_GSTREAMER_INSTALL_TARGET_QUICK
	cp -a $(STAGING_DIR)/usr/imports/QtGStreamer $(TARGET_DIR)/usr/imports
endef
endif

define QT_GSTREAMER_INSTALL_TARGET_LIBS
	cp -a $(STAGING_DIR)/usr/lib/$(QT_GSTREAMER_GST_VERSION)/libgstqt5videosink* $(TARGET_DIR)/usr/lib/$(QT_GSTREAMER_GST_VERSION)
	cp -a $(STAGING_DIR)/usr/lib/libQt5GLib* $(TARGET_DIR)/usr/lib
	cp -a $(STAGING_DIR)/usr/lib/libQt5GStreamer* $(TARGET_DIR)/usr/lib
	cp -a $(STAGING_DIR)/usr/lib/libQt5GStreamerUi* $(TARGET_DIR)/usr/lib
	cp -a $(STAGING_DIR)/usr/lib/libQt5GStreamerUtils* $(TARGET_DIR)/usr/lib
endef

define QT_GSTREAMER_INSTALL_TARGET_CMDS
	$(QT_GSTREAMER_INSTALL_TARGET_LIBS)
	$(QT_GSTREAMER_INSTALL_TARGET_QML)
	$(QT_GSTREAMER_INSTALL_TARGET_QUICK)
	$(call QT5_INSTALL_TARGET_EXAMPLES,qt-gstreamer)
endef

$(eval $(cmake-package))

