FROM ubuntu:20.04

WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y wget git unzip make && \
    # install swift dependencies https://www.swift.org/download/#installation
    apt install -y clang \
    binutils \
    gnupg2 \
    libc6-dev \
    libcurl4 \
    libedit2 \
    libgcc-9-dev \
    libpython2.7-dev \
    libpython2.7 \
    libsqlite3-0 \
    libstdc++-9-dev \
    libxml2 \
    libz3-dev \
    pkg-config \
    tzdata \
    uuid-dev \
    zlib1g-dev

# https://github.com/apple/swift/releases/latest
ARG SWIFT_VERSION=5.7

# install swift
RUN    wget https://download.swift.org/swift-$SWIFT_VERSION-release/ubuntu2004/swift-$SWIFT_VERSION-RELEASE/swift-$SWIFT_VERSION-RELEASE-ubuntu20.04.tar.gz && \
    tar -xvzf swift-$SWIFT_VERSION-RELEASE-ubuntu20.04.tar.gz && \
    rm -f swift-$SWIFT_VERSION-RELEASE-ubuntu20.04.tar.gz && \
    mv swift-5.7-RELEASE-ubuntu20.04 /usr/share/swift

ENV PATH="${PATH}:/usr/share/swift/usr/bin"

ENV GOLANG_VERSION=1.20

# protoc compiler and plugin versions

# protoc --version
ARG PROTOBUF_VERSION=23.2

# protoc-gen-go --version
ARG PROTOC_GEN_GO_VERSION=v1.28.1

# protoc-gen-go-grpc --version
ARG PROTOC_GEN_GO_GRPC_VERSION=v1.1.0

ARG PROTOC_GEN_JAVA_GRPC_VERSION=1.55.1

# https://github.com/apple/swift-protobuf/releases/latest
# protoc-gen-swift --version
# this is not used as https://github.com/grpc/grpc-swift/releases/latest zip contains both protobuf and grpc plugins
# ARG PROTOC_GEN_SWIFT_VERSION=1.20.2

# https://github.com/grpc/grpc-swift/releases/latest
ARG PROTOC_GEN_SWIFT_GRPC_VERSION=1.18.0

ARG BUF_CLI_VERSION=1.18.0

ARG PLANTON_CLI_VERSION=v0.0.61

ENV GO111MODULE=on
ENV GOPATH=/go
ENV GOROOT=/usr/local/go
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH

RUN wget https://storage.googleapis.com/planton-cli/$PLANTON_CLI_VERSION/planton-cli-$PLANTON_CLI_VERSION-linux && \
    chmod +x planton-cli-$PLANTON_CLI_VERSION-linux && \
    mv planton-cli-$PLANTON_CLI_VERSION-linux planton && \
    cp planton /usr/local/bin && \
    wget https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOBUF_VERSION/protoc-$PROTOBUF_VERSION-linux-x86_64.zip && \
    unzip protoc-$PROTOBUF_VERSION-linux-x86_64.zip && \
    rm -f protoc-$PROTOBUF_VERSION-linux-x86_64.zip && \
    chmod +x bin/protoc && \
    cp bin/protoc /usr/local/bin && \
    wget https://github.com/bufbuild/buf/releases/download/v$BUF_CLI_VERSION/buf-Linux-x86_64 && \
    chmod +x buf-Linux-x86_64 && \
    cp buf-Linux-x86_64 /usr/local/bin/buf && \
    wget  https://go.dev/dl/go$GOLANG_VERSION.linux-amd64.tar.gz && \
    tar -xvf go$GOLANG_VERSION.linux-amd64.tar.gz && \
    rm -f go$GOLANG_VERSION.linux-amd64.tar.gz && \
    mv go /usr/local && \
    GOBIN=/usr/local/bin/ go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@$PROTOC_GEN_GO_GRPC_VERSION && \
    GOBIN=/usr/local/bin/ go install google.golang.org/protobuf/cmd/protoc-gen-go@$PROTOC_GEN_GO_VERSION && \
    wget https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/$PROTOC_GEN_JAVA_GRPC_VERSION/protoc-gen-grpc-java-$PROTOC_GEN_JAVA_GRPC_VERSION-linux-x86_64.exe && \
    chmod +x protoc-gen-grpc-java-$PROTOC_GEN_JAVA_GRPC_VERSION-linux-x86_64.exe && \
    cp protoc-gen-grpc-java-$PROTOC_GEN_JAVA_GRPC_VERSION-linux-x86_64.exe /usr/local/bin/protoc-gen-grpc-java && \
    wget https://github.com/grpc/grpc-swift/releases/download/$PROTOC_GEN_SWIFT_GRPC_VERSION/protoc-grpc-swift-plugins-linux-x86_64-$PROTOC_GEN_SWIFT_GRPC_VERSION.zip && \
    unzip protoc-grpc-swift-plugins-linux-x86_64-$PROTOC_GEN_SWIFT_GRPC_VERSION.zip && \
    rm -f protoc-grpc-swift-plugins-linux-x86_64-$PROTOC_GEN_SWIFT_GRPC_VERSION.zip && \
    chmod +x protoc-gen-grpc-swift protoc-gen-swift && \
    cp protoc-gen-grpc-swift /usr/local/bin && \
    cp protoc-gen-swift /usr/local/bin
