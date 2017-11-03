#!/bin/sh

#!/bin/bash

set -e

die () {
    echo "Usage: ./build.sh <release_version> [-r] [-p]"
    exit 1
}

( [ "$#" -le 4 ] && [ "$#" -ge 1 ] ) || die

RELEASE_VERSION=$1
REGISTRY=peinau.azurecr.io
NAME=portal-documentation
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

# docker run -p 1313:1313 --rm peinau.azurecr.io/portal-documentation:1.0.1

#docker build -t publysher/blog .

#docker stop blog-data blog-nginx
#docker rm blog-data blog-nginx

#docker run -d -v /etc/nginx -v /usr/share/nginx/html --name blog-data publysher/blog echo "Starting blog volume"
#docker run -d --volumes-from blog-data -p 80:80 --name blog-nginx nginx

