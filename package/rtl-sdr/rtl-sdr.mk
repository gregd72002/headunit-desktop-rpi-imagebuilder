#############################################################
#
# rtl-sdr 
#
#############################################################

RTL_SDR_VERSION = f68bb2fa772ad94f58c59babd78353667570630b
RTL_SDR_REPO_URL = http://cgit.osmocom.org/rtl-sdr
RTL_SDR_SITE_METHOD = git
RTL_SDR_SITE = $(call qstrip,$(RTL_SDR_REPO_URL))
RTL_SDR_DEPENDENCIES = libusb
RTL_SDR_INSTALL_STAGING = YES

$(eval $(cmake-package))
#$(eval $(autotools-package))

