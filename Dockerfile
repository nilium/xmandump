FROM golang:1.15-alpine as build
WORKDIR /go/xmandump
COPY . .
RUN go mod vendor && \
        CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o /xmandump ./cmd/xmandump/*

FROM scratch
COPY --from=build /xmandump /xmandump
LABEL org.opencontainers.image.source https://github.com/void-linux/xmandump
VOLUME /man
WORKDIR /man
