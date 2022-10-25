#!/bin/bash

OLD_VERSION=<RELEASE_OLD_VERSION>
NEW_VERSION=<RELEASE_NEW_VERSION>
WORKING_DIR=<WORKING_DIR>
RELEASE_NAME=paasta-collector

if [ -d ./.dev_builds ]; then
  echo "delete .dev_builds"
  rm -rf .dev_builds
fi

if [ -d ./dev_releases ]; then
  echo "delete dev_releases"
  rm -rf dev_releases
fi

if [ -f ./${RELEASE_NAME}-release-${OLD_VERSION}.tgz ]; then
  echo "delete ${RELEASE_NAME}-release-${OLD_VERSION}.tgz"
  rm -rf ${RELEASE_NAME}-release-${OLD_VERSION}.tgz
fi


tar -zcf ${RELEASE_NAME}-release-${NEW_VERSION}.tgz src/

if [ -f ./${RELEASE_NAME}-release-${NEW_VERSION}.tgz ]; then
  echo "success!!"
else
  echo "Dose not exist ${RELEASE_NAME}-release-${NEW_VERSION}.tgz"
  exit 1
fi

bosh create-release --force --tarball ${RELEASE_NAME}-release-${NEW_VERSION}.tgz --name ${RELEASE_NAME}-release --version ${NEW_VERSION}