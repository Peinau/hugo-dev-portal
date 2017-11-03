#!/bin/bash

set -e

die () {
    echo "Usage: ./build.sh <release_version> [-r] [-p]"
    exit 1
}

( [ "$#" -le 4 ] && [ "$#" -ge 1 ] ) || die

RELEASE_VERSION=$1
REGISTRY=peinau.azurecr.io
NAME=hugo-doc-generator
IMAGE="${REGISTRY}/${NAME}"
PUBLISH=0
NO_CACHE=""

OPTIND=4
while getopts ":pr" opt; do
  if [ $opt == "p" ]; then
     PUBLISH=1
  fi
  if [ $opt == "r" ]; then
     NO_CACHE=" --no-cache=true"
  fi
done

echo "Building image..."
docker build $NO_CACHE -t $IMAGE:$RELEASE_VERSION .

if [ $PUBLISH -eq 1 ]; then
   echo "Publish images..."
   docker push $IMAGE:$RELEASE_VERSION
fi

echo "Image: $IMAGE:$RELEASE_VERSION"
echo "Done!"
