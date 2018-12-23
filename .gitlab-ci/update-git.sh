#!/usr/bin/env bash

set -e -o pipefail

function update() {
	# Try ff first
	git -C gluon fetch --all && git -C gluon checkout "$GLUON_BRANCH" && git -C gluon pull --ff-only || {
		# Kill it with fire
		echo "Fast-Forward failed, killing it with fire"
		rm -rf gluon
		git clone "$GLUON_GIT" -b "$GLUON_BRANCH" gluon
	}
}

(
	if ! [[ -e gluon ]]; then
		echo "gluon dir nonexistent, updating"
		update
		exit 0
	fi

	REMOTE_REFS="$(git ls-remote -qht "$GLUON_GIT" | grep "$GLUON_BRANCH" | cut -f1)"

	set +e
	LOCAL_REF=$(git -C gluon rev-parse HEAD)
	GIT_EXIT=$?
	set -e

	if [[ $GIT_EXIT -ne 0 ]]; then
		echo "Local repo damaged, forcing update"
		update
		exit 0
	fi

	# There can be multiple objects describing the same state, we need to check them all
	for ref in $REMOTE_REFS; do
		echo "Checking $ref == $LOCAL_REF"
		if [[ "$ref" == "$LOCAL_REF" ]]; then
			echo "Local repo is up to date"
			exit 0
		fi
	done

	echo "Local state does not reflect latest remote state, updating"
	update
)
