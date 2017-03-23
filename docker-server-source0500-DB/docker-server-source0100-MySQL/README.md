# docker-ubuntu-mysql5.7

==============================================


### 0100. 构建镜像

```
$> sudo docker build -t ronrong/mysql-5.7:1.00 .
```



### 0200. 运行容器

```
$> docker run --name mysql001 -i -t -p 3306:3306 ronrong/mysql5.7:1.00 
```

或者挂载一个卷

```
$> sudo docker run -it /data/mysql/data/:/var/lib/mysql -p 3306:3306 ronrong/mysql5.7:1.00 
```

log
```

==> Updating MySQL system user's ID to 1000 (preset)
==> Updating ownership of data directory (/var/lib/mysql)
==> Updating ownership of log directory (/var/log/mysql)
==> Updating ownership of run directory (/var/run/mysqld)
==> An empty or uninitialized MySQL installation is detected in '/var/lib/mysql'
==> Installing MySQL data...
==> Done!
==> Waiting for confirmation of MySQL service startup... 1 times use 2 seconds
==> Creating MySQL user with username docker
==> Updating MySQL user 'docker' with preset password
==> Done!
==> Creating database 'docker'
==> Done!
========================================================================
You can now connect to this MySQL Server using:

    mysql -udocker -pdocker -h<host> -P<port>

MySQL user 'root' has no password but only allows local connections
========================================================================
※※※MySQL user 'root' password is ronrong.com ※※※
mysqladmin: connect to server at 'localhost' failed
error: 'Access denied for user 'root'@'localhost' (using password: NO)'
==> Running CMD
```


### 0400. 测试
```
$> docker exec -it mysql001 /bin/bash
root@bcf57d9c70fa:/data/mysql# mysql -udocker -pdocker -hlocalhost -P3306
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 5
Server version: 5.7.17-0ubuntu0.16.04.1 (Ubuntu)

Copyright (c) 2000, 2016, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| docker             |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

mysql> 
```
