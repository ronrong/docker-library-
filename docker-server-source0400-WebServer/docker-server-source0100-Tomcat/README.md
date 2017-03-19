# docker-ubuntu-jdk8-tomcat8

==============================================


### 0100. 构建镜像

```
$> sudo docker build -t ronrong/tomcat8-jdk8:0.02 . 
```



### 0200. 运行容器

```
$> sudo docker run --name tomcat8-001 -i -t --rm -p 8080:8080 ronrong/tomcat8-jdk8:0.02
```
或者挂载一个卷

```
$> sudo docker run -it -v /data/webserver/tomcat/webapps/:/data/webserver/tomcat/webapps/  -p 8080:8080 ronrong/tomcat8-jdk8:0.02
```

### 0300. 浏览器

```
http://localhost:8080
```

### 0400. 测试
```
$> curl -i localhost:8080
```

### 0500. 停止容器

找到容器
```
$> sudo docker ps

CONTAINER ID     IMAGE                        COMMAND             ..........
afa8add972de    ronrong/tomcat8-jdk8:0.02   "catalina.sh run"     ..........

```

停止容器
```
$> sudo docker stop <container Id>
```

### 0600. 登录容器
```
$> sudo docker exec -it tomcat8-002 /bin/bash
```

### 0700. 上传war包
参考 ./webapp/README.md