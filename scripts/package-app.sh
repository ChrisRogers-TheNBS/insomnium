#!/usr/bin/env bash

cd $(dirname $0)/..

docker run --rm -i \
 --env ELECTRON_CACHE="/root/.cache/electron" \
 --env ELECTRON_BUILDER_CACHE="/root/.cache/electron-builder" \
 --env NODE_OPTIONS="--max-old-space-size=6144" \
 -v ${PWD}:/project \
 -v ${PWD##*/}-node-modules:/project/node_modules \
 -v ~/.cache/electron:/root/.cache/electron \
 -v ~/.cache/electron-builder:/root/.cache/electron-builder \
 electronuserland/builder:wine-mono <<EOF
cd /project

npm ci

npm run build

npm run package --workspace=packages/insomnia -- --windows --linux
EOF
