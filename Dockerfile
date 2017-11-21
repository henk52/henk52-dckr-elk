FROM fedora:25
MAINTAINER Henry K

RUN mkdir /vagrant

# COPY <src> ... <dst>
COPY filebeat* /vagrant/
RUN rpm -ivh /vagrant/filebeat*.rpm
RUN rm /vagrant/filebeat*.rpm

# CMD
