FROM ronrong/ubuntu-java-jdk8_8.121.13:0.01

MAINTAINER ronrong <shaolinrong@hotmail.com>
# 
ENV WEB_SERVER_HOME=/data/webserver \
    TOMCAT_MAJOR=8 \
    TOMCAT_VERSION=8.0.39 \
    CATALINA_HOME=/data/webserver/tomcat
#     
ENV PATH $CATALINA_HOME/bin:$PATH

RUN mkdir -p $WEB_SERVER_HOME

RUN curl -L -O http://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && gunzip apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && tar -xf apache-tomcat-$TOMCAT_VERSION.tar -C $WEB_SERVER_HOME \
    && rm $WEB_SERVER_HOME/apache-tomcat-$TOMCAT_VERSION/bin/*.bat \
    && mv $WEB_SERVER_HOME/apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME \
    && rm apache-tomcat-$TOMCAT_VERSION.tar

#  用户名admin， 密码 admin
ADD tomcat-users.xml $CATALINA_HOME/conf/
# ADD tomcatd.conf /etc/supervisor/conf.d/

VOLUME "$CATALINA_HOME/webapps"
WORKDIR $CATALINA_HOME

EXPOSE 8080
EXPOSE 8009
# CMD ["exec", "java", "-Djava.util.logging.config.file=$CATALINA_HOME/conf/logging.properties", "-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager", "-Djava.endorsed.dirs=$CATALINA_HOME/endorsed", "-classpath $CATALINA_HOME/bin/bootstrap.jar:$CATALINA_HOME/bin/tomcat-juli.jar", "-Dcatalina.base=$CATALINA_HOME", "-Dcatalina.WEB_SERVER_HOME=$CATALINA_HOME", "-Djava.io.tmpdir=$CATALINA_HOME/temp", "org.apache.catalina.startup.Bootstrap", "start"]
CMD ["catalina.sh", "run"]

# docker build -t ronrong/tomcat8-jdk8:0.01 . 