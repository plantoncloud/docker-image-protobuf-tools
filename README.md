# buf-cli

This docker image project is for creating a docker image to run gitlab jobs that build protobuf files using [buf cli](https://buf.build/). [buf cli](https://buf.build/) requires that the language specific protobuf plugins be present for the compilation to be successful. So, all the protoc bundles are installed in the docker image.
 