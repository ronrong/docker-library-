FROM ronrong/ubuntu:0.02

MAINTAINER ronrong <shaolinrong@hotmail.com>
# add user and group 
RUN groupadd -r redis && useradd -r -g redis redis


ENV REDIS_VERSION 3.2.8
ENV REDIS_SRC_HOME /usr/src/redis-${REDIS_VERSION}
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.2.8.tar.gz
ENV REDIS_DOWNLOAD_SHA1 6780d1abb66f33a97aad0edbe020403d0a15b67f


# for redis-sentinel see: http://redis.io/topics/sentinel
# 安装以下功能gcc、wget！！、libc6-dev、make
RUN set -ex \

	&& wget "$REDIS_DOWNLOAD_URL" -O redis.tar.gz  \
	&& echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
	&& mkdir -p ${REDIS_SRC_HOME} \
	&& tar -xzf redis.tar.gz -C ${REDIS_SRC_HOME} --strip-components=1 \
	&& rm redis.tar.gz \
	\
# Disable Redis protected mode [1] as it is unnecessary in context
# of Docker. Ports are not automatically exposed when running inside
# Docker, but rather explicitely by specifying -p / -P.
# [1] https://github.com/antirez/redis/commit/edd4d555df57dc84265fdfb4ef59a4678832f6da
	&& grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' ${REDIS_SRC_HOME}/src/server.h \
	&& sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' ${REDIS_SRC_HOME}/src/server.h \
	&& grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' ${REDIS_SRC_HOME}/src/server.h \
# for future reference, we modify this directly in the source instead of just supplying a default configuration flag because apparently "if you specify any argument to redis-server, [it assumes] you are going to specify everything"
# see also https://github.com/docker-library/redis/issues/4#issuecomment-50780840
# (more exactly, this makes sure the default behavior of "save on SIGTERM" stays functional by default)
	\
	&& make -C ${REDIS_SRC_HOME} \
	&& make -C ${REDIS_SRC_HOME} install \
	&& mkdir -p /etc/redis \
	# conf
	&& cp -f ${REDIS_SRC_HOME}/*.conf /etc/redis \
	# 注释掉bind，不绑定任何ip，任何ip都能访问
	# 测试： echo "bind 127.0.0.1" | sed -e 's/^\(bind .*\)$/# \1/' ==># bind 127.0.0.1
	&& sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf \
	# 注释掉daemoniz。，默认情况下 redis 不是作为守护进程运行的，如果你想让它在后台运行，你就把它改成 yes
	# 测试： echo "daemonize no" | sed -e 's/^\(daemonize .*\)$/# \1/' ==># daemonize no
	&& sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf \
	# 数据库备份的文件放置的路径
	# 测试： echo "dir ./" | sed -e 's/^\(dir .*\)$/# \1\ndir \/data/' ==># dir /data
	&& sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf \
	# 配置 log 文件地址,默认打印在命令行终端的窗口上，也可设为/dev/null屏蔽日志
	# 测试： echo "logfile """ | sed -e 's/^\(logfile .*\)$/# \1/' ==># logfile
	&& sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf \
	# 关闭保护模式，所有主机都可以访问
	# 测试：  echo "protected-mode yes" | sed -e 's/^\(protected-mode yes\)$/protected-mode no/' ==># protected-mode no
	&& sed -i 's/^\(protected-mode yes\)$/protected-mode no/' /etc/redis/redis.conf \
	\
	&& rm -r ${REDIS_SRC_HOME} 

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

# 启动参数
CMD ["redis-server", "/etc/redis/redis.conf"]

EXPOSE 6379

#######################################################

