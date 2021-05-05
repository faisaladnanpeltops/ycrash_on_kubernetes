FROM adoptopenjdk:openj9

RUN apt-get -y update
RUN apt-get install -y wget unzip

WORKDIR /opt/workspace/yc
RUN wget -O yc.zip https://tier1app.com/dist/ycrash/yc-latest.zip
RUN unzip yc.zip
RUN wget -O license.lic https://tier1app.com/license/VGltIEphY29i/dGltLmphY29iLmlkQGdtYWlsLmNvbQ==/2021-05-5/license.lic
EXPOSE 8080
RUN chmod +x launch-yc-server.sh
#ENTRYPOINT [ "sh", "-c", "/opt/workspace/yc/launch-yc-server.sh"]
ENTRYPOINT [ "java", "-Dapp=yc", "-DlogDir=.", "-DuploadDir=.", "-jar", "webapp-runner-8.0.33.4.jar", "-AconnectionTimeout=3600000", "--port", "8080", "yc.war"]
#java -Xms2g -Xmx4g -Dapp=yc -DlogDir=. -DuploadDir=. -jar webapp-runner-8.0.33.4.jar -AconnectionTimeout=3600000 --port 8080 yc.war &