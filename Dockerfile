# Copyright (C) 2017, Roger Ye 
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
# Dockerfile - Dockerfile used to build the image
#
# Copyright (c) 2017 Roger Ye.  All rights reserved.
#
#******************************************************************************
#
FROM shugaoye/docker-ethereum:latest

RUN echo 'root:root' | chpasswd
RUN addgroup -g 3000 ethereum
RUN adduser -D -u 3000 -G ethereum ethereum

RUN echo "ethereum ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

WORKDIR /home/ethereum
COPY scripts/bash.bashrc /root/bash.bashrc
COPY scripts/docker_entrypoint.sh /root/docker_entrypoint.sh
RUN chmod 755 /root /root/bash.bashrc /root/docker_entrypoint.sh

USER ethereum
ENTRYPOINT ["/root/docker_entrypoint.sh"]