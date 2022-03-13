#!/bin/bash
# set -e
# set -x

if [ $# -eq 0 ]; then
	echo "$0 <dir>"
	exit 1
fi

DIR="$1"
REGEX='^gluon-\w+-(\d+(?:\.\d+)+)(?:~exp\d+)?-([\.\w\d-+]+)\.\w+(?:\.\w+)*$'

for i in $(ls "$DIR" | grep -v manifest); do
	IMAGE=$(basename "$i")
	echo "$IMAGE" | grep -P "$REGEX"

	if [ $? != 0 ]; then
		echo "image has invalid name: $IMAGE"
	fi
done
