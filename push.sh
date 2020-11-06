#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}

. config_file

if [ -n "$1" ]; then
  MAINAINER=$1
fi

if [ -n "$2" ]; then
  UBUNTU_VERSION=$2
fi

if [ -n "$3" ]; then
  BOOST_VERSION=$3
fi

BASE_IMAGE="${MAINAINER}/${IMAGE_NAME}"
TARGET="${BASE_IMAGE}:${UBUNTU_VERSION}-${BOOST_VERSION}"
LATEST="${BASE_IMAGE}:latest"

docker tag "${TARGET}" "${LATEST}"
docker login && docker push "${TARGET}" && docker push "${LATEST}"
