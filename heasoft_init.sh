#!/bin/bash

export HEADAS=$(ls -d /heasoft/x86_64-*)
#export HEADAS=$HOME/heasoft/x86_64-unknown-linux-gnu-libc2.17/
source $HEADAS/headas-init.sh

plist fdump
