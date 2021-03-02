FROM golang:1.16 as BUILD
COPY . /go/src/github.com/ableco/telegraf/
WORKDIR /go/src/github.com/ableco/telegraf
RUN make

FROM telegraf:1.17
LABEL org.opencontainers.image.source=https://github.com/ableco/telegraf
COPY --from=BUILD /go/src/github.com/ableco/telegraf/telegraf /usr/bin/telegraf
ENTRYPOINT [ "/usr/bin/telegraf" ]
CMD ["--config","/etc/telegraf/telegraf.conf"]
