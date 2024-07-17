# FROM registry.redhat.io/rhel9/go-toolset
FROM registry.access.redhat.com/ubi9/ubi as builder
# kernel devel is unnecessary but it requires entitlement, added as example
RUN \
    # Enable additional repositories for CentOS or RHEL.
    REPO_ARCH=$(uname -m) && \
    RUN dnf -y --setopt=install_weak_deps=0 install \
        --enablerepo=rhel-9-for-${REPO_ARCH}-appstream-rpms,codeready-builder-for-rhel-9-${REPO_ARCH}-rpms \
        cargo pkg-config perl-FindBin openssl-devel perl-lib perl-IPC-Cmd perl-File-Compare perl-File-Copy clang-devel \
        # These two are only available in the CodeReady Builder repo.
        tpm2-tss-devel protobuf-compiler \
        # This one is needed to build the stub.
        meson

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


