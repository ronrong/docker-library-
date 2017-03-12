FROM sxend/ubuntu:16.04.2

MAINTAINER sxend

ENV REDIS_HOME /opt/redis-3.2.1

RUN \
  cd /opt && \
  curl http://download.redis.io/releases/redis-3.2.1.tar.gz | tar xz && \
  cd ${REDIS_HOME} && \
  make && make install

CMD ["/bin/bash"]