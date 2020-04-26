FROM amazonlinux:2

ENV DEPLOY_DIR /root/djangogirls-tutorial

LABEL  maintainer "kamatimaru"

RUN yum -y update && yum clean all

RUN yum install -y python3

RUN mkdir ${DEPLOY_DIR}

WORKDIR ${DEPLOY_DIR}

ADD requirements.txt requirements.txt

RUN pip3 install -r requirements.txt