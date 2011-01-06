#!/bin/bash
set -e
dest="$1"
pkg=${dest%%.imports}
cabal install $pkg
dir=$(cabal unpack $pkg 2>&1 | grep -oE '[^" ]*\/')
cd $dir
cabal configure
cabal build --ghc-option='-ddump-minimal-imports'
cat *.imports > ../$dest
