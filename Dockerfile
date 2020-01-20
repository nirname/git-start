FROM ubuntu

RUN apt-get update && apt-get install -y git locales vim pwgen

RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY /dotfiles/* /root/

WORKDIR /projects


