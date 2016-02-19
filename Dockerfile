FROM finntech/openjdk8bond

MAINTAINER christopher.kolstad@finn.no

EXPOSE 8080

ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_VERSION 8.0.30
ENV DEPLOY_DIR /maven

RUN curl http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -o /tmp/catalina.tar.gz \
  && tar xzf /tmp/catalina.tar.gz -C /opt \
  && ln -s /opt/apache/tomcat-${TOMCAT_VERSION} /opt/tomcat \
  && rm /tmp/catalina.tar.gz

  ADD tomcat-users.xml /opt/apache-tomcat-${TOMCAT_VERSION}/conf/

  ADD deploy-and-run.sh /opt/apache-tomcat-${TOMCAT_VERSION}/bin/

  RUN chmod 755 /opt/apache-tomcat-${TOMCAT_VERSION}/bin/deploy-and-run.sh \
    && rm -rf /opt/tomcat/webapps/examples /opt/tomcat/webapps/docs

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

CMD /opt/tomcat/bin/deploy-and-run.sh
