#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

if [ -n "$(git status --porcelain)" ]
then
    echo 'Please commit your change first!!!'
    exit 1
fi

SRC_COMMIT_ID=$(git rev-parse HEAD)

source build.sh

( cd build

  ## Set up git to track the gh-pages branch if neesecary
  if [ ! -d ".git" ]; then
     git init
     git remote add origin git@github.com:luckyrandom/blog.git -t gh-pages
     git fetch origin
     git reset --soft origin/gh-pages
  fi

  ## Push all files to the gh-pages branch
  git add --all * ## The --all option is need to track removals
  git commit -m "deploy from commit ${SRC_COMMIT_ID}"
  git push --set-upstream origin gh-pages
  )

git push
