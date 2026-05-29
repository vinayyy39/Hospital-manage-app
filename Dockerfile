FROM tomcat:9.0-jdk8

RUN rm -rf /usr/local/tomcat/webapps/*

RUN sed -i 's/port="8005"/port="-1"/' /usr/local/tomcat/conf/server.xml

COPY target/hospital.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD sed -i "s/8080/${PORT}/g" /usr/local/tomcat/conf/server.xml && catalina.sh run