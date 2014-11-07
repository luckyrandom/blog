#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

if [ -n "$(git status --porcelain)" ]
then
    echo 'Please commit your change first!!!'
    exit 1
fi

SRC_COMMIT_ID=$(git rev-parse HEAD)

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
wintersmith build

( cd build
  git add --all * ## The --all option is need to track removals
  git commit -m "deploy from commit ${SRC_COMMIT_ID}"
  git push
  )

git push
