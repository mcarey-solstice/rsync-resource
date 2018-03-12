###
# Project commands
##

# Variables

## Defaults
ENV_FILE ?= .env
PACKAGE_INFO ?= ../.package-info

DOCKER_SERVER =
DOCKER_USERNAME =
DOCKER_PASSWORD =

## Load the environment
ifneq (,$(wildcard $(ENV_FILE)))
	include $(ENV_FILE)
	export $(shell sed 's/=.*//' $(ENV_FILE))
endif

APP_NAME = $(shell grep 'APP_NAME = ' $(PACKAGE_INFO) | sed 's/APP_NAME = //g')
VERSION = test

DOCKER_TAG ?= $(APP_NAME)


# Helpers

.PHONY: *

help:
	@echo "Usage: make <command>"
	@echo ""
	@echo "  env      Creates the \`.env\` file from \`../.env.example\`"
	@echo "  keys     Creates SSH key pair"
	@echo "  shell    Starts a shell in the docker image"
	@echo ""
# help

.DEFAULT_GOAL := help

env: .env

.env:
	cp ../.env.example .env
# .env

keys: .keys/key_rsa

.keys/key_rsa:
	./keygen.sh
# keys

build:
	cd .. && ${MAKE} DOCKER_TAG=rsync-resource:test build
	docker-compose build
# build

start: build keys
	docker-compose up -d
# start

stop:
	docker-compose stop
# stop

destroy:
	docker-compose destroy
	rm -rf keys
# destroy

shell: start
	docker-compose exec client bash
# shell

# debug.Makefile
