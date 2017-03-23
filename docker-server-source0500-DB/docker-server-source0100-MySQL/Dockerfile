# see https://github.com/SeerUK/docker-mysql/tree/a88aa7f8a12b42a23eba9b984178a1ed9be3c69b
FROM ronrong/ubuntu:0.03

MAINTAINER ronrong <shaolinrong@hotmail.com>

ENV MYSQL_UID 1000
ENV MYSQL_DATABASE docker
ENV MYSQL_USER docker
ENV MYSQL_PASS docker
ENV TERM dumb

ENV MYSQL_VERSION 5.7
ENV WORK_HOME /data/mysql

# Install DB
RUN \
    useradd -u 1000 -m -s /bin/bash mysql \
    && apt-get update \
    # 使用echo命令，自动设置mysql root密码【http://www.oschina.net/question/779869_163499、
    # http://stackoverflow.com/questions/7739645/install-mysql-on-ubuntu-without-password-prompt】
    #&& { \
    #    echo "mysql-server-${MYSQL_VERSION} mysql-server/root_password password unused"; \
    #    echo "mysql-server-${MYSQL_VERSION} mysql-server/root_password_again password unused"; \
    #} | debconf-set-selections \
    && apt-get install -y \
        mysql-server-${MYSQL_VERSION} \
        # pwgen生成密码[http://www.jb51.net/LINUXjishu/397841.html]
        # pwgen && \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mysql \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql: /var/lib/mysql \
    && mkdir -p ${WORK_HOME} \
    && chown -R mysql: ${WORK_HOME}

COPY ./docker-data/my-default.cnf /etc/mysql/my.cnf

COPY ./docker-data/docker-mysql-entrypoint.sh ${WORK_HOME}/docker-mysql-entrypoint.sh
RUN chmod -R 755 ${WORK_HOME}/docker-mysql-entrypoint.sh

# 配置数据库
#RUN \
  # 注释掉一些有问题的配置值
#  sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf \
  # 绑定地址，任何ip都能访问
  # echo "#bind-address = 127.0.0.1" |  \
  # sed -e 's/#bind-address\s\+=\s\+127.0.0.1/bind-address=0.0.0.0/g' ==》bind-address=0.0.0.0
#  && sed -Ei 's/#bind-address\s+=\s+127.0.0.1/bind-address=0.0.0.0/g' /etc/mysql/my.cnf

VOLUME /var/lib/mysql
WORKDIR ${WORK_HOME}

EXPOSE 3306

ENTRYPOINT ["/data/mysql/docker-mysql-entrypoint.sh"]
CMD ["mysqld"]
