#!/bin/bash

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
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

echo MAINAINER=${MAINAINER} > config_file
echo IMAGE_NAME=${IMAGE_NAME} >> config_file
echo UBUNTU_VERSION=${UBUNTU_VERSION} >> config_file
echo BOOST_VERSION=${BOOST_VERSION} >> config_file

BOOST_SUBSTR="${BOOST_VERSION//./_}"
BOOST_SRC="/opt/src/boost_${BOOST_SUBSTR}"
BOOST_TAR_FILE="boost_${BOOST_SUBSTR}.tar.gz"

if [ ! -f $BOOST_TAR_FILE ]; then
   echo "File $BOOST_TAR_FILE does not exists. Downloding ..."
   BOOST_TAR_FILE_URI="https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/${BOOST_TAR_FILE}"
   wget ${BOOST_TAR_FILE_URI}
fi

python3 render.py ${UBUNTU_VERSION} ${BOOST_VERSION} 

BASE_IMAGE="${MAINAINER}/${IMAGE_NAME}"
TARGET="${BASE_IMAGE}:${UBUNTU_VERSION}-${BOOST_VERSION}"

docker build -t "${TARGET}" \
  --build-arg UBUNTU_VERSION="${UBUNTU_VERSION}" \
  .
