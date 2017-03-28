# Warning 警告：删除所有的容器！！！！ 谨慎执行
docker rm -f `docker ps -a|awk -v ORS=" " '{print $1}'`
