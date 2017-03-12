FROM ubuntu:16.04

MAINTAINER ronrong <shaolinrong@hotmail.com>

# 安装以下软件包gcc、wget！！、libc6-dev【基础开发库】、make
RUN set -ex \
	\
	&& buildDeps=' \
		gcc \
		wget \
		vim \
		libc6-dev \
		make \
		iputils-ping \
	' \
	&& apt-get update \
	&& apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	#\
	# package 删除包及其依赖的软件包+配置文件等
	#&& apt-get purge -y --auto-remove $buildDeps

entrypoint ["/bin/bash"]
