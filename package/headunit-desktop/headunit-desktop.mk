#############################################################
#
# headunit-desktop 
#
#############################################################

HEADUNIT_DESKTOP_VERSION = 18e430f
HEADUNIT_DESKTOP_SITE_METHOD = git
HEADUNIT_DESKTOP_REPO_URL = https://github.com/viktorgino/headunit-desktop.git
HEADUNIT_DESKTOP_GIT_SUBMODULES = y
HEADUNIT_DESKTOP_SITE = $(call qstrip,$(HEADUNIT_DESKTOP_REPO_URL))

HEADUNIT_DESKTOP_DEPENDENCIES = bluez-qt libcanberra libqofono qt5base gconf2 qt-gstreamer protobuf fftw rtl-sdr

define HEADUNIT_DESKTOP_CONFIGURE_CMDS
	cd $(@D); $(HOST_DIR)/bin/protoc --proto_path=modules/android-auto/headunit/hu/ --cpp_out=modules/android-auto/headunit/hu/generated.x64/ modules/android-auto/headunit/hu/hu.proto
	cd $(@D); $(HOST_DIR)/bin/qmake headunit-desktop.pro 
endef

define HEADUNIT_DESKTOP_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define HEADUNIT_DESKTOP_INSTALL_TARGET_CMDS
	INSTALL_ROOT=$(TARGET_DIR) DESTDIR=$(TARGET_DIR) $(MAKE) -C $(@D) install 
endef

$(eval $(generic-package))
