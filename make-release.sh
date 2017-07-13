#!/bin/bash

## This script will compile Gluon for all architectures, create the
## manifest and sign it. For that, you must have cloned gluon and have a
## valid site config. Additionally, the signing key must be present in
## ../../ecdsa-key-secret or defined as first argument.
## The second argument defines the branch (stable, beta, experimental).
## The third argument defines the version.
## Call from site directory with the version and branch variables
## properly configured in this script.

# report the usage of uninitialized variables, etc
set -u
# stop on first error (not working in if clauses)
set -e

# if version is unset, will use the default experimental version from site.mk
VERSION=${3:-"2017.1.1~lede$(date '+%y%m%d%H%M')"}
# branch must be set to either experimental, beta or stable
BRANCH=${2:-"stable"}
# must point to valid ecdsa signing key created by ecdsakeygen, relative to Gluon base directory
SIGNING_KEY=${1:-"../ecdsa-key-secret"}

# BROKEN must be set to "" or "BROKEN=1"
BROKEN="BROKEN=1"

# set num cores +1
CORES=$(($(lscpu|grep -e '^CPU(s):'|xargs|cut -d" " -f2)+1))
CORES="-j$CORES"

# set this to "0" if you don't want to use make clean before make
MAKE_CLEAN="1"

# set this to "V=s" to get more output
VERBOSE=""

#ONLY_TARGET must be set to "" or i.e. "ar71xx-generic" 
#ONLY_TARGET=""
ONLY_TARGET="ar71xx-tiny ar71xx-generic"
#to build only one device set DEVICES list (only if $ONLY_TARGET!="")
DEVICES=""
#DEVICES="DEVICES=tp-link-tl-wr842n-nd-v3"

cd ../
if [ ! -d "site" ]; then
  echo "This script must be called from within the site directory"
  exit
fi

if [ "$(whoami)" == "root" ]; then
  echo "Make may not be run as root"
  return
fi

if [ -d ../openwrt/ ]; then
  echo openwrt was checked out, this will break, if you build master now
fi

echo "############## starting build process #################" >> build.log
date >> build.log
echo "if you want to start over empty the folder ../output/"
echo "see debug output with"
echo "tail -F ../build.log &"
sleep 3

#rm -r output

#  ramips-mt7621:  BROKEN: No AP+IBSS support, 11s has high packet loss
#  ramips-rt305x:  BROKEN: No AP+IBSS support

WRT1200AC="mvebu" # Linksys WRT1200AC BROKEN: No AP+IBSS+mesh support

ONLY_11S="ramips-rt305x ramips-mt7621"    # BROKEN only

ONLY_LEDE="ar71xx-tiny" # Support for for 841 on lede, needs less packages, so the 4MB will suffice!
ONLY_LEDE+=" x86-geode ipq806x ramips-mt7628"
NOT_LEDE="x86-kvm_guest" # The x86-kvm_guest target has been dropped from LEDE; x86-64 should be used

BANANAPI="sunxi"                          # BROKEN: Untested, no sysupgrade support
MICROTIK="ar71xx-mikrotik"                # BROKEN: no sysupgrade support

RASPBPI="brcm2708-bcm2708 brcm2708-bcm2709"
X86="x86-64 x86-generic x86-xen_domu"
WDR4900="mpc85xx-generic"

TARGETS="ar71xx-generic $ONLY_LEDE ar71xx-nand $WDR4900 $RASPBPI $X86"
if [ "$BROKEN" != "" ]; then
  TARGETS+=" $BANANAPI $MICROTIK $WRT1200AC"
fi

if [ "$ONLY_TARGET" != "" ]; then
  TARGETS="$ONLY_TARGET"
fi

for TARGET in $TARGETS; do
  date >> build.log
  echo "Starting work on target $TARGET $DEVICES" | tee -a build.log
  OPTIONS="GLUON_TARGET=$TARGET $BROKEN $CORES GLUON_BRANCH=$BRANCH GLUON_RELEASE=$VERSION"
  echo -e "\n===========\n\n\n\n\nmake $OPTIONS update" >> build.log
  time make $OPTIONS update >> build.log 2>&1
  if [ $MAKE_CLEAN = 1 ]; then
    echo -e "\n===========\n\n\n\n\nmake $OPTIONS clean" >> build.log
    time make $OPTIONS clean >> build.log 2>&1
  fi
  echo -e "\n===========\n\n\n\n\nmake $OPTIONS $DEVICES $VERBOSE" >> build.log
  time make $OPTIONS $DEVICES $VERBOSE >> build.log 2>&1
  echo -e "\n\n\n============================================================\n\n" >> build.log
done
date >> build.log

echo "Compilation complete, creating manifest(s)" | tee -a build.log
set +e
MANIFEST_OPTINS="GLUON_RELEASE=$VERSION $BROKEN $CORES"
if [[ true ]]; then
  B="experimental"
  echo -e "make $MANIFEST_OPTINS GLUON_BRANCH=$B manifest" >> build.log
  make $MANIFEST_OPTINS GLUON_BRANCH=$B manifest >> build.log 2>&1
  echo -e "\n\n\n============================================================\n\n" >> build.log
fi

if [[ "$BRANCH" == "beta" ]] || [[ "$BRANCH" == "stable" ]]; then
  B="beta"
  echo -e "make $MANIFEST_OPTINS GLUON_BRANCH=$B manifest" >> build.log
  make $MANIFEST_OPTINS GLUON_BRANCH=$B manifest >> build.log 2>&1
  echo -e "\n\n\n============================================================\n\n" >> build.log
fi

if [[ "$BRANCH" == "stable" ]]; then
  B="stable"
  echo -e "make $MANIFEST_OPTINS GLUON_BRANCH=$B manifest" >> build.log
  make $MANIFEST_OPTINS GLUON_BRANCH=$B manifest >> build.log 2>&1
  echo -e "\n\n\n============================================================\n\n" >> build.log
fi

echo "Manifest creation complete, signing manifest"

echo -e "contrib/sign.sh $SIGNING_KEY output/images/sysupgrade/experimental.manifest" >> build.log
contrib/sign.sh $SIGNING_KEY output/images/sysupgrade/experimental.manifest >> build.log 2>&1

if [[ "$BRANCH" == "beta" ]] || [[ "$BRANCH" == "stable" ]]; then
  echo -e "contrib/sign.sh $SIGNING_KEY output/images/sysupgrade/beta.manifest" >> build.log
  contrib/sign.sh $SIGNING_KEY output/images/sysupgrade/beta.manifest >> build.log 2>&1
fi

if [[ "$BRANCH" == "stable" ]]; then
  echo -e "contrib/sign.sh $SIGNING_KEY output/images/sysupgrade/stable.manifest" >> build.log
  contrib/sign.sh $SIGNING_KEY output/images/sysupgrade/stable.manifest >> build.log 2>&1
fi
cd site
date >> ../build.log
mv -v ../output/images "../output/$VERSION"
echo "Done :)"
