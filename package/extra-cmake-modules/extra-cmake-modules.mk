################################################################################
#
# extra-cmake-modules
#
################################################################################

EXTRA_CMAKE_MODULES_VERSION = $(BLUEZ_QT_VERSION)
EXTRA_CMAKE_MODULES_REPO_URL = https://github.com/KDE/extra-cmake-modules
EXTRA_CMAKE_MODULES_SITE_METHOD = git
EXTRA_CMAKE_MODULES_GIT_SUBMODULES = yes
EXTRA_CMAKE_MODULES_SITE = $(call qstrip,$(EXTRA_CMAKE_MODULES_REPO_URL))

EXTRA_CMAKE_MODULES_LICENSE = BSD-3-Clause
EXTRA_CMAKE_MODULES_LICENSE_FILE = COPYING-CMAKE-SCRIPTS

EXTRA_CMAKE_MODULES_DEPENDENCIES = host-pkgconf
EXTRA_CMAKE_MODULES_INSTALL_STAGING = YES
EXTRA_CMAKE_MODULES_INSTALL_TARGET = NO

$(eval $(cmake-package))
