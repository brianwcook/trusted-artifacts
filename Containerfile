FROM registry.redhat.io/rhel9/go-toolset
COPY hello.go .
COPY go.mod .


RUN go build
COPY /opt/app-root/src/hell /usr/bin/hello

