# docker-ubuntu-nginx1.10.2

==============================================


### 0100. 构建镜像

```
$> sudo docker build -t ronrong/nginx-1.10:0.01 . 
```

### 0200. 运行容器

```
$> docker --name nginx001 run -it -v `pwd`/docker-data/nginx.conf:/etc/nginx/nginx.conf  -p 80:80 ronrong/nginx-1.10:0.01
```

