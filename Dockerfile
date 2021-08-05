FROM tomcat:9.0.43-jdk8-openjdk-buster
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install libc6-i386 libgcc1 libstdc++6 libxrender1:i386 libxtst6:i386 libxi6:i386 wait-for-it

RUN mkdir /DocmanagerInstaller
COPY docmanager-installer-6.X.Y.jar /DocmanagerInstaller
WORKDIR /DocmanagerInstaller
RUN java -jar docmanager-installer-6.X.Y.jar -install -console -silentmode -solution'/usr/local/docpath/docmanagerarpack6/service' -solname'DocPath DocManager AR Service' \
 -adminusername'admin' -adminpassword'admin' -licserverpath'/usr/local/docpath/licenseserver' -licserverport1765 \
 -databasecheckconnectionfalse \
 -aimurl'' -aimtoken'' 
WORKDIR /
RUN rm -rf /usr/local/docpath/docmanagerarpack6/service/logs/dpdocarsrv.log /DocmanagerInstaller

COPY licenseserver.ini /usr/local/docpath/licenseserver/licenseserver/Configuration/
COPY DocPath_License_File.olc /usr/local/docpath/Licenses/

COPY dpdocarsrv.ini /usr/local/docpath/docmanagerarpack6/service/configuration/

RUN cp /usr/local/docpath/docmanagerarpack6/service/web/dpdocarwebtool.war /usr/local/tomcat/webapps/dpdocarwebtool.war

EXPOSE 1785
EXPOSE 17300
EXPOSE 8080

COPY run.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/run.sh /usr/local/docpath/docmanagerarpack6/service/*.sh

WORKDIR /usr/local/docpath

ENTRYPOINT ["/usr/local/bin/run.sh"]

