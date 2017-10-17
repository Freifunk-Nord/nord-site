GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-15 \
	gluon-core \
	gluon-alfred \
	gluon-autoupdater \
	gluon-setup-mode \
	gluon-config-mode-core \
	gluon-config-mode-autoupdater \
	gluon-config-mode-mesh-vpn \
	gluon-ebtables-filter-multicast \
	gluon-ebtables-filter-ra-dhcp \
	gluon-web-admin \
	gluon-web-autoupdater \
	gluon-web-network \
	gluon-web-private-wifi \
	gluon-web-wifi-config \
	gluon-mesh-vpn-fastd \
	gluon-radvd \
	gluon-status-page \
	iwinfo \
	iptables \
	haveged

# from eulenfunk:
GLUON_SITE_PACKAGES += \
	gluon-quickfix
#
# from sargon:
GLUON_SITE_PACKAGES += \
	roamguide
#
# from ssidchanger-packages:
GLUON_SITE_PACKAGES += \
	gluon-ssid-changer

# from ffki-packages:
GLUON_SITE_PACKAGES += \
	gluon-config-mode-ppa \
	gluon-config-mode-hostname-no-pretty

# from T-X alt-esc package:
GLUON_SITE_PACKAGES += \
	gluon-alt-esc-client \
	gluon-alt-esc-provider
	
# Always call `make` from the command line with the desired release version!
# otherwise this is generated:
#DEFAULT_GLUON_RELEASE := 2017.1.3~exp$(shell date '+%y%m%d%H%M')
DEFAULT_GLUON_RELEASE := 2017.1.3~exp

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0
GLUON_BRANCH ?= stable
export GLUON_BRANCH

GLUON_TARGET ?= ar71xx-generic
export GLUON_TARGET

GLUON_REGION ?= eu
GLUON_ATH10K_MESH ?= 11s

GLUON_LANGS ?= en de

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

USB_X86_GENERIC_NETWORK_MODULES := \
	kmod-usb-ohci-pci \
	kmod-sky2 \
	kmod-atl2 \
	kmod-igb \
	kmod-3c59x \
	kmod-e100 \
	kmod-e1000 \
	kmod-e1000e \
	kmod-natsemi \
	kmod-ne2k-pci \
	kmod-pcnet32 \
	kmod-8139too \
	kmod-r8169 \
	kmod-sis900 \
	kmod-tg3 \
	kmod-via-rhine \
	kmod-via-velocity \
	kmod-forcedeth

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
USB_PACKAGES_STORAGE += \
	gluon-usb-media \
	gluon-config-mode-usb-media

# add addition network drivers and usb stuff only to targes where disk space does not matter
ifeq ($(GLUON_TARGET),x86-generic)
	# support the USB stack on x86 devices
	# and add a few common USB NICs
	GLUON_SITE_PACKAGES += \
		$(USB_PACKAGES_STORAGE) \
		$(USB_PACKAGES_HID) \
		$(USB_PACKAGES_TETHERING) \
		$(USB_PACKAGES_3G) \
		$(USB_PACKAGES_GPS) \
		$(USB_X86_GENERIC_NETWORK_MODULES)
endif

ifeq ($(GLUON_TARGET),ar71xx-generic)
	GLUON_tp-link-tl-wr842n-nd-v1_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wr842n-nd-v2_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wr842n-nd-v3_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wr1043nd-v2_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wr1043nd-v3_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wr1043nd-v4_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wdr4300-v1_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wr2543n-nd-v1_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_linksys-wrt160nl_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_d-link-dir-825-rev-b1_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_d-link-dir-505-rev-a1_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_d-link-dir-505-rev-a2_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_gl-inet-6408a-v1_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_gl-inet-6416a-v1_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_netgear-wndr3700_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_netgear-wndr3700v2_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_netgear-wndr3700v4_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_buffalo-wzr-hp-g450h_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_buffalo-wzr-hp-g300h_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-archer-c7-v2_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
endif

ifeq ($(GLUON_TARGET),mpc85xx-generic)
	GLUON_tp-link-tl-wdr4900-v1_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
endif
