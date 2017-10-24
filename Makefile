# Copyright (C) 2017 Roger Ye
# Ethereum in a container
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#******************************************************************************
#
# Makefile - Make file for the docker build
#
# Copyright (c) 2017 Roger Ye.  All rights reserved.
#
#******************************************************************************
#
# Makefile to build and test docker containers
#   VOL1 - the one used to build source code
#   VOL2 - the one used to store build cache
# Both can be defined in your environment, otherwise the below default values
# will be used.

IMAGE_NAME = ethereum
TAG_NAME ?= dev
VERSION ?= 2
DOCKER = docker
IMAGE = shugaoye/docker-$(IMAGE_NAME):$(TAG_NAME)
VOL1 ?= /home/aosp/ethereum/.ethereum
VOL2 ?= $(HOME)/.ccache
VOL3 ?= /home/android
USER_ID := $(shell id -u)
GROUP_ID := $(shell id -g)

all: Dockerfile
	$(DOCKER) build -t $(IMAGE) .

# docker run --name ethereum_node -it -p 30303:30303 -v /home/aosp/ethereum/.ethereum:/root/.ethereum ethereum/client-go:v1.7.2 --fast --cache 512 console
run:
	$(DOCKER) run --privileged --name "$(IMAGE_NAME)_$(TAG_NAME)_v$(VERSION)" -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
	-v "$(VOL1):/home/ethereum/.ethereum" \
	-it -e DISPLAY=$(DISPLAY) -e USER_ID=$(USER_ID) -e GROUP_ID=$(GROUP_ID) \
	$(IMAGE) /bin/bash

.PHONY: all
