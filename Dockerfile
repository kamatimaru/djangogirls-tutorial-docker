FROM amazonlinux:2

LABEL maintainer "kamatimaru"

ENV DEPLOY_DIR /root/djangogirls-tutorial

RUN yum update -y && yum clean all

# ロケールを日本語に設定する。
# 設定しておかないと、expectコマンドで日本語がヒットしない。
RUN yum install -y glibc-langpack-ja
ENV LANG ja_JP.UTF-8

# リモートでVS Codeを実行するために必要
RUN yum install -y tar

# リモートでVS CodeでGitを実行するために必要
RUN yum install -y git

# psコマンドを使えないとコンテナ内で調査するときに困るのでインストールしておく。
RUN yum install -y procps

# Python3をインストール
RUN yum install -y python3

# 以下はmysqlclient(Python)のインストールに必要
RUN yum install -y python3-devel mysql mysql-devel gcc

# コンテナ起動時にDjangoのcreatesuperuserを実行してadminユーザーを作成する。
# createsuperuserは対話モードで実行されるため、自動化するためにexpectが必要
RUN yum install -y expect

WORKDIR ${DEPLOY_DIR}

ADD requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

ENTRYPOINT /bin/bash ${DEPLOY_DIR}/docker-entrypoint.sh

EXPOSE 8000