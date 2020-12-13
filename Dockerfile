FROM ubuntu:20.04

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG APT='bash curl dnsutils git jq jsonnet make python-is-python3 python3-pip sshpass vim wget zip'
ARG PIP='ansible-base==2.10.3 awscli boto3 cryptography dopy netaddr pyhcl pymysql yq'

RUN set -x && \
  apt-get update && \
  apt-get --yes install ${APT} && \
  pip3 install ${PIP} && \
  rm -rf ~/.cache

COPY ./scripts/.bin/asdf-install /tmp/asdf-install
RUN set -x && bash -c "/tmp/asdf-install" && rm "/tmp/asdf-install"

WORKDIR /app
