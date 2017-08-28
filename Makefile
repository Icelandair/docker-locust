ifndef COMPONENT
	COMPONENT := docker-locust
endif

ifndef PROJECT_NAME
	PROJECT_NAME := icelandairlabs-com
endif

ifndef DOMAIN
	DOMAIN := icelandairlabs.com
endif

ifndef DOCKER_REGISTRY_HOST
	DOCKER_REGISTRY_HOST := docker.${DOMAIN}
endif

ifndef PIPELINE_VERSION
	PIPELINE_VERSION := latest
endif

ifndef IMAGE_TAG
	IMAGE_TAG := $(shell git rev-parse --short HEAD)
endif

ifndef FULL_GIT_SHA
	FULL_GIT_SHA := $(shell git rev-parse HEAD)
endif

ifndef DOCKER_IMAGE
	DOCKER_IMAGE := ${DOCKER_REGISTRY_HOST}/${PROJECT_NAME}/${COMPONENT}:${IMAGE_TAG}
endif

ifndef DOCKER_IMAGE_LATEST
	DOCKER_IMAGE_LATEST := ${DOCKER_REGISTRY_HOST}/${PROJECT_NAME}/${COMPONENT}:latest
endif

all: docker-build docker-push deployment

# docker
docker-build:
	echo ${FULL_GIT_SHA} > version.txt
	git config --local --get remote.origin.url > gitrepo.txt
	docker build -t ${DOCKER_IMAGE} .

docker-push:
	docker tag ${DOCKER_IMAGE} ${DOCKER_IMAGE_LATEST}
	docker push ${DOCKER_IMAGE_LATEST}
