FROM golang:1.17.8
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install wget git unzip -y
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.19.1/protoc-3.19.1-linux-x86_64.zip && \
    unzip protoc-3.19.1-linux-x86_64.zip && \
    chmod +x bin/protoc && \
    cp bin/protoc /usr/local/bin && \
    wget https://github.com/bufbuild/buf/releases/download/v1.1.1/buf-Linux-x86_64 && \
    chmod +x buf-Linux-x86_64 && \
    cp buf-Linux-x86_64 /usr/local/bin/buf && \
    GOBIN=/usr/local/bin/ go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1 && \
    GOBIN=/usr/local/bin/ go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26 && \
    wget https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.45.0/protoc-gen-grpc-java-1.45.0-linux-x86_64.exe && \
    chmod +x protoc-gen-grpc-java-1.45.0-linux-x86_64.exe && \
    cp protoc-gen-grpc-java-1.45.0-linux-x86_64.exe /usr/local/bin/protoc-gen-grpc-java
