# Warning 警告：删除所有的镜像！！！！ 谨慎执行
docker rmi `docker images|awk -v ORS=" " '$1=="<none>" {print $3}'`
