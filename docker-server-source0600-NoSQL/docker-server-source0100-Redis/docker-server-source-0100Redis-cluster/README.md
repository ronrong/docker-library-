# docker-ubuntu-redis3.2.8-cluster

==============================================


### 0100. 构建镜像

```
$> sudo docker build -t ronrong/redis-cluster:1.00 . 
```

### 0200. 运行容器

```
$> sudo docker run --name docker-server-redis-cluster-0.01 -i -t -p 7000:7000 -p 7001:7001 -p 7002:7002 -p 7003:7003 -p
 7004:7004 -p 7005:7005 -p 7006:7006 -p 7007:7007 ronrong/redis-cluster:1.00
```

笔记：
wiz://open_document?guid=a609406d-fd50-401a-b456-5f8e17acd068&kbguid=&private_kbguid=51d24f49-c854-4dd0-85ab-f7ace65de92e
