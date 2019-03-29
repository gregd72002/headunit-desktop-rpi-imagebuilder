#############################################################
#
# bluez-qt 
#
#############################################################

#HEADUNIT_DESKTOP_VERSION = 18e430f13b196c29788ce19b06ae15fec814d80a
#HEADUNIT_DESKTOP_SOURCE = $(HEADUNIT_DESKTOP_VERSION).zip 
#HEADUNIT_DESKTOP_SITE = https://github.com/viktorgino/headunit-desktop/archive/

BLUEZ_QT_VERSION = v5.56.0
BLUEZ_QT_SITE_METHOD = git
BLUEZ_QT_REPO_URL = https://github.com/KDE/bluez-qt 
BLUEZ_QT_GIT_SUBMODULES = yes
BLUEZ_QT_SITE = $(call qstrip,$(BLUEZ_QT_REPO_URL))
BLUEZ_QT_INSTALL_STAGING = YES

BLUEZ_QT_DEPENDENCIES = extra-cmake-modules qt5base

define BLUEZ_QT_POST_INSTALL_TARGET_FIXUP
	mkdir --parent $(TARGET_DIR)/usr/qml/org/kde/bluezqt
	rsync -a $(TARGET_DIR)/usr/lib/qml/org/kde/bluezqt $(TARGET_DIR)/usr/qml/org/kde/
	rm -rdf $(TARGET_DIR)/usr/lib/qmp/org/kde/bluezqt
endef

BLUEZ_QT_POST_INSTALL_TARGET_HOOKS += BLUEZ_QT_POST_INSTALL_TARGET_FIXUP


$(eval $(cmake-package))

