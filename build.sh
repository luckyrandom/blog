#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

(cd contents/articles/;
 for dir in $(ls); do
     if [ -d $dir ]; then
         (cd $dir;
          if [ -e Makefile ]; then
              make
          fi)
     fi
 done)

rm -rf build/*
node_modules/wintersmith/bin/wintersmith build

