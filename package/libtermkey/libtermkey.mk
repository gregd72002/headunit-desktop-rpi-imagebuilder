#############################################################
#
# libtermkey 
#
#############################################################

LIBTERMKEY_VERSION = d9928fd
LIBTERMKEY_SITE_METHOD = git
LIBTERMKEY_REPO_URL = https://github.com/neovim/libtermkey
LIBTERMKEY_GIT_SUBMODULES = y
LIBTERMKEY_INSTALL_STAGING = YES
LIBTERMKEY_SITE = $(call qstrip,$(LIBTERMKEY_REPO_URL))

define LIBTERMKEY_BUILD_CMDS
	PREFIX=$(STAGING_DIR) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define LIBTERMKEY_INSTALL_STAGING_CMDS
	PREFIX=$(STAGING_DIR)/usr $(MAKE) -C $(@D) install 
endef

define LIBTERMKEY_INSTALL_TARGET_CMDS
	PREFIX=$(TARGET_DIR)/usr $(MAKE) -C $(@D) install 
endef

$(eval $(generic-package))
