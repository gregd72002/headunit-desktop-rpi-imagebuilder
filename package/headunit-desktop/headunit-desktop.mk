#############################################################
#
# headunit-desktop 
#
#############################################################
HEADUNIT_DESKTOP_VERSION = master
HEADUNIT_DESKTOP_SITE_METHOD = git
HEADUNIT_DESKTOP_REPO_URL = https://github.com/viktorgino/headunit-desktop.git 
HEADUNIT_DESKTOP_SITE = $(call qstrip,$(HEADUNIT_DESKTOP_REPO_URL))
HEADUNIT_DESKTOP_DEPENDENCIES =

define HEADUNIT_DESKTOP_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
#	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNEL_SRC=$(LINUX_DIR) KVERSION=$(LINUX_VERSION_PROBED) modules
endef

define HEADUNIT_DESKTOP_INSTALL_TARGET_CMDS
	DESTDIR=$(TARGET_DIR) $(MAKE) -C $(@D) install 
endef

$(eval $(generic-package))
