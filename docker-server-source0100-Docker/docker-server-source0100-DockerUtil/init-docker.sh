#! /bin/bash

# 安装docker

curl -fsSL https://get.docker.com/ | sudo sh

#使用阿里的加速器

# 登录【管理控制台】-》【产品与服务】
#             |---【容器服务】              
#				 |---镜像与模板
#			        |---镜像--》镜像仓库控制台-》加速地址：https://1s43g3lj.mirror.aliyuncs.com 【 https://cr.console.aliyun.com/?spm=5176.2020520152.209.d103.jDXnSW#/accelerator 】 
# 使用Docker加速器
sudo echo 'DOCKER_OPTS="$DOCKER_OPTS --registry-mirror=https://1s43g3lj.mirror.aliyuncs.com"' >> /etc/default/docker


# ## ### ##### ######## #############
# docker@boot2docker中，可以在docker-machine中执行下两行
# ## ### ##### ######## #############
#$> docker-machine ssh default "echo 'EXTRA_ARGS=\"--registry-mirror=https://1s43g3lj.mirror.aliyuncs.com\"' | sudo tee -a /var/lib/boot2docker/profile"
#$> docker-machine restart default