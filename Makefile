SHELL := /bin/bash
NAME := strimzi-kafka-operator-aws-msk-iam-auth
STRIMZI_KAFKA_TAG := 0.33.0-kafka-3.3.2
AWS_MSK_IAM_AUTH_VERSION := latest
TAG := ${STRIMZI_KAFKA_TAG}-aws-${AWS_MSK_IAM_AUTH_VERSION}

.PHONY: help all

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build docker images
	docker build . -t $(NAME) --build-arg STRIMZI_KAFKA_TAG=$(STRIMZI_KAFKA_TAG) --build-arg AWS_MSK_IAM_AUTH_VERSION=$(AWS_MSK_IAM_AUTH_VERSION)  
	docker tag $(NAME) aidanmelen/$(NAME):$(TAG)
	docker tag $(NAME) aidanmelen/$(NAME):latest

dev: ## dev docker images
	docker run -it --rm --entrypoint /bin/bash $(NAME)