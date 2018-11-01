#!/usr/bin/env bash

set -e -o pipefail
shopt -s nullglob

unset REVERT

err() {
	( >&2 echo $@ )
}

usage() {
	err "${0} [ -r] <patchdir> <target>"
	exit 1
}

while getopts "r" opt; do
	case $opt in
		r) REVERT=1;;
		*) usage;;
	esac
done

shift $((OPTIND - 1))

PATCHDIR="$1"
TARGET="$2"

[ -n "$PATCHDIR" ] && [ -d "$PATCHDIR" ] || {
	err "Patchdir '${PATCHDIR}' is not a directory"
	usage
}

[ -n "$TARGET" ] && [ -e "$TARGET" ] || {
	err "Target '${TARGET}' does not exist"
	usage
}

for file in "$PATCHDIR"/*.patch; do
	if [ -z "$REVERT" ]; then
		patch -d "$TARGET" -p1 < "$file"
	else
		patch -d "$TARGET" -p1 -R < "$file"
	fi
done
