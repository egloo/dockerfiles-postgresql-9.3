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

RUN apt-get install -y postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 libpq-dev postgresql-server-dev-9.3
RUN apt-get install -y wget pgtune apg

VOLUME ["/data"]

# Inspired by http://amattn.com/p/tutorial_postgresql_usage_examples_with_docker.html

RUN cp /etc/postgresql/9.3/main/postgresql.conf /data/postgresql.conf
RUN cp /etc/postgresql/9.3/main/pg_hba.conf /data/pg_hba.conf

RUN sed -i '/^data_directory*/ s|/var/lib/postgresql/9.3/main|/data/main|' /data/postgresql.conf
RUN sed -i '/^hba_file*/ s|/etc/postgresql/9.3/main/pg_hba.conf|/data/pg_hba.conf|' /data/postgresql.conf

RUN mkdir -p /data/main
RUN chown postgres /data/*
RUN chgrp postgres /data/*
RUN chmod 700 /data/main
RUN su postgres --command "/usr/lib/postgresql/9.3/bin/initdb -D /data/main"
RUN cp /postgresql.conf /data/postgresql.conf
RUN cp /pg_hba.conf /data/pg_hba.conf

# NOT SECURE! Modify according to your setup
RUN sed -i "/^#listen_addresses/i listen_addresses='*'" /data/postgresql.conf
RUN sed -i "/^# DO NOT DISABLE\!/i # Allow access from any IP address" /data/pg_hba.conf
RUN sed -i "/^# DO NOT DISABLE\!/i host all all 0.0.0.0/0 md5\n\n\n" /data/pg_hba.conf

# Start postgres
RUN su postgres --command "/usr/lib/postgresql/9.3/bin/postgres -D /data/main -c config_file=/data/postgresql.conf" &

# As the user postgres, create a user named docker
RUN su postgres --command 'createuser -P -d -r -s docker'

# As the user postgres, create a db docker owned by postgres user docker
RUN su postgres --command 'createdb -O docker docker'

# Shutdown postgres
RUN su postgres --command '/usr/lib/postgresql/9.3/bin/pg_ctl --pgdata=/data/main stop'

EXPOSE 5432

CMD	["/bin/su", "postgres", "-c", "/usr/lib/postgresql/9.3/bin/postgres -D /data/main -c config_file=/data/postgresql.conf"]
