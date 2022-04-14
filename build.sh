#!/usr/bin/env bash
#
# Author: Paulo Jeronimo <paulojeronim@gmail.com>
set -eou pipefail

WSL2=${WSL2:-false}
WINDOWS_DIR=${WINDOWS_DIR:-/mnt/c/tmp/ethereum-pet-shop-tutorial}

cd "$(dirname "$0")"

# https://gist.github.com/paulojeronimo/95977442a96c0c6571064d10c997d3f2
docker-asciidoctor-builder

rsync -a \
	functions.sh \
	pet-shop.sh \
	gc.sh \
	build/

! $WSL2 || {
	mkdir -p "$WINDOWS_DIR"
	rsync -a build/ "$WINDOWS_DIR"/
}

if [ $# = 1 ]
then
	case "$1" in
		gh-pages) docker-asciidoctor-builder $1;;
	esac
fi
