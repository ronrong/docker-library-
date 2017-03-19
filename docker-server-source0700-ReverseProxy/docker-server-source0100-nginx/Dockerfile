# see https://github.com/oberthur/docker-nginx

FROM ronrong/ubuntu:0.02

MAINTAINER ronrong <shaolinrong@hotmail.com>

ENV NGINX_VERSION=1.10.2
ENV NGINX_HOME /data/nginx

# 更新软件源
COPY ./etc/apt/sources.list  /etc/apt/sources.list

# Prepare image
# 为nginx添加更新源（1）获取nginx_signing的公钥
RUN apt-key adv --fetch-keys http://nginx.org/keys/nginx_signing.key \
# （2）选择更新源 根据命令 sb_release -a 获得Codename为xenial 【http://www.2cto.com/os/201306/216901.html】
    && echo "deb http://nginx.org/packages/ubuntu/ xenial nginx" >> /etc/apt/sources.list.d/nginx.list \
    && apt-get update \
    && apt-get install nginx=${NGINX_VERSION}* supervisor logrotate \   
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    # 转发请求和错误日志到docker日志收集器
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    \
    && mkdir -p $NGINX_HOME/share/errors \
    && mkdir -p $NGINX_HOME/cache/temp \
    && cp -fr /usr/share/nginx/html $NGINX_HOME/share \
    && echo "HTTP ERROR 40x" > $NGINX_HOME/share/errors/40x.html \
    && echo "HTTP ERROR 50x" > $NGINX_HOME/share/errors/50x.html \
    # logrotate 程序是一个日志文件管理工具。用来把旧的日志文件删除，并创建新的日志文件，我们把它叫做“转储”。
    # 我们可以根据日志文件的大小，也可以根据其天数来转储，这个过程一般通过 cron 程序来执
    # http://blog.csdn.net/cjwid/article/details/1690101
    && sed -i "s|/usr/sbin/logrotate /etc/logrotate.conf|/usr/sbin/logrotate -f /etc/logrotate.conf|g" /etc/cron.daily/logrotate \
    && sed -i "s/daily/daily\n        dateext/g" /etc/logrotate.d/nginx \

# Cleanup

    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && rm -fr /tmp/* /var/tmp/*

COPY supervisor.conf /etc/supervisor/conf.d/nginx.conf
# /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443

# SIGQUIT信号被用于接收shell的CTRL-/。按下CTRL +\组合键时，是产生了SIGQUIT信号，发送给所有Foreground Group的进程
# 用来终止一个进程 【bbs.csdn.net/topics/330100297】
STOPSIGNAL SIGQUIT

ENTRYPOINT ["/usr/bin/supervisord","-n","-c","/etc/supervisor/supervisord.conf"]
