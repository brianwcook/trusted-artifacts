FROM registry.redhat.io/rhel9/go-toolset
COPY hello.go .
COPY go.mod .


RUN go build
RUN mv /opt/app-root/src/hello /usr/bin/hello

