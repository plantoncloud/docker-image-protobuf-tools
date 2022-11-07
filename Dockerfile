FROM golang:1.19.2

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install wget git unzip -y

# protoc compiler and plugin versions

# protoc --version
ARG PROTOBUF_VERSION=21.7

# protoc-gen-go --version
ARG PROTOC_GEN_GO_VERSION=v1.28.1

# protoc-gen-go-grpc --version
ARG PROTOC_GEN_GO_GRPC_VERSION=v1.1.0

ARG PROTOC_GEN_JAVA_GRPC_VERSION=1.45.0

# https://github.com/apple/swift-protobuf/releases/latest
# protoc-gen-swift --version
# this is not used as https://github.com/grpc/grpc-swift/releases/latest zip contains both protobuf and grpc plugins
# ARG PROTOC_GEN_SWIFT_VERSION=1.20.2

# https://github.com/grpc/grpc-swift/releases/latest
ARG PROTOC_GEN_SWIFT_GRPC_VERSION=1.13.0

ARG BUF_CLI_VERSION=1.9.0

ARG PLANTON_CLI_VERSION=v0.0.13

RUN wget https://storage.googleapis.com/planton-pcs-artifact-file-repo/tool/cli/download/planton-cli-$PLANTON_CLI_VERSION-linux && \
    chmod +x planton-cli-$PLANTON_CLI_VERSION-linux && \
    mv planton-cli-$PLANTON_CLI_VERSION-linux planton && \
    cp planton /usr/local/bin && \
    wget https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOBUF_VERSION/protoc-$PROTOBUF_VERSION-linux-x86_64.zip && \
    unzip protoc-$PROTOBUF_VERSION-linux-x86_64.zip && \
    chmod +x bin/protoc && \
    cp bin/protoc /usr/local/bin && \
    wget https://github.com/bufbuild/buf/releases/download/v$BUF_CLI_VERSION/buf-Linux-x86_64 && \
    chmod +x buf-Linux-x86_64 && \
    cp buf-Linux-x86_64 /usr/local/bin/buf && \
    GOBIN=/usr/local/bin/ go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@$PROTOC_GEN_GO_GRPC_VERSION && \
    GOBIN=/usr/local/bin/ go install google.golang.org/protobuf/cmd/protoc-gen-go@$PROTOC_GEN_GO_VERSION && \
    wget https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/$PROTOC_GEN_JAVA_GRPC_VERSION/protoc-gen-grpc-java-$PROTOC_GEN_JAVA_GRPC_VERSION-linux-x86_64.exe && \
    chmod +x protoc-gen-grpc-java-$PROTOC_GEN_JAVA_GRPC_VERSION-linux-x86_64.exe && \
    cp protoc-gen-grpc-java-$PROTOC_GEN_JAVA_GRPC_VERSION-linux-x86_64.exe /usr/local/bin/protoc-gen-grpc-java && \
    wget https://github.com/grpc/grpc-swift/releases/download/$PROTOC_GEN_SWIFT_GRPC_VERSION/protoc-grpc-swift-plugins-linux-x86_64-$PROTOC_GEN_SWIFT_GRPC_VERSION.zip && \
    unzip protoc-grpc-swift-plugins-linux-x86_64-$PROTOC_GEN_SWIFT_GRPC_VERSION.zip && \
    chmod +x protoc-gen-grpc-swift protoc-gen-swift && \
    cp protoc-gen-grpc-swift /usr/local/bin && \
    cp protoc-gen-swift /usr/local/bin
