#!/usr/bin/env bash
#
# Author: Paulo Jeronimo <paulojeronim@gmail.com>

PET_SHOP_DIFFTOOL=false

pet-shop-init() {
  cp ../gc.sh .
  git init

  cat > .gitignore <<'EOF'
/README.html
/node_modules
/gc.log
EOF

  cat > README.adoc <<EOF
= Ethereum Pet Shop
:numbered:

Created by following Paulo Jeronimo's https://paulojeronimo.com/ethereum-pet-shop-tutorial[ethereum-pet-shop-tutorial].

== Environment and software versions

----
$ uname -a
`uname -a`

$ node -v
`node -v`

$ npm -v
`npm -v`

$ truffle version
`truffle version`
----

== Steps to run and test

=== Install and run Ganache and Truffe

----
$ # Install Truffle and Ganache:
$ npm install -g truffle
$ npm install -g ganache

$ # Load ganache helper functions:
$ source ./gc.sh

$ # Start ganache:
$ gc start

$ # Compile, install and test the contracts:
$ truffle compile
$ truffle migrate
$ truffle test
----

=== Configure Metamask

Import the secret recovery phrase returned by the following command:

----
$ gc seedphrase
----

Add a network and configure it with the following parameters:

* Network Name: Custom RPC
* New RPC URL: http://localhost:7545
* Chain ID: 1337
* Currency Symbol: ETH

=== Run the web app and access it

----
$ npm install
$ npm run dev
----

Open http://localhost:3000
EOF

  git add -A
  git commit -m 'Initial commit'
}

pet-shop-add() { cat - > "$1"; git add "$1"; git commit -m "File $1 added"; }

pet-shop-difftool() { PET_SHOP_DIFFTOOL=${1:-true}; }

pet-shop-apply() {
  git apply "$1"
  $PET_SHOP_DIFFTOOL && git difftool
  git commit -am "$2"
}

pet-shop() {
  local f="pet-shop-$1"
  shift
  type "$f" &> /dev/null && $f "$@"
}

# vim: ts=2 sw=2 et
