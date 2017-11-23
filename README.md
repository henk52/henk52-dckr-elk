

* https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.0.0-x86_64.rpm
* https://docs.docker.com/engine/reference/builder/#cmd
* Learning Docker 2ed.
* https://www.elastic.co/downloads/beats/filebeat
* http://supervisord.org/

Generate the image
1. sudo docker build .
1. sudo docker run -i -t  dd0f2c094a02 /bin/bash
1. sudo docker ps --all
1. sudo docker rm 190c34a1a395
1. sudo docker rmi dd0f2c094a02



Test:
  supervisord -c /etc/supervisor.conf


Microservices Architecture (MSA).

* https://stackoverflow.com/questions/33117068/use-of-supervisor-in-docker
* https://docs.docker.com/engine/admin/multi-service_container/
* https://blog.trifork.com/2014/03/11/using-supervisor-with-docker-to-manage-processes-supporting-image-inheritance/

* https://blog.trifork.com/2014/03/11/using-supervisor-with-docker-to-manage-processes-supporting-image-inheritance/
* http://tiborsimko.org/docker-running-multiple-processes.html


## Testing
/usr/bin/filebeat run -N --once -c /etc/filebeat/filebeat.yml

# Troubleshooting

### Filebeat

#### Exiting: Error importing Kibana dashboards: fail to create the Elasticsearch loader: Elasticsearch output is not configured/enabled


### Elasticsearch

####

useradd -m nimitz
   35  chown -r nimitz /etc/sysconfig/elasticsearch
   36  chown -R nimitz /etc/sysconfig/elasticsearch
   39  chown -R nimitz /etc/elasticsearch
   41  chown -R nimitz /var/log/elasticsearch
   43  chown -R nimitz /var/lib/elasticsearch
   47  mkdir /var/lib/elasticsearch/nodes
   48  chown nimitz /var/lib/elasticsearch/nodes
   49  su nimitz



### logstash

#### WARNING: Could not find logstash.yml which is typically located in


WARNING: Could not find logstash.yml which is typically located in $LS_HOME/config or /etc/logstash. You can specify the path using --path.settings. Continuing using the defaults
Could not find log4j2 configuration at path /usr/share/logstash/config/log4j2.properties. Using default config which logs errors to the console
ERROR: Failed to read pipelines yaml file. Location: /usr/share/logstash/config/pipelines.yml
usage:
  bin/logstash -f CONFIG_PATH [-t] [-r] [] [-w COUNT] [-l LOG]
  bin/logstash --modules MODULE_NAME [-M "MODULE_NAME.var.PLUGIN_TYPE.PLUGIN_NAME.VARIABLE_NAME=VALUE"] [-t] [-w COUNT] [-l LOG]
  bin/logstash -e CONFIG_STR [-t] [--log.level fatal|error|warn|info|debug|trace] [-w COUNT] [-l LOG]
  bin/logstash -i SHELL [--log.level fatal|error|warn|info|debug|trace]
  bin/logstash -V [--log.level fatal|error|warn|info|debug|trace]
  bin/logstash --help
