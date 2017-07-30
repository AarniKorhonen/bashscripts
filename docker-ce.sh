#!/bin/bash

#This be basic script to install docker-ce

yum install -y yum-utils device-mapper-persistent-data lvm2 -y

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
	
yum makecache fast

yum install docker-ce -y

systemctl start docker

docker run hello-world