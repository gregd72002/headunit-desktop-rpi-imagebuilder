#############################################################_
#
# libqofono
#
#############################################################

LIBQOFONO_VERSION = 0.94 
LIBQOFONO_SOURCE = libqofono-$(LIBQOFONO_VERSION).tar.gz
LIBQOFONO_SITE = https://git.merproject.org/mer-core/libqofono/-/archive/$(LIBQOFONO_VERSION)
LIBQOFONO_DEPENDENCIES = qt5base ofono
LIBQOFONO_INSTALL_STAGING = YES


define LIBQOFONO_CONFIGURE_CMDS
        (cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake)
endef

define LIBQOFONO_BUILD_CMDS
        $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBQOFONO_INSTALL_STAGING_CMDS
        INSTALL_ROOT=$(STAGING_DIR) $(MAKE) -C $(@D) install

# WORKAROUND INCORRECT INSTALL
	mv $(STAGING_DIR)$(STAGING_DIR)/usr/lib/pkgconfig/qofono* $(STAGING_DIR)/usr/lib/pkgconfig/
	mv $(STAGING_DIR)$(STAGING_DIR)/usr/lib/libqofono-qt5.* $(STAGING_DIR)/usr/lib/

	mkdir --parent $(STAGING_DIR)/usr/qml/MeeGo/
	rsync -a $(STAGING_DIR)$(STAGING_DIR)/usr/qml/MeeGo/QOfono $(STAGING_DIR)/usr/qml/MeeGo/

	$(QT5_LA_PRL_FILES_FIXUP)

	rm -rdf $(STAGING_DIR)$(BASE_DIR)/host/share/qt5/mkspecs/features/qofono-qt5.prf 
	rm -rdf $(STAGING_DIR)$(BASE_DIR)
endef

define LIBQOFONO_INSTALL_TARGET_CMDS
	cp -dpfr $(STAGING_DIR)/usr/include/qofono-qt5 $(TARGET_DIR)/usr/
	cp -dpf $(STAGING_DIR)/usr/lib/libqofono-qt5.* $(TARGET_DIR)/usr/lib
	rsync -a $(STAGING_DIR)/usr/qml/MeeGo/QOfono $(TARGET_DIR)/usr/qml/MeeGo/
endef

$(eval $(generic-package))
