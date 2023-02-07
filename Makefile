SHELL := /bin/bash
NAME := strimzi-kafka-operator-aws-msk-iam-auth
STRIMZI_VERSION := 0.32.0
KAFKA_VERSION := 3.3.1
AWS_MSK_IAM_AUTH_VERSION := 1.1.6
TAG := ${STRIMZI_VERSION}-kafka-${KAFKA_VERSION}-aws-${AWS_MSK_IAM_AUTH_VERSION}

.PHONY: help all

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build docker images
	docker build . -t $(NAME) --build-arg STRIMZI_VERSION=$(STRIMZI_VERSION) --build-arg KAFKA_VERSION=$(KAFKA_VERSION) --build-arg AWS_MSK_IAM_AUTH_VERSION=$(AWS_MSK_IAM_AUTH_VERSION)  
	docker tag $(NAME) aidanmelen/$(NAME):$(TAG)
	docker tag $(NAME) aidanmelen/$(NAME):latest

dev: ## dev docker images
	docker run -it --rm --entrypoint /bin/bash $(NAME)

release: build ## Push docker images
	docker login aidanmelen

	docker push aidanmelen/$(NAME):$(TAG)
	docker push aidanmelen/$(NAME):latest