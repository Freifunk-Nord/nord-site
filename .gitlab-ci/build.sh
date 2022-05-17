#!/bin/bash -e
# =====================================================================
# Build script for Freifunk Nord firmware
#
# Source: 
# Contact: 
# Web: 
#
# Credits:
#   - Freifunk Darmstadt for your great support
#   - Freifunk Fulda for the base of the gitlab-ci support
# =====================================================================

# Default make options (override with -m)
MAKEOPTS="-j 4 GLUON_DEPRECATED=upgrade"

# Default is set to use current work directory
SITEDIR="$(pwd)"

# Default build identifier set to snapshot
BUILD="snapshot"

# Specify deployment server and user
DEPLOYMENT_SERVER="116.202.216.125"
DEPLOYMENT_SSH_ARGS=" -p 22555 " # Default 22
DEPLOYMENT_USER="rsync"
DEPLOYMENT_PATH="/opt/firmware/nord"

# Path to signing key
SIGNKEY=""

# Error codes
E_ILLEGAL_ARGS=126

# Help function used in error messages and -h option

usage() {
  echo ""
  echo "Build script for Freifunk-Fulda gluon firmware."
  echo ""
  echo "-a: Autoupdater branch name (e.g. stable)"
  echo "    Default: branch (see -b)"
  echo "-b: Firmware branch name (e.g. main)"
  echo "    Default: current git branch"
  echo "-c: Build command: update | clean | download | build | sign | upload | prepare"
  echo "-d: Enable bash debug output"
  echo "-h: Show this help"
  echo "-m: Setting for make options (optional)"
  echo "    Default: \"${MAKEOPTS}\""
  echo "-n: Build identifier (optional)"
  echo "    Default: \"${BUILD}\""
  echo "-t: Gluon targets architectures to build"
  echo "    Default: \"${TARGETS}\""
  echo "-u: Upload target"
  echo "    Default: branch (see -b)"
  echo "-r: Release number (optional)"
  echo "    Default: fetched from release file"
  echo "-w: Path to site directory"
  echo "    Default: current working directory"
  echo "-s: Path to signing key"
  echo "    Default: empty"
}

# Evaluate arguments for build script.
if [[ "${#}" == 0 ]]; then
  usage
  exit ${E_ILLEGAL_ARGS}
fi

# Evaluate arguments for build script.
while getopts a:b:c:dhm:n:t:u:w:s: flag; do
  case ${flag} in
    a)
        AU_BRANCH="${OPTARG}"
        ;;
    b)
        BRANCH="${OPTARG}"
        ;;
    c)
      case "${OPTARG}" in
        update)
          COMMAND="${OPTARG}"
          ;;
        clean)
          COMMAND="${OPTARG}"
          ;;
        download)
          COMMAND="${OPTARG}"
          ;;
        build)
          COMMAND="${OPTARG}"
          ;;
        sign)
          COMMAND="${OPTARG}"
          ;;
        upload)
          COMMAND="${OPTARG}"
          ;;
        prepare)
          COMMAND="${OPTARG}"
          ;;
        *)
          echo "Error: Invalid build command set."
          usage
          exit ${E_ILLEGAL_ARGS}
          ;;
      esac
      ;;
    d)
      set -x
      ;;
    h)
      usage
      exit
      ;;
    m)
      MAKEOPTS="${OPTARG}"
      ;;
    n)
      BUILD="${OPTARG}"
      ;;
    t)
      TARGETS="${OPTARG}"
      ;;
    u)
      UPLOAD_TARGET="${OPTARG}"
      ;;
    r)
      RELEASE="${OPTARG}"
      ;;
    w)
      # Use the root project as site-config for make commands below
      SITEDIR="${OPTARG}"
      ;;
    s)
      SIGNKEY="${OPTARG}"
      ;;
    *)
      usage
      exit ${E_ILLEGAL_ARGS}
      ;;
  esac
done

# Strip of all remaining arguments
shift $((OPTIND - 1));

# Check if there are remaining arguments
if [[ "${#}" > 0 ]]; then
  echo "Error: Too many arguments: ${*}"
  usage
  exit ${E_ILLEGAL_ARGS}
fi

