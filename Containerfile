# FROM registry.redhat.io/rhel9/go-toolset
FROM registry.access.redhat.com/ubi9/ubi as builder
# kernel devel is unnecessary but it requires entitlement, added as example
RUN \
    # Enable additional repositories for CentOS or RHEL.
    if command -v subscription-manager; then \
    REPO_ARCH=$(uname -m) && \
    subscription-manager repos --enable rhel-9-for-${REPO_ARCH}-appstream-rpms --enable codeready-builder-for-rhel-9-${REPO_ARCH}-rpms; \
    else \
    dnf -y install 'dnf-command(config-manager)' && dnf config-manager --enable crb; \
    fi

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


