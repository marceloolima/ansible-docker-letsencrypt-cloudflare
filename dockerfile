FROM alpine:3.12

RUN apk --update --no-cache add \
      ca-certificates \
      git \
      openssh-client \
      openssl \
      python3\
      py3-pip \
      py3-cryptography \
      rsync \
      sshpass

RUN apk --update add --virtual \
      .build-deps \
      python3-dev \
      libffi-dev \
      openssl-dev \
      build-base \
      curl \
   && pip3 install --upgrade \
      pip \
      cffi \
   && pip3 install \
      ansible \
      ansible-lint \
   && apk del \
      .build-deps \
   && rm -rf /var/cache/apk/*

COPY /playbooks /playbooks-container

ADD ./entrypoint.sh /

WORKDIR /playbooks-container

ENTRYPOINT [ "/bin/sh", "/entrypoint.sh" ]
