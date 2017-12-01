

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


#### i/o timeout
Fix:
  Add the followin intries to /etc/filebeat/filebeat.yml:
```
output.logstash:
  hosts: ["localhost:5044"]
  timeout: 300
  slowstart: true
```


2017/11/30 23:48:00.020351 metrics.go:39: INFO Non-zero metrics in the last 30s: beat.memstats.gc_next=11581360 beat.memstats.memory_alloc=8156616 beat.memstats.memory_total=70374904 filebeat.harvester.open_files=1 filebeat.harvester.running=1 libbeat.config.module.running=0 libbeat.output.events.batches=3 libbeat.output.events.failed=6144 libbeat.output.events.total=6144 libbeat.output.read.errors=1 libbeat.output.write.bytes=144610 libbeat.pipeline.clients=1 libbeat.pipeline.events.active=4117 libbeat.pipeline.events.retry=8192 registrar.states.current=1
2017/11/30 23:48:11.046681 async.go:235: ERR Failed to publish events caused by: read tcp [::1]:60398->[::1]:5044: i/o timeout
2017/11/30 23:48:11.047075 async.go:235: ERR Failed to publish events caused by: read tcp [::1]:60398->[::1]:5044: i/o timeout
2017/11/30 23:48:11.076381 async.go:235: ERR Failed to publish events caused by: client is not connected
2017/11/30 23:48:12.077513 output.go:92: ERR Failed to publish events: client is not connected


#### write: connection reset by peer
Possibly because the veat plugin in logstash needs to have the idle timeout set to the same timeout as the filebeat configuration has.
Update: logstash.conf

input {
  beats {
    port => 5044
    # Try to avoid filebeat timout increase from default 60.
    client_inactivity_timeout => 300
  }
}


```
2017/12/01 00:18:56.285123 metrics.go:39: INFO Non-zero metrics in the last 30s: beat.memstats.gc_next=6839984 beat.memstats.memory_alloc=3861560 beat.memstats.memory_total=25603856 filebeat.harvester.open_files=1 filebeat.harvester.running=1 libbeat.config.module.running=0 libbeat.pipeline.clients=1 libbeat.pipeline.events.active=4117 registrar.states.current=1
2017/12/01 00:18:58.253383 async.go:235: ERR Failed to publish events caused by: write tcp 127.0.0.1:52414->127.0.0.1:5044: write: connection reset by peer
2017/12/01 00:18:59.253543 output.go:92: ERR Failed to publish events: write tcp 127.0.0.1:52414->127.0.0.1:5044: write: connection reset by peer
```


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


### elasticsearch

#### bound or publishing to a non-loopback or non-link-local address, enforcing bootstrap checks
See: https://github.com/elastic/elasticsearch/issues/19987

add to: elasticsearch.yml
```
transport.host: localhost
network.host: 0.0.0.0
```

log output stdout; /var/log/supervisor_child/elasticsearch-stdout---supervisor-_alqa0.log
```
] publish_address {172.17.0.4:9300}, bound_addresses {[::]:9300}
[2017-11-24T08:24:38,757][INFO ][o.e.b.BootstrapChecks    ] [e8ZWX47] bound or publishing to a non-loopback or non-link-local address, enforcing bootstrap checks
ERROR: [1] bootstrap checks failed
[1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
```

### kibana

#### In order to use Kibana you must configure at least one index pattern.

https://discuss.elastic.co/t/new-kibana-installation-lacking-default-index-pattern/78003/8

Seems you need data first?

