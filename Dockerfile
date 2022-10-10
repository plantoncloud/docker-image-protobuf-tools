FROM golang:1.17.8
RUN apt update && \
    apt install wget git unzip -y
ARG DEBIAN_FRONTEND=noninteractive
ARG PROTOBUF_VERSION=21.7
ARG PROTOC_GEN_JAVA_GRPC_VERSION=1.45.0
ARG PROTOC_GEN_GO_VERSION=v1.26
ARG PROTOC_GEN_GO_GRPC_VERSION=v1.1
ARG BUF_CLI_VERSION=1.8.0
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOBUF_VERSION/protoc-$PROTOBUF_VERSION-linux-x86_64.zip && \
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
    cp protoc-gen-grpc-java-$PROTOC_GEN_JAVA_GRPC_VERSION-linux-x86_64.exe /usr/local/bin/protoc-gen-grpc-java
ADD build/planton-linux /usr/local/bin/planton
