#!/usr/bin/env bash
#
# Author: Paulo Jeronimo <paulojeronim@gmail.com>

cd "$(dirname "${BASH_SOURCE[0]}")"
export ETHEREUM_PET_SHOP_TUTORIAL_DIR=$PWD
echo "ETHEREUM_PET_SHOP_TUTORIAL_DIR is \"$PWD\""

profile=~/.bashrc
case "$(uname)" in
  Darwin) profile=~/.bash_profile;;
esac

if [ $# = 1 ]
then
  case "$1" in
    install) echo "source \"$ETHEREUM_PET_SHOP_TUTORIAL_DIR/functions.sh\"" >> $profile
  esac
fi

load() {
  echo "Loading \"ETHEREUM_PET_SHOP_TUTORIAL_DIR/$1\" to the current shell"
  source "$1"
}

load ./pet-shop.sh
load ./gc.sh

cd "$OLDPWD"

# vim: ts=2 sw=2 et
