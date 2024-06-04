FROM golang:1.22.3-alpine3.20 as build

WORKDIR /src

COPY ./ /src/

RUN go build -a -tags netgo -o logstash_exporter .

FROM scratch as final

LABEL maintainer="brenophp@gmail.com"
LABEL description="Logstash exporter"
LABEL org.opencontainers.image.authors="Breno Silva <brenophp@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/brendalf/logstash-exporter"

COPY --from=build /src/logstash_exporter /

EXPOSE 9198

ENTRYPOINT ["/logstash_exporter"]
