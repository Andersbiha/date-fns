#!/bin/bash

if [ "$1" == "" ]
then
  echo 'Version number must be passed as an argument'
  exit 1
fi

echo $1 > VERSION

yarn run sync-versions
yarn run generate-index
yarn run build-umd
yarn run build-docs

git add .
git commit -m "Prepare release v$1"
git tag -a v$1 -m "Release v$1"
git push
git push --tags

yarn run release-npm
