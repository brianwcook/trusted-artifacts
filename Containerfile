# FROM registry.redhat.io/rhel9/go-toolset
FROM registry.access.redhat.com/ubi9/ubi as builder
# kernel devel is unnecessary but it requires entitlement, added as example
RUN dnf -y install golang k
RUN mkdir /build
WORKDIR /build
RUN pwd
COPY hello.go .
COPY go.mod .
COPY hello_test.go .

# run tests
RUN go test

# build
RUN go build

# copy binary to clean image
FROM registry.access.redhat.com/ubi9/ubi
COPY --from=builder /build/hello /usr/bin/hello


