#!/bin/bash

set -eux

BRANCH=$(git branch | grep '^\*' | grep -v master | awk '{print $2}')
test -n "$BRANCH"
VERSION=${VERSION:-$BRANCH}

docker build --cache-from builder -t ynishi/docker-hfmt:latest .
docker build --cache-from builder -t ynishi/docker-hfmt:${VERSION} .

docker push ynishi/docker-hfmt:latest
docker push ynishi/docker-hfmt:${VERSION}
