FROM fpco/stack-build:lts-14.6 as builder

WORKDIR /usr/lib/gcc/x86_64-linux-gnu/7.4.0
RUN cp crtbeginT.o crtbeginT.o.orig
RUN cp crtbeginS.o crtbeginT.o

ADD ./hfmt /opt/hfmt
WORKDIR /opt/hfmt

RUN set -e \
  && stack setup \
  && stack --system-ghc build --ghc-options='-fPIC -optl-static -optl-pthread -optc-Os' \
  && stack --local-bin-path /opt/hfmt/bin install \
  && mkdir -p /opt/hfmt/bin/data \
  && find /root -name 'hlint.yaml' | xargs -I% cp % /opt/hfmt/bin/data/.

FROM alpine:3.10.2
ENV PATH $PATH:/opt/hfmt/bin
ENV VERSION 0.2.3.1_lts-14.6_alpine3.10.2
COPY --from=builder /opt/hfmt/bin/hfmt /opt/hfmt/bin/hfmt
COPY --from=builder /opt/hfmt/bin/data/hlint.yaml /opt/hfmt/bin/data/hlint.yaml
WORKDIR /
RUN hfmt --help

ENTRYPOINT ["/opt/hfmt/bin/hfmt"]
