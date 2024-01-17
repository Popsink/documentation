MKDOCS_VERSION := 9.5.4
MKDOCS_IMAGE := ppsk/mkdocs-material
MKDOCS_IMAGE_TAG := $(MKDOCS_IMAGE):$(MKDOCS_VERSION)
USER := $(shell id -u):$(shell id -g)
PORT := 8000
DOCKER_ARGS := --rm -it --volume ${PWD}:/docs --user $(USER) -p $(PORT):8000

.PHONY: new serve build docker-build

new: docker-build
serve: docker-build
build: docker-build

docker-build:
	docker build --build-arg MKDOCS_VERSION=$(MKDOCS_VERSION) -t $(MKDOCS_IMAGE_TAG) .

new:
	docker run $(DOCKER_ARGS) $(MKDOCS_IMAGE_TAG) new .

serve:
	docker run $(DOCKER_ARGS) $(MKDOCS_IMAGE_TAG) serve --dev-addr=0.0.0.0:8000

build:
	docker run $(DOCKER_ARGS) $(MKDOCS_IMAGE_TAG) build
