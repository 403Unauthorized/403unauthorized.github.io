---
title: "Kubernetes 命令以及容器中JVM操作"
tags:
  - Kubernetes
  - JVM
---

## Basic Commands

```shell
# List All Pods
kubectl -n <namespace> get pods

# List All Services
kubectl -n <namespace> get services

# Log in to pod
kubectl -n <namespace> exec -it <pod-name> -c <container-name> -- sh

# Updating...

```

## JVM Operaions

### Heap Dump

```shell
# 获取Java进程的PID
ps -ef  | grep java

# Output
#     8 root      1h31 java -Djava.security.egd=file:/dev/./urandom -Dcom.sun.management.jmxremote.rmi.port=5000 -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port=5000 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.local.only=false -Djava.rmi.server.hostname=localhost -Xms4g -Xmx4g -Xss512k -XX:+UseG1GC -Xlog:gc*:/ecsg-rsn-bff/gc.log:time,tags:filesize=2048k -jar ./app.jar --spring.profiles.active=perf
# PID 就是8

# 获取heapdump
# jcmd <pid> GC.heap_dump -all <file name>
jcm 8 GC.heap_dump -all heap.hprof
```

从K8S的pod中把heapdump文件复制出来：

```shell
# kubectl cp <namespace>/<pod_name>:<path_to_file> <local_file_location>
kubectl cp ecsg-rsn-bff/rsn-bff-perf-pre-8c7554f5c-4hklv:/ecsg-rsn-bff/heap.hprof /Users/torres.lei/Documents/ECSG/RSN/heap-20220121-1800.hprof
```

## File Descriptor

打开的File Descriptor数量：

```shell
lsof -u root | wc -l
```

查看PID实际的File Descriptor：

```shell
# lsof - p <PID> | wc -l
lsof - p 8 | wc -l
```
