# FROM registry.redhat.io/rhel9/go-toolset
FROM registry.access.redhat.com/ubi9/ubi as builder
RUN id
# kernel devel is unnecessary but it requires entitelment, added as example
RUN dnf -y install golang kernel-devel 
COPY hello.go .
COPY go.mod .
RUN go test
RUN go build

FROM registry.access.redhat.com/ubi9/ubi
COPY --from=builder /opt/app-root/src/hello /usr/bin/hello


