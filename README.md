# docker-hfmt
docker image for hfmt command.

* based on stack-build for build, alpine for binary.
* version 0.2.3.1_lts-14.6_alpine3.10.2 ${hfmt version}_${stack lts version}_${base image version}

## Usage
### run
```
docker run --rm -it -v $(pwd):/data ynishi/docker-hfmt /data
```
### sh in container
```
docker run --rm -it --entrypoint=sh ynishi/docker-hfmt
```
### build(local)
support cache build stage image.
```
sudo sh build.sh
```

## License
MIT, see LICENSE.
