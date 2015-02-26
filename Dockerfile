# Pull base image.
FROM       ubuntu:latest

# Install MongoDB.
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

RUN apt-get update && apt-get install -y mongodb-org

RUN mkdir -p /data/db

ADD replicaSet.sh /replicaSet.sh
ADD replicaSet.js /replicaSet.js

# Expose port 27017 from the container to the host
EXPOSE 27017

# Set usr/bin/mongod as the dockerized entry-point application
CMD ["usr/bin/mongod", "--replSet", "rs0"]

