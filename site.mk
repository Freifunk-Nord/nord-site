GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-14 \
	gluon-alfred \
	gluon-respondd \
	gluon-autoupdater \
	gluon-setup-mode \
	gluon-config-mode-core \
	gluon-config-mode-autoupdater \
	gluon-config-mode-hostname \
	gluon-config-mode-mesh-vpn \
	gluon-config-mode-reboot-ffhh \
	gluon-ebtables-filter-multicast \
	gluon-ebtables-filter-ra-dhcp \
	gluon-luci-admin \
	gluon-luci-autoupdater \
	gluon-luci-portconfig \
	gluon-luci-private-wifi \
	gluon-luci-wifi-config \
	gluon-next-node \
	gluon-mesh-vpn-fastd \
	gluon-radvd \
	gluon-status-page \
	iwinfo \
	fastd-traffic-status \
	iptables \
	haveged


# Always call `make` from the command line with the desired release version!
# otherwise this is generated:
DEFAULT_GLUON_RELEASE := 2016.2~exp$(shell date '+%y%m%d%H%M')

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0

GLUON_REGION ?= eu

GLUON_BRANCH ?= experimental
export GLUON_BRANCH

GLUON_TARGET ?= ar71xx-generic
export GLUON_TARGET

GLUON_LANGS ?= en de

# basic support the USB stack
USB_PACKAGES_BASIC := \
	kmod-usb-core \
	kmod-usb2

# support for USB UMTS/3G devices
USB_PACKAGES_3G := \
	kmod-usb-serial \
	kmod-usb-serial-wwan \
	kmod-usb-serial-option \
	chat \
	ppp

# support for USB GPS devices
USB_PACKAGES_GPS := \
	kmod-usb-acm \
	ugps

# support for HID devices (keyboard, mouse, ...)
USB_PACKAGES_HID := \
	kmod-usb-hid \
	kmod-hid-generic

# support for USB tethering
USB_PACKAGES_TETHERING := \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-dm9601-ether

# storage support for USB
USB_PACKAGES_STORAGE := \
	block-mount \
	kmod-fs-ext4 \
	kmod-fs-vfat \
	kmod-usb-storage \
	kmod-usb-storage-extras \
	blkid \
	swap-utils \
	kmod-nls-cp1250 \
	kmod-nls-cp1251 \
	kmod-nls-cp437 \
	kmod-nls-cp775 \
	kmod-nls-cp850 \
	kmod-nls-cp852 \
	kmod-nls-cp866 \
	kmod-nls-iso8859-1 \
	kmod-nls-iso8859-13 \
	kmod-nls-iso8859-15 \
	kmod-nls-iso8859-2 \
	kmod-nls-koi8r \
	kmod-nls-utf8
# from ffki-packages:
USB_PACKAGES += \
	gluon-usb-media \
	gluon-config-mode-usb-media

ifeq ($(GLUON_TARGET),x86-generic)
	# support the USB stack on x86 devices
	# and add a few common USB NICs
	GLUON_SITE_PACKAGES += \
		$(USB_PACKAGES_BASIC) \
		$(USB_PACKAGES_STORAGE) \
		$(USB_PACKAGES_HID) \
		$(USB_PACKAGES_TETHERING) \
		$(USB_PACKAGES_3G) \
		$(USB_PACKAGES_GPS)
endif

ifeq ($(GLUON_TARGET),ar71xx-generic)
	# GLUON_TLWR710_SITE_PACKAGES := $(USB_PACKAGES_BASIC) # some wr710 versions only have 4MB
	GLUON_TLWR1043_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
	GLUON_TLWR842_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
	GLUON_TLWDR4300_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
	GLUON_TLWR2543_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
	GLUON_WRT160NL_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
	GLUON_DIR825B1_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
	GLUON_DIR505A1_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
	GLUON_GLINET_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
	GLUON_WNDR3700_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
	GLUON_WZRHPG450H_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
	GLUON_WZRHPAG300H_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
	GLUON_ARCHERC7_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
endif

ifeq ($(GLUON_TARGET),mpc85xx-generic)
	GLUON_TLWDR4900_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE)
endif
