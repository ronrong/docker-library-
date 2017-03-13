FROM ronrong/ubuntu:0.02

MAINTAINER ronrong <shaolinrong@hotmail.com>
# add user and group 
RUN groupadd -r redis && useradd -r -g redis redis


ENV REDIS_VERSION 3.2.8
ENV REDIS_SRC_HOME /data/redis/redis-src
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.2.8.tar.gz
ENV REDIS_DOWNLOAD_SHA1 6780d1abb66f33a97aad0edbe020403d0a15b67f
# # Ensure UTF-8 lang and locale
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

RUN mkdir -p /data/redis/redis-conf \
&& mkdir  -p /data/redis/redis-data \
&& chown  -R redis:redis /data/redis

# 安装以下软件包gcc、wget！！、libc6-dev【基础开发库】、make
RUN set -ex \
	\
	# ruby:执行的ruby的脚本，需要ruby的环境
	# rubygems:rubygems组件
    # Supervisor:Supervisor是一个进程管理工具。用途就是有一个进程需要每时每刻不断的跑，但是这个进程又有可能由于各种原因有可能中断。当进程中断的时候我希望能自动重新启动它，此时，我就需要使用到了Supervisor
	&& buildDeps=' \
	ruby    \
    rubygems \
    net-tools \
    supervisor \
    locales     \
    gettext-base \
    ' \
	# 下载软件和环境
	&& apt-get update \
	&& apt-get install -y $buildDeps --no-install-recommends \

	# 下载reids
	&& wget "$REDIS_DOWNLOAD_URL" -O redis.tar.gz  \
	&& echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
	&& mkdir -p ${REDIS_SRC_HOME} \
	&& tar -xzf redis.tar.gz -C ${REDIS_SRC_HOME} --strip-components=1 \
	&& rm redis.tar.gz \
	\
	&& make -C ${REDIS_SRC_HOME} \
	&& make -C ${REDIS_SRC_HOME} install \
	# 安装redis和ruby的接口
	&& gem install redis 
	# \
	# && rm -r ${REDIS_SRC_HOME} 
	# 清除安装软件
	#&& rm -rf /var/lib/apt/lists/* \
	#\
	# package 删除包及其依赖的软件包+配置文件等
	#&& apt-get purge -y --auto-remove $buildDeps

RUN locale-gen en_US.UTF-8

# VOLUME /data
# WORKDIR /data

# 配置文件
COPY ./docker-data/redis-cluster.tmpl /data/redis/redis-conf/redis-cluster.tmpl
COPY ./docker-data/redis.tmpl /data/redis/redis-conf/redis.tmpl

# 进程管理配置
COPY ./docker-data/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 启动脚本
COPY ./docker-data/docker-entrypoint.sh /data/redis/docker-entrypoint.sh
RUN chmod -R 755 /data/redis/docker-entrypoint.sh

EXPOSE 7000 7001 7002 7003 7004 7005 7006 7007

ENTRYPOINT ["/data/redis/docker-entrypoint.sh"]
CMD ["redis-cluster"]
