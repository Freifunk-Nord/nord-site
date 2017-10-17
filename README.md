# Validation

You can validate your changes to this repository by calling the validate_site.sh file with

    tests/validate_site.sh

# Dokumentation

https://gluon.readthedocs.org/en/latest/

Gluon Version auf der die Freifunk Nord Firmware basiert:

* 2017.1.3 - Gluon LEDE 2017.1.3

# Download der Firmware

* https://nord.freifunk.net/firmware.html

# Firmware selber bauen

1. Vorbereitung:

  1.1 Abhängigkeiten installieren

       sudo apt-get install git subversion build-essential gawk unzip libncurses5-dev zlib1g-dev libssl-de

  1.2 Gluon repo clonen

       cd /opt/
       git clone https://github.com/freifunk-gluon/gluon

  1.3 Freifunk Nord Site clonen

       cd gluon
       git clone -b nord-lede https://github.com/ffnord/nord-site.git site

2. Firmware bauen

  2.1 Build vorbereiten

       make update

  2.2 Build durchführen

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
