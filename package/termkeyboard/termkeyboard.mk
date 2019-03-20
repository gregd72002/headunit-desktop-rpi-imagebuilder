#############################################################
#
# termkeyboard 
#
#############################################################

TERMKEYBOARD_VERSION = 8e310a0 
TERMKEYBOARD_SITE_METHOD = git
TERMKEYBOARD_REPO_URL = https://github.com/chaitu236/TermKeyboard
TERMKEYBOARD_GIT_SUBMODULES = y
TERMKEYBOARD_SITE = $(call qstrip,$(TERMKEYBOARD_REPO_URL))

define TERMKEYBOARD_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define TERMKEYBOARD_INSTALL_TARGET_CMDS
	PREFIX=$(TARGET_DIR) $(MAKE) -C $(@D) install 
endef

$(eval $(generic-package))
