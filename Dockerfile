FROM amazonlinux:2

LABEL maintainer "kamatimaru"

ENV DEPLOY_DIR /root/djangogirls-tutorial

RUN yum -y update && yum clean all

RUN yum install -y python3

# 以下はmysqlclientのインストールに必要
RUN yum install -y python3-devel mysql mysql-devel gcc

# コンテナ起動時にDjangoのcreatesuperuserを実行してadminユーザーを作成する。
# createsuperuserは対話モードで実行されるため、自動化するためにexpectが必要
RUN yum install -y expect

WORKDIR ${DEPLOY_DIR}

ADD requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

ENTRYPOINT /bin/bash ${DEPLOY_DIR}/docker-entrypoint.sh

EXPOSE 8000