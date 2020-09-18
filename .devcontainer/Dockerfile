FROM centos:8

ARG USERNAME=codespace
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV SHELL=/usr/bin/zsh \
    GOROOT="/usr/local/go"

ENV PATH="${GOROOT}/bin:${GOPATH}/bin:${PATH}"

RUN dnf update -y && \
    dnf install -y epel-release && \
    dnf update -y && \
    dnf install -y \
        curl \
        git \
        htop \
        jq \
        sudo \
        wget \
        zsh

WORKDIR /home/codespace

COPY . /tmp/scripts/

RUN bash /tmp/scripts/setup-user.sh "${USERNAME}" "${PATH}"
RUN bash /tmp/scripts/setup.sh

USER codespace
