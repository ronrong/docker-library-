# What
Nginx + Tomcat 负载均衡。 基于 Docker Compose，你可以同时控制多个相关联的 Docker 容器。

# Why
组合之前单个容器，使他们能够共同工作。

# How
##（1）安装docker-compose，如果没有的话【https://github.com/docker/compose/releases】
##（2）容器操作
1-启动容器
docker-compose up
后台运行
docker-compose up -d

2-查看容器
```
docker-compose命令都要在xxx.yml目录下执行
$> docker-server-source0100-Compose-Nginx-Tomcat-MySQL$ docker-compose ps
      Name                    Command               State                Ports               
--------------------------------------------------------------------------------------------
server-nginx001    /usr/bin/supervisord -n -c ...   Up      443/tcp, 0.0.0.0:4880->80/tcp    
server-tomcat001   catalina.sh run                  Up      8009/tcp, 0.0.0.0:4801->8080/tcp 
server-tomcat002   catalina.sh run                  Up      8009/tcp, 0.0.0.0:4802->8080/tcp 
```

```
$> docker ps
CONTAINER ID        IMAGE                       COMMAND                  CREATED             STATUS              PORTS                              NAMES
20f4d355485d        ronrong/nginx1.10:0.03      "/usr/bin/supervis..."   12 minutes ago      Up 12 minutes       443/tcp, 0.0.0.0:4880->80/tcp      server-nginx001
61fd0e120b0a        ronrong/tomcat8-jdk8:0.02   "catalina.sh run"        12 minutes ago      Up 12 minutes       8009/tcp, 0.0.0.0:4801->8080/tcp   server-tomcat001
647f248a4bdd        ronrong/tomcat8-jdk8:0.02   "catalina.sh run"        12 minutes ago      Up 12 minutes       8009/tcp, 0.0.0.0:4802->8080/tcp   server-tomcat002
```
3-停止容器
docker-compose stop


其他命令

```
Usage:
  docker-compose [-f <arg>...] [options] [COMMAND] [ARGS...]
  docker-compose -h|--help

Options:
  -f, --file FILE             Specify an alternate compose file (default: docker-compose.yml)
  -p, --project-name NAME     Specify an alternate project name (default: directory name)
  --verbose                   Show more output
  -v, --version               Print version and exit
  -H, --host HOST             Daemon socket to connect to

  --tls                       Use TLS; implied by --tlsverify
  --tlscacert CA_PATH         Trust certs signed only by this CA
  --tlscert CLIENT_CERT_PATH  Path to TLS certificate file
  --tlskey TLS_KEY_PATH       Path to TLS key file
  --tlsverify                 Use TLS and verify the remote
  --skip-hostname-check       Don't check the daemon's hostname against the name specified
                              in the client certificate (for example if your docker host
                              is an IP address)

Commands:
  build              Build or rebuild services
  bundle             Generate a Docker bundle from the Compose file
  config             Validate and view the compose file
  create             Create services
  down               Stop and remove containers, networks, images, and volumes
  events             Receive real time events from containers
  exec               Execute a command in a running container
  help               Get help on a command
  kill               Kill containers
  logs               View output from containers
  pause              Pause services
  port               Print the public port for a port binding
  ps                 List containers
  pull               Pull service images
  push               Push service images
  restart            Restart services
  rm                 Remove stopped containers
  run                Run a one-off command
  scale              Set number of containers for a service
  start              Start services
  stop               Stop services
  top                Display the running processes
  unpause            Unpause services
  up                 Create and start containers

```

##（3）使用
访问tomcat001
http://192.168.99.100:4801/webapp/

访问tomcat002
http://192.168.99.100:4802/webapp/

访问Nginx负载到两个tomcat上
http://192.168.99.100:4880/webapp/


```
session ID : 9DF6A0729B5052998655C069C2CC9686

取得服务器IP ：172.17.0.6:8080

取得客户端的IP ：172.17.0.7:38866

取得客户端的主机名：172.17.0.7

取得客户端的用户 ：null

取得客户端的系统版本：Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0

页面访问量为: 29
```