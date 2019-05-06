#############################################################
#
# headunit-desktop 
#
#############################################################

HEADUNIT_DESKTOP_VERSION = 4ffde41
HEADUNIT_DESKTOP_REPO_URL = https://github.com/gregd72002/headunit-desktop.git

HEADUNIT_DESKTOP_SITE_METHOD = git
HEADUNIT_DESKTOP_GIT_SUBMODULES = y
HEADUNIT_DESKTOP_SITE = $(call qstrip,$(HEADUNIT_DESKTOP_REPO_URL))

HEADUNIT_DESKTOP_DEPENDENCIES = bluez-qt libcanberra libqofono qt5base gconf2 qt-gstreamer protobuf fftw-single rtl-sdr

define HEADUNIT_DESKTOP_CONFIGURE_CMDS
	cd $(@D); $(HOST_DIR)/bin/protoc --proto_path=modules/android-auto/headunit/hu/ --cpp_out=modules/android-auto/headunit/hu/generated.x64/ modules/android-auto/headunit/hu/hu.proto
	cd $(@D); $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/bin/qmake PREFIX=${TARGET_DIR}/opt/ headunit-desktop.pro 
endef

define HEADUNIT_DESKTOP_BUILD_CMDS
	$(MAKE) -C $(@D) all
endef

define HEADUNIT_DESKTOP_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install
	rm -rf $(TARGET_DIR)/opt/themes/default-theme/HUDTheme/*.jpg
endef

$(eval $(generic-package))
