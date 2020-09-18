FROM hashicorp/packer:1.6.2 AS packer
FROM ubuntu:20.04

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG APT='bash curl dnsutils git jq jsonnet make python-is-python3 python3-pip sshpass vim wget zip'
ARG PIP='ansible-base==2.10.1 awscli boto3 cryptography dopy netaddr pyhcl pymysql yq'

RUN set -x && \
  apt-get update && \
  apt-get --yes install ${APT} && \
  pip3 install ${PIP} && \
  rm -rf ~/.cache

COPY ./scripts/.bin/asdf-terraform /tmp/asdf-terraform
RUN set -x && bash -c "/tmp/asdf-terraform" && rm "/tmp/asdf-terraform"

COPY --from=packer /bin/packer /bin/packer

WORKDIR /app
