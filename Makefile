MKDOCS_IMAGE := squidfunk/mkdocs-material:9.5.4
USER := $(shell id -u):$(shell id -g)
PORT := 8000
DOCKER_ARGS := --rm -it --volume ${PWD}:/docs --user $(USER) -p $(PORT):8000

.PHONY: new serve build

new:
	docker run $(DOCKER_ARGS) $(MKDOCS_IMAGE) new .

serve:
	docker run $(DOCKER_ARGS) $(MKDOCS_IMAGE) serve --dev-addr=0.0.0.0:8000

build:
	docker run $(DOCKER_ARGS) $(MKDOCS_IMAGE) build
