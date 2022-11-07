v?=local
docker_image_repo=us-central1-docker.pkg.dev/pcs-org-shared-services-5n/planton-pcs-docker-repo-external
docker_image_path=gitlab.com/plantoncode/planton/oss/docker-images/protobuf
docker_image_tag?=${v}
docker_image=${docker_image_repo}/${docker_image_path}:${docker_image_tag}

.PHONY: build
build:
	docker build --platform linux/amd64 -t ${docker_image} .
release:
	docker push ${docker_image}
