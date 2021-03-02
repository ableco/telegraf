FROM golang:1.16 as BUILD
ARG VERSION_PREFIX="release-"
ARG VERSION
RUN git clone --depth 1 -b ${VERSION_PREFIX}${VERSION} https://github.com/ableco/telegraf.git /go/src/github.com/influxdata/telegraf
WORKDIR /go/src/github.com/influxdata/telegraf
RUN make

FROM telegraf:${VERSION}
COPY --from=BUILD /go/src/github.com/influxdata/telegraf/telegraf /usr/bin/telegraf
ENTRYPOINT [ "/usr/bin/telegraf" ]
CMD ["--config","/etc/telegraf/telegraf.conf"]
