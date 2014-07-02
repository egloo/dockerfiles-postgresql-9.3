# Copyright 2014 George Cooper
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:14.04

MAINTAINER eGloo

RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential git
RUN apt-get install -y python-software-properties software-properties-common

RUN apt-get install -y postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3
RUN apt-get install -y wget pgtune apg

VOLUME ["/data"]

EXPOSE 5432