# Set branch name
if [[ -z "${BRANCH}" ]]; then
  BRANCH=$(git symbolic-ref -q HEAD)
  BRANCH=${BRANCH##refs/heads/}
  BRANCH=${BRANCH:-HEAD}
fi

if [[ -z "$AU_BRANCH" ]]; then
  AU_BRANCH="$BRANCH"
fi

# Default to build branch specific targets if parameter -t is not set 
if [[ -z ${TARGETS+x} ]] ; then
  # Base targets we build
  TARGETS="ar71xx-generic ar71xx-tiny ar71xx-nand x86-64"
  case "${AU_BRANCH}" in
    *)
      # all targets
      TARGETS+=" ath79-generic"
      TARGETS+=" brcm2708-bcm2708"
      TARGETS+=" brcm2708-bcm2709"
      TARGETS+=" ipq40xx-generic"
      TARGETS+=" ipq806x-generic"
      TARGETS+=" lantiq-xrx200"
      TARGETS+=" lantiq-xway"
      TARGETS+=" mpc85xx-generic"
      TARGETS+=" mpc85xx-p1020"
      TARGETS+=" ramips-mt7620"
      TARGETS+=" ramips-mt7621"
      TARGETS+=" ramips-mt76x8" # Netgear R6120
      TARGETS+=" ramips-rt305x"
      TARGETS+=" sunxi-cortexa7"
      TARGETS+=" x86-generic"
      TARGETS+=" x86-geode"
      TARGETS+=" x86-legacy"
      TARGETS+=" ar71xx-mikrotik"
      TARGETS+=" brcm2708-bcm2710" # raspi
      TARGETS+=" mvebu-cortexa9" # linksys_wrt1200ac
    ;;
  esac
fi

# Normalize the branch name
BRANCH="${BRANCH#origin/}" # Use the current git branch as autoupdate branch
BRANCH="${BRANCH//\//-}"   # Replace all slashes with dashes

if [[ -z "$UPLOAD_TARGET" ]]; then
  UPLOAD_TARGET="$BRANCH"
fi

# Set command
if [[ -z "${COMMAND}" ]]; then
  echo "Error: Build command missing."
  usage
  exit ${E_ILLEGAL_ARGS}
fi

# Set release number
if [[ -z "${RELEASE}" ]]; then
  RELEASE=$(sed -e "s/BUILD/$BUILD/" "${SITEDIR}/release")
  case "${BRANCH}" in
    nightly)
      RELEASE="${RELEASE}~ngly"
      ;;
    next)
      RELEASE="${RELEASE}~next"
      ;;
    *)
      # Do nothing
      ;;
  esac
fi

# Get the GIT commit description
COMMIT="$(git describe --always --dirty)"

# Number of days that may pass between releasing an updating
if [[ -z ${PRIORITY+x} ]] ; then
  case "${BRANCH}" in
    nightly)
      PRIORITY=0
      ;;
    *)
      PRIORITY=1
      ;;
  esac
fi

update() {
  echo "--- Update Gluon Dependencies"
  make ${MAKEOPTS} \
       GLUON_SITEDIR="${SITEDIR}" \
       GLUON_OUTPUTDIR="${SITEDIR}/output" \
       GLUON_RELEASE="${RELEASE}" \
       GLUON_BRANCH="${AU_BRANCH}" \
       GLUON_PRIORITY="${PRIORITY}" \
       update
}

clean() {
  for TARGET in ${TARGETS}; do
    echo "--- Clean Gluon Build Artifacts for target: ${TARGET}"
    make ${MAKEOPTS} \
         GLUON_SITEDIR="${SITEDIR}" \
         GLUON_OUTPUTDIR="${SITEDIR}/output" \
         GLUON_RELEASE="${RELEASE}" \
         GLUON_BRANCH="${AU_BRANCH}" \
         GLUON_PRIORITY="${PRIORITY}" \
         GLUON_TARGET="${TARGET}" \
         clean
  done
}

download() {
  for TARGET in ${TARGETS}; do
    echo "--- Download Gluon Dependencies for target: ${TARGET}"
    make ${MAKEOPTS} \
         GLUON_SITEDIR="${SITEDIR}" \
         GLUON_OUTPUTDIR="${SITEDIR}/output" \
         GLUON_RELEASE="${RELEASE}" \
         GLUON_BRANCH="${AU_BRANCH}" \
         GLUON_PRIORITY="${PRIORITY}" \
         GLUON_TARGET="${TARGET}" \
         download
  done
}

build() {
  for TARGET in ${TARGETS}; do
    echo "--- Build Gluon Images for target: ${TARGET}"
    case "${AU_BRANCH}" in
      stable)
        make ${MAKEOPTS} \
             GLUON_SITEDIR="${SITEDIR}" \
             GLUON_OUTPUTDIR="${SITEDIR}/output" \
             GLUON_RELEASE="${RELEASE}" \
             GLUON_BRANCH="${AU_BRANCH}" \
             GLUON_PRIORITY="${PRIORITY}" \
             GLUON_TARGET="${TARGET}"
        ;;

      *)
        make ${MAKEOPTS} \
             GLUON_SITEDIR="${SITEDIR}" \
             GLUON_OUTPUTDIR="${SITEDIR}/output" \
             GLUON_RELEASE="${RELEASE}" \
             GLUON_BRANCH="${AU_BRANCH}" \
             GLUON_TARGET="${TARGET}"
      ;;
    esac
  done

  echo "--- Build Gluon Manifest"
  make ${MAKEOPTS} \
       GLUON_SITEDIR="${SITEDIR}" \
       GLUON_OUTPUTDIR="${SITEDIR}/output" \
       GLUON_RELEASE="${RELEASE}" \
       GLUON_BRANCH="${AU_BRANCH}" \
       GLUON_PRIORITY="${PRIORITY}" \
       manifest

  cp "${SITEDIR}/output/images/sysupgrade/${AU_BRANCH}.manifest" \
     "${SITEDIR}/output/images/sysupgrade/${AU_BRANCH}.manifest.clean"

  echo "--- Write Build file"
  cat > "${SITEDIR}/output/images/build" <<EOF
