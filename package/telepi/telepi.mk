#############################################################
#
# telepi 
#
#############################################################

TELEPI_VERSION = 8a2a15d
TELEPI_SITE_METHOD = git
TELEPI_REPO_URL = https://github.com/DougGore/telepi 
TELEPI_GIT_SUBMODULES = y
TELEPI_SITE = $(call qstrip,$(TELEPI_REPO_URL))
TELEPI_AUTORECONF = YES

TELEPI_DEPENDENCIES =

$(eval $(autotools-package))
