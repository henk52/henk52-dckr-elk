FROM fedora:25
MAINTAINER Henry K

# expose the kibana port.
EXPOSE 5601/tcp
# expose the elasticsearch port.
EXPOSE 9200/tcp

# https://github.com/Krijger/docker-cookbooks/blob/master/supervisor/Dockerfile
# supervisor installation &&
# create directory for child images to store configuration in
RUN dnf install -y supervisor && \
  mkdir -p /var/log/supervisor && \
  mkdir -p /etc/supervisor/conf.d

# supervisor base configuration
ADD supervisor.conf /etc/supervisor.conf
ADD elk_stack.d.conf /etc/supervisor/conf.d/

RUN mkdir /vagrant

COPY filebeat.yml /etc/filebeat/filebeat.yml
#ADD filebeat.yml /etc/filebeat/filebeat.yml

# COPY <src> ... <dst>
COPY filebeat*.rpm /vagrant/
RUN rpm -ivh /vagrant/filebeat*.rpm &&\
  rm /vagrant/filebeat*.rpm &&\
  chmod g-w /etc/filebeat/filebeat.yml



# Install Elastisearch
COPY elasticsearch*.rpm /vagrant/
COPY elasticsearch.yml /etc/elasticsearch/
# required by elasticsearch.
RUN dnf install -y java-1.8.0-openjdk-headless &&\
  rpm -ivh /vagrant/elasticsearch*.rpm &&\
  chown -R elasticsearch /etc/sysconfig/elasticsearch &&\
  chown -R elasticsearch /var/log/elasticsearch &&\
  mkdir /var/lib/elasticsearch/nodes &&\
  chown -R elasticsearch /var/lib/elasticsearch &&\
  rm /vagrant/elasticsearch*.rpm



# Install logstash
COPY logstash.conf /etc/logstash/conf.d/
COPY logstash* /vagrant/
RUN rpm -ivh /vagrant/logstash*.rpm &&\
   rm /vagrant/logstash*.rpm


# Install Kibana
COPY kibana.yml /etc/kibana/
COPY kibana*.rpm /vagrant/
RUN rpm -ivh /vagrant/kibana*.rpm &&\
  rm /vagrant/kibana*.rpm


# For this configuration, you must load the index template into Elasticsearch manually because the options for auto loading the template are only available for the Elasticsearch output.
# src: https://www.elastic.co/guide/en/beats/filebeat/current/config-filebeat-logstash.html



#  To load the dashboards for filebeat into Kibana, run:
#    ./filebeat setup -e

# start filebeat with:
#   ./filebeat -c filebeat.yml -e



# A container’s main running process is the ENTRYPOINT and/or CMD at the end of the Dockerfile
# https://docs.docker.com/engine/admin/multi-service_container/

# Functionally, ENTRYPOINT is akin to the CMD instruction, but the major difference between the two is that the entry point
#   application is launched using the ENTRYPOINT instruction, which cannot be overridden
#   using the docker run subcommand arguments.

# /usr/bin/supervisord
# default command
# /usr/bin/supervisord -c /etc/supervisor.conf

CMD ["supervisord", "-c", "/etc/supervisor.conf"]
