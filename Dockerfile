FROM amazonlinux:2

LABEL  maintainer "kamatimaru"

RUN yum install -y python3
RUN pip3 install django==2.2.4