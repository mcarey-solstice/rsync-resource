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
	@echo "  build    Builds the docker image"
	@echo "  start    Starts the docker image"
	@echo "  stop     Stops the docker image"
	@echo "  destroy  Destroys the docker image"
	@echo "  shell    Starts a shell in the docker image"
	@echo "  run      Runs the test suite within the docker image"
	@echo ""
# help

.DEFAULT_GOAL := help

env: .env

.env:
	cp ../.env.example .env
# .env

build:
	docker-compose build
# build

start: build
	docker-compose up -d
# start

stop:
	docker-compose stop
# stop

destroy:
	docker-compose destroy
# destroy

shell: start
	docker-compose exec tests bash
# shell

run:
	docker-compose exec tests /opt/tests/run.sh
# run

# tests.Makefile
