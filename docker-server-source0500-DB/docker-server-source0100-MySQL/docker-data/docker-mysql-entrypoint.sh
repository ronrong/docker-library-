#!/bin/bash

DATA_HOME="/var/lib/mysql"
LOG_HOME="/var/log/mysql"
RUN_HOME="/var/run/mysqld"

SYSTEM_UID=${MYSQL_UID:-"1000"}
SYSTEM_UID_TYPE=$( [ ${MYSQL_UID} ] && echo "preset" || echo "default" )

echo "==> Updating MySQL system user's ID to ${SYSTEM_UID} (${SYSTEM_UID_TYPE})"
usermod -u ${SYSTEM_UID} mysql > /dev/null 2>&1

echo "==> Updating ownership of data directory (${DATA_HOME})"
mkdir -p "${DATA_HOME}"
chown -R mysql "${DATA_HOME}"

echo "==> Updating ownership of log directory (${LOG_HOME})"
mkdir -p "${LOG_HOME}"
chown -R mysql "${LOG_HOME}"

echo "==> Updating ownership of run directory (${RUN_HOME})"
mkdir -p "${RUN_HOME}"
chown -R mysql "${RUN_HOME}"

mkdir -p /data/mysql/data
chown -R mysql  /data/mysql/data

if [[ ! -d "${DATA_HOME}/mysql" ]]; then
    echo "==> An empty or uninitialized MySQL installation is detected in '${DATA_HOME}'"
    echo "==> Installing MySQL data..."
   # mysql_install_db > /dev/null 2>&1
   # mysql_install_db --user=mysql --datadir=/data/mysql/data
   mysqld --initialize-insecure --user=mysql --datadir=${DATA_HOME}
        
        #--initialize-insecure
        #--defaults-file=/data/mysql/mysql/etc/my.cnf
        #--basedir=/usr \

    echo "==> Done!"

    # mysqld_safe脚本会在启动MySQL服务器后继续监控其运行情况，并在其死机时重新启动它
    /usr/bin/mysqld_safe > /dev/null 2>&1 &

    RET=1
    COUNT=1
    while [[ RET -ne 0 ]]; do
        echo "==> Waiting for confirmation of MySQL service startup... ${COUNT} times use $[COUNT * 2] seconds" 
        ((COUNT++))
        sleep 2
        mysql -uroot -e "status" > /dev/null 2>&1
        # 代表上一个命令执行是否成功的标志，如果执行成功则$? 为0，否则不为0
        RET=$?
    done

    # 设置用户名
    USER=${MYSQL_USER:-"admin"}
    # 设置密码
    # PASS=${MYSQL_PASS:-$(pwgen -s 12 1)}
    PASS=${MYSQL_PASS:-"ronrong.com"}
    # 密码类型：预设密码 或者 随机（这里是是预设）
    PASS_TYPE=$( [ ${MYSQL_PASS} ] && echo "preset" || echo "random" )

    echo "==> Creating MySQL user with username ${USER}"
    echo "==> Updating MySQL user '${USER}' with ${PASS_TYPE} password"

    # 设置用户名和密码；授权
    mysql -uroot -e "CREATE USER '${USER}'@'%' IDENTIFIED BY '${PASS}'"
    mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '${USER}'@'%' WITH GRANT OPTION"
    mysql -uroot -e "FLUSH PRIVILEGES"

    echo "==> Done!"
    # 创建数据库
    if [[ ! -z "${MYSQL_DATABASE}" ]]; then
        echo "==> Creating database '${MYSQL_DATABASE}'"
        mysql -uroot -e "CREATE DATABASE ${MYSQL_DATABASE} CHARACTER SET utf8"
        echo "==> Done!"
    fi

    echo "========================================================================"
    echo "You can now connect to this MySQL Server using:"
    echo ""
    echo "    mysql -u${USER} -p${PASS} -h<host> -P<port>"
    echo ""
    echo "MySQL user 'root' has no password but only allows local connections"
    echo "========================================================================"

    mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'ronrong.com'"
    echo "※※※MySQL user 'root' password is ronrong.com ※※※"

    mysqladmin -uroot shutdown
else
    echo "==> Using an existing volume of MySQL"
fi

echo "==> Running CMD"
exec "$@"
