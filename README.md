Firmware Site Config for Freifunk Nord
--------------------------------------

You can always find
the latest gluon documentation at:
https://gluon.readthedocs.org/en/latest/

Gluon Version auf der die Freifunk Nord Firmware basiert:

* 2020.2.3 - Gluon v2020.2.x

# Download der Firmware

* https://nord.freifunk.net/firmware.html

# Firmware selber bauen

1. Vorbereitung:

  1.1 Abhängigkeiten installieren

       sudo apt-get install git subversion build-essential gawk unzip libncurses5-dev zlib1g-dev libssl-dev time

  1.2 Gluon repo clonen

       cd /opt/
       git clone https://github.com/freifunk-gluon/gluon

  1.3 Freifunk Nord Site clonen

    1.3.1 stable

       cd gluon
       git clone -b nord-lede https://github.com/ffnord/nord-site.git site

    1.3.2 experimental

       cd gluon
       git clone -b nord-2020.2.x https://github.com/ffnord/nord-site.git site

2. Firmware bauen

  2.1 Build vorbereiten

    2.1.1 stable

       GLUON_DEPRECATED=1 make update

    2.1.2 experimental

       make update

  2.2 Build durchführen

    2.2.1 stable

       GLUON_DEPRECATED=1 make -j8 GLUON_TARGET=ar71xx-generic ##-j $ZAHL$ = Anzahl der CPU Kerne

    2.2.2 experimental

       make -j8 GLUON_TARGET=ar71xx-generic ##-j $ZAHL$ = Anzahl der CPU Kerne

       ## Mögliche Targets

        - ar71xx-generic
        - ar71xx-mikrotik
        - ar71xx-nand
        - ar71xx-tiny
        - mpc85xx-generic
        - x86-64
        - x86-generic
        - x86-geode

       ## Nur mit 802.11s

        - brcm2708-bcm2708
        - brcm2708-bcm2709
        - ipq806x
        - mvebu
        - ramips-mt7621
        - ramips-mt7628
        - ramips-rt305x
        - sunxi

3. Rebuild

  3.1 Updaten

       cd /opt/gluon/site
       git pull
       cd ..
       git pull
       make update

  3.2 Build Verzeichnis säubern

       make clean GLUON_TARGET=$TARGET

# Development

## Validation and debug

You can validate your changes to this repository by calling the validate_site.sh file with

    tests/validate_site.sh

You can debug lua scripts in modules with

    apt install luarocks
    luarocks install --local luacheck
    tests/validate_site.sh
    ~/.luarocks/bin/luacheck --config "tests/.luacheckrc" /tmp/site-validate/|grep "(E"


## CI config

You can upload upload all artifacts to a server via ssh by setting the following environment variables:
- `DEPLOY_USER`: ssh user
- `DEPLOY_HOST`: ssh server (without trailing `:`)
- `DEPLOY_KEY`: a private ssh key
