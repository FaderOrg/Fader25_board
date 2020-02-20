#!/usr/bin/env bash

help_f()
{
cat << EOF
 INIT_SUBMODULES Release 1.1 (06.09.2018)
 Written by Marko Pikkis Kosunen
 -n
 SYNOPSIS
   init_submodules.sh
 DESCRIPTION
   Initializes the submoduels with selective recursion
 -n
 OPTIONS

   -h
       Show this help.
EOF
}
INITGEN="1"
while getopts h opt
do
  case "$opt" in
    h) help_f; exit 0;;
    \?) help_f; exit 0;;
  esac
  shift
done

DIR="$( cd "$( dirname $0 )" && pwd )"
cd $DIR
git submodule sync
for module in \
    ./fader25_pcb; do
    git submodule update --init $module
    cd ${module}
    if [ -f ./init_submodules.sh ]; then
        ./init_submodules.sh
    fi
    cd ${DIR}
done

exit 0

