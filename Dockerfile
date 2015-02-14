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

RUN cat /etc/apt/sources.list

# # See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
# # newer versions of the distribution.

# deb http://archive.ubuntu.com/ubuntu/ trusty main restricted
# deb-src http://archive.ubuntu.com/ubuntu/ trusty main restricted

# ## Major bug fix updates produced after the final release of the
# ## distribution.
# deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted
# deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted

# ## Uncomment the following two lines to add software from the 'universe'
# ## repository.
# ## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
# ## team. Also, please note that software in universe WILL NOT receive any
# ## review or updates from the Ubuntu security team.
# deb http://archive.ubuntu.com/ubuntu/ trusty universe
# deb-src http://archive.ubuntu.com/ubuntu/ trusty universe
# deb http://archive.ubuntu.com/ubuntu/ trusty-updates universe
# deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates universe

# ## N.B. software from this repository may not have been tested as
# ## extensively as that contained in the main release, although it includes
# ## newer versions of some applications which may provide useful features.
# ## Also, please note that software in backports WILL NOT receive any review
# ## or updates from the Ubuntu security team.
# # deb http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted
# # deb-src http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted

# deb http://archive.ubuntu.com/ubuntu/ trusty-security main restricted
# deb-src http://archive.ubuntu.com/ubuntu/ trusty-security main restricted
# deb http://archive.ubuntu.com/ubuntu/ trusty-security universe
# deb-src http://archive.ubuntu.com/ubuntu/ trusty-security universe
# # deb http://archive.ubuntu.com/ubuntu/ trusty-security multiverse
# # deb-src http://archive.ubuntu.com/ubuntu/ trusty-security multiverse

# RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
# RUN echo "deb-src http://archive.ubuntu.com/ubuntu trusty main universe" >> /etc/apt/sources.list

# RUN echo "deb http://security.ubuntu.com/ubuntu trusty-security main restricted" >> /etc/apt/sources.list
# RUN echo "deb-src http://security.ubuntu.com/ubuntu trusty-security main restricted" >> /etc/apt/sources.list
# RUN echo "deb http://security.ubuntu.com/ubuntu trusty-security universe" >> /etc/apt/sources.list
# RUN echo "deb-src http://security.ubuntu.com/ubuntu trusty-security universe" >> /etc/apt/sources.list
RUN echo "deb http://security.ubuntu.com/ubuntu trusty-security multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://security.ubuntu.com/ubuntu trusty-security multiverse" >> /etc/apt/sources.list

RUN cat /etc/apt/sources.list

# RUN echo "deb ftp://10.10.14.248/ubuntu/ trusty main universe" > /etc/apt/sources.list

# RUN echo "deb ftp://10.10.14.248/ubuntu/ trusty-security main restricted" >> /etc/apt/sources.list
# RUN echo "deb-src ftp://10.10.14.248/ubuntu/ trusty-security main restricted" >> /etc/apt/sources.list
# RUN echo "deb ftp://10.10.14.248/ubuntu/ trusty-security universe" >> /etc/apt/sources.list
# RUN echo "deb-src ftp://10.10.14.248/ubuntu/ trusty-security universe" >> /etc/apt/sources.list
# RUN echo "deb ftp://10.10.14.248/ubuntu/ trusty-security multiverse" >> /etc/apt/sources.list
# RUN echo "deb-src ftp://10.10.14.248/ubuntu/ trusty-security multiverse" >> /etc/apt/sources.list


RUN apt-get update
RUN apt-get clean
RUN apt-get -y upgrade
RUN apt-get install -y build-essential git
RUN apt-get install -y python-software-properties software-properties-common

RUN apt-get install -y postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 libpq-dev libssl-dev
RUN apt-get install -y wget pgtune apg

VOLUME ["/data"]

EXPOSE 5432
