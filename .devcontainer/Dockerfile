FROM centos:8

ARG USERNAME=codespace
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV SHELL=/usr/bin/zsh \
    GOROOT="/usr/local/go"

ENV PATH="${GOROOT}/bin:${GOPATH}/bin:${PATH}"

WORKDIR /home/codespace

COPY . /tmp/build/

RUN dnf update -y && dnf install -y sudo

RUN bash /tmp/build/setup-user.sh "${USERNAME}" "${PATH}"
RUN bash /tmp/build/setup.sh

USER codespace
