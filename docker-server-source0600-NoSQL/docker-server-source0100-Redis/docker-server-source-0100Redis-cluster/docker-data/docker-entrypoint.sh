#!/bin/sh

if [ "$1" = 'redis-cluster' ]; then
    # 创建集群需要的目录（一个配置，一个数据）
    for port in `seq 7000 7007`; do
      mkdir -p /data/redis/redis-conf/${port}
      mkdir -p /data/redis/redis-data/${port}
    # 如果数据位置存在nodes，则删除
      if [ -e /data/redis/redis-data/${port}/nodes.conf ]; then
        rm /data/redis/redis-data/${port}/nodes.conf
      fi
    done
    # 集群模式：6个节点，3主，3从。
    for port in `seq 7000 7005`; do
      # 替换PORT字符串，使用配置模板
      PORT=${port} envsubst < /data/redis/redis-conf/redis-cluster.tmpl > /data/redis/redis-conf/${port}/redis.conf
    done
    # 两个单独实例，与集群无关（可以模拟增加和删除节点）
    for port in `seq 7006 7007`; do
      PORT=${port} envsubst < /data/redis/redis-conf/redis.tmpl > /data/redis/redis-conf/${port}/redis.conf
    done
    # 启动supervisor
    supervisord -c /etc/supervisor/supervisord.conf
    sleep 3

    IP=`ifconfig | grep "inet addr:17" | cut -f2 -d ":" | cut -f1 -d " "`
    # 执行redis的创建集群命令创建集群
    echo "yes" | ruby /data/redis/redis-src/src/redis-trib.rb create --replicas 1 ${IP}:7000 ${IP}:7001 ${IP}:7002 ${IP}:7003 ${IP}:7004 ${IP}:7005
    tail -f /var/log/supervisor/redis*.log
else
  exec "$@"
fi
