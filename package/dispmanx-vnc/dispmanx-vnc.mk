#############################################################
#
# dispmanx-vnc 
#
#############################################################

DISPMANX_VNC_VERSION = 6ae6d3e
DISPMANX_VNC_SITE_METHOD = git
DISPMANX_VNC_REPO_URL = https://github.com/hanzelpeter/dispmanx_vnc
DISPMANX_VNC_GIT_SUBMODULES = y
DISPMANX_VNC_SITE = $(call qstrip,$(DISPMANX_VNC_REPO_URL))

DISPMANX_VNC_DEPENDENCIES = libvncserver

define DISPMANX_VNC_BUILD_CMDS
	PREFIX=$(STAGING_DIR) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define DISPMANX_VNC_INSTALL_TARGET_CMDS
	PREFIX=$(TARGET_DIR) $(MAKE) -C $(@D) install 
endef

$(eval $(generic-package))
