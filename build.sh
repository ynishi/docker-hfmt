#!/bin/bash

# multi stage builder
docker build --target builder -t builder .

# multi stage to use
docker build --cache-from builder -t hfmt .

# check docker image
mkdir -p tmp 
echo "inc=(+1)
main=do
 let i1 = inc 0
 let i2 = inc i1
 print i1
 print i2
" > tmp/inc.hs
docker run --rm -it -v $(pwd)/tmp:/data hfmt /data/inc.hs
