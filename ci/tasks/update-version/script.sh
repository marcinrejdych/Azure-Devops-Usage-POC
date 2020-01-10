#!/usr/bin/env bash

GITHUB_USER=$1
GITHUB_USER=$2

function add_credentials_to_remote() {
    git config --global user.email "git@localhost"
    git config --global user.name "git"
    git checkout master
    local remote
    remote=$(git remote show origin -n | grep "Fetch URL" | awk '{print $3}')
    remote=$(echo ${remote} | sed 's|://|://'${GITHUB_USER}':'${GITHUB_PASS}'@|')
    git remote set-url origin ${remote}
}

add_credentials_to_remote

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
git push origin master