DATE=$(date '+%Y-%m-%d %H:%M:%S')
VERSION=$(cat "${SITEDIR}/release")
RELEASE=${RELEASE}
BUILD=${BUILD}
BRANCH=${AU_BRANCH}
COMMIT=${COMMIT}
HOST=$(uname -n)
EOF
}

sign() {
  echo "--- Sign Gluon Firmware Build"

  # Add the signature to the local manifest
  contrib/sign.sh \
      "${SIGNKEY}" \
      "${SITEDIR}/output/images/sysupgrade/${AU_BRANCH}.manifest"
}

upload() {
  set -x
  echo "--- Upload Gluon Firmware Images and Manifest"

  # Build the ssh command to use
  SSH="ssh"
  SSH="${SSH} -o stricthostkeychecking=no -v"

  # Determine upload target prefix
  TARGET="${UPLOAD_TARGET}"

  # Create the target directory on server
  ${SSH} \
      ${DEPLOYMENT_USER}@${DEPLOYMENT_SERVER} \
      ${DEPLOYMENT_SSH_ARGS} \
      -- \
      mkdir \
          --parents \
          --verbose \
          "${DEPLOYMENT_PATH}/${TARGET}/${RELEASE}"

  # Add site metadata
  tar -czf "${SITEDIR}/output/images/site.tgz" --exclude='gluon' --exclude='output' "${SITEDIR}"

  # Compress images (Saves around 40% space, relevant because of shitty VDSL 50 upload speeds)
  echo "Compressing images..."
  tar -cJf "${SITEDIR}/output/images.txz" -C "${SITEDIR}/output/images/" factory sysupgrade other

  # Copy images to server
  echo "Uploading images..."
  rsync \
      --verbose \
      --progress \
      --chmod=ugo=rwX \
      --rsh="${SSH} ${DEPLOYMENT_SSH_ARGS}" \
      "${SITEDIR}/output/images.txz" \
      "${DEPLOYMENT_USER}@${DEPLOYMENT_SERVER}:${DEPLOYMENT_PATH}/${TARGET}/${RELEASE}"

  echo "Uncompressing images..."
  ${SSH} \
      ${DEPLOYMENT_USER}@${DEPLOYMENT_SERVER} \
      ${DEPLOYMENT_SSH_ARGS} \
      -- \
     tar -xJf "${DEPLOYMENT_PATH}/${TARGET}/${RELEASE}/images.txz" -C "${DEPLOYMENT_PATH}/${TARGET}/${RELEASE}/"

  ${SSH} \
      ${DEPLOYMENT_USER}@${DEPLOYMENT_SERVER} \
      ${DEPLOYMENT_SSH_ARGS} \
      -- \
      ln -sf \
          "${DEPLOYMENT_PATH}/${TARGET}/${RELEASE}/sysupgrade" \
          "${DEPLOYMENT_PATH}/${TARGET}/"
  ${SSH} \
      ${DEPLOYMENT_USER}@${DEPLOYMENT_SERVER} \
      ${DEPLOYMENT_SSH_ARGS} \
      -- \
      ln -sf \
          "${DEPLOYMENT_PATH}/${TARGET}/${RELEASE}/factory" \
          "${DEPLOYMENT_PATH}/${TARGET}/"
  ${SSH} \
      ${DEPLOYMENT_USER}@${DEPLOYMENT_SERVER} \
      ${DEPLOYMENT_SSH_ARGS} \
      -- \
      ln -sf \
          "${DEPLOYMENT_PATH}/${TARGET}/${RELEASE}/other" \
          "${DEPLOYMENT_PATH}/${TARGET}/"
}

prepare() {
  echo "--- Prepare directory for upload"

  # Determine upload target prefix
  TARGET="${UPLOAD_TARGET}"

  # Create the target directory on server
  mkdir \
    --parents \
    --verbose \
    "${SITEDIR}/output/firmware/${TARGET}"

  # Copy images to directory
  mv \
    --verbose \
    "${SITEDIR}/output/images" \
    "${SITEDIR}/output/firmware/${TARGET}/${RELEASE}"

  # Link latest upload in target to 'current'
  cd "${SITEDIR}/output"
  ln \
      --symbolic \
      --force \
      --no-target-directory \
      "${RELEASE}" \
      "firmware/${TARGET}/current"
}

(
  # Change working directory to gluon tree
  cd "${SITEDIR}/gluon"

  # Execute the selected command
  ${COMMAND}
)
