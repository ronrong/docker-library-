# docker-ubuntu-redis3.2.8

==============================================


### 0100. 构建镜像

```
$> sudo docker build -t ronrong/redis-3.2.8:0.01 . 
```

### 0200. 运行容器

```
$> sudo docker run -i -t --rm -p 6379:6379 ronrong/redis-3.2.8:0.01
```

### 0300. redis集群
参考 ./docker-server-source-0100Redis-cluster/README.md