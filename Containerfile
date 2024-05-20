FROM registry.access.redhat.com/ubi9/ubi:latest
RUN dnf install -y golang


RUN go build
COPY hello /usr/bin/hello
