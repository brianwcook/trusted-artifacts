FROM registry.redhat.io/rhel9/go-toolset
COPY hello.go .
COPY go.mod .


RUN go build
COPY ./hello /usr/bin/hello

