# site.mk for Freifunk Nord

# Always call `make` from the command line with the desired release version!
# otherwise this is generated:
#DEFAULT_GLUON_RELEASE := 2018.2.1
DEFAULT_GLUON_RELEASE := 2019.1~exp$(shell date '+%y%m%d')

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0
GLUON_DEPRECATED ?=  full
GLUON_BRANCH ?= stable
export GLUON_BRANCH

GLUON_TARGET ?= ar71xx-generic
export GLUON_TARGET

# Region code required for some images; supported values: us eu
GLUON_REGION ?= eu

# enable generation of images for ath10k devices with 802.11s mode
GLUON_WLAN_MESH ?= 11s

GLUON_LANGS ?= en de

# for feature packs see https://github.com/freifunk-gluon/gluon/blob/v2018.2.x/package/features
GLUON_FEATURES := \
	config-mode-geo-location-osm \
	web-private-wifi \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	mesh-batman-adv-15 \
	mesh-vpn-fastd \
	radv-filterd \
	respondd \
	web-mesh-vpn-fastd \
	status-page \
	web-advanced \
	web-wizard \
	autoupdater

GLUON_SITE_PACKAGES := \
	respondd-module-airtime \
	iwinfo \
	iptables \
	haveged

# from sargon:
GLUON_SITE_PACKAGES += \
	roamguide
#	ddhcpd

# from https://github.com/Freifunk-Nord/eulenfunk-packages
GLUON_SITE_PACKAGES += \
	gluon-quickfix

# from https://github.com/Freifunk-Nord/gluon-ssid-changer:
GLUON_SITE_PACKAGES += \
	gluon-ssid-changer

# from ffki-packages:
GLUON_SITE_PACKAGES += \
	gluon-config-mode-ppa \
#	gluon-config-mode-contact-info-anonymous-hint


# from T-X alt-esc package:
#GLUON_SITE_PACKAGES += \
#	gluon-alt-esc-client \
#	gluon-alt-esc-provider

# from ffm-packages
GLUON_SITE_PACKAGES += \
	ffffm-button-bind

#	some models and targets have to be excluded:
ifeq ($(GLUON_TARGET),ar71xx-tiny)
	GLUON_tp-link-tl-wr841n-nd-v7_SITE_PACKAGES = -ffffm-button-bind
endif
# a5-v11 gets too large
ifeq ($(GLUON_TARGET),ramips-rt305x)
	GLUON_a5-v11_SITE_PACKAGES += \
	 -ffffm-button-bind \
	 -gluon-config-mode-ppa \
	 -config-mode-geo-location-osm \
	 -status-page
endif

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

# extra packages for fat clients
FAT_PACKAGES := \
	tcpdump \
	gre \
	wireguard

#zram for tiny devices
ifeq ($(GLUON_TARGET),ar71xx-tiny)
GLUON_SITE_PACKAGES += zram-swap
endif

# add addition network drivers and usb stuff only to targets where disk space does not matter
ifeq ($(GLUON_TARGET),$(filter $(GLUON_TARGET),x86-generic x86-64)) 
	# support the USB stack on x86 devices
	# and add a few common USB NICs
	GLUON_SITE_PACKAGES += \
		$(USB_PACKAGES_STORAGE) \
		$(USB_PACKAGES_HID) \
		$(USB_PACKAGES_TETHERING) \
		$(USB_PACKAGES_3G) \
		$(USB_PACKAGES_GPS) \
		$(USB_X86_GENERIC_NETWORK_MODULES) \
		$(FAT_PACKAGES)
endif

# use the target names of https://github.com/freifunk-gluon/gluon/blob/master/targets/ar71xx-generic#L163
ifeq ($(GLUON_TARGET),ar71xx-generic)
	GLUON_tp-link-tl-wr842n-nd-v1_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wr842n-nd-v2_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wr842n-nd-v3_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wr1043n-nd-v2_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wr1043n-nd-v3_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-tl-wr1043n-nd-v4_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
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
	GLUON_buffalo-wzr-hp-g300nh_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_tp-link-archer-c7-v2_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
	GLUON_gl-ar300m_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
endif

ifeq ($(GLUON_TARGET),mpc85xx-generic)
	GLUON_tp-link-tl-wdr4900-v1_SITE_PACKAGES := $(USB_PACKAGES_STORAGE)
endif
