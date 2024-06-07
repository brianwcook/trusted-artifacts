FROM registry.redhat.io/rhel9/go-toolset
dnf -y install kernel-devel
COPY hello.go .
COPY go.mod .


RUN go build
RUN mv /opt/app-root/src/hello /usr/bin/hello

