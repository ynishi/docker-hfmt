#!/bin/bash

set -eux

docker build --cache-from builder -t ynishi/docker-hfmt:latest .
docker build --cache-from builder -t ynishi/docker-hfmt:${VERSION} .

docker push ynishi/docker-hfmt:latest .
docker push ynishi/docker-hfmt:${VERSION} .
