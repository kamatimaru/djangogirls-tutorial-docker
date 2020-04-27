FROM amazonlinux:2

LABEL  maintainer "kamatimaru"

ENV DEPLOY_DIR /root/djangogirls-tutorial

RUN yum -y update && yum clean all

RUN yum install -y python3

WORKDIR ${DEPLOY_DIR}

ADD requirements.txt requirements.txt

RUN pip3 install -r requirements.txt