#!/usr/bin/env bash
#
# Author: Paulo Jeronimo <paulojeronim@gmail.com>

cd "$(dirname "${BASH_SOURCE[0]}")"

echo "BASE_DIR is \"$PWD\""

load() {
  echo "Loading \"BASE_DIR/$1\" to the current shell"
  source "$1"
}

load ./pet-shop.sh
load ./gc.sh

# vim: ts=2 sw=2 et
