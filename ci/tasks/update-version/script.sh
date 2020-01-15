#!/usr/bin/env bash

git config --global user.email "git@localhost"
git config --global user.name "git"
git status
git checkout master

VERSION=$(cat ./version)
if [[ -z "$VERSION" ]]; then
    VERSION="0.0.0"
fi

LOG=$(git log --pretty=format:%s --decorate=no ${VERSION}..)

if echo ${LOG} | grep -iqF "#MAJOR"; then
    major=$(echo ${VERSION} | cut -d. -f1)
    ((major=major+1))
    VERSION="${major}.0.0"
elif echo ${LOG} | grep -iqF "#MINOR"; then
    major=$(echo ${VERSION} | cut -d. -f1)
    minor=$(echo ${VERSION} | cut -d. -f2)
    ((minor=minor+1))
    VERSION="${major}.${minor}.0"
else
    major=$(echo ${VERSION} | cut -d. -f1)
    minor=$(echo ${VERSION} | cut -d. -f2)
    patch=$(echo ${VERSION} | cut -d. -f3)
    ((patch=patch+1))
    VERSION="${major}.${minor}.${patch}"
fi

echo ${VERSION} > ./version

git add version
git commit -m "[ci skip] Bumped version to ${VERSION}"