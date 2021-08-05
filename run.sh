#!/bin/bash

dpinifile='/usr/local/docpath/docmanagerarpack6/service/configuration/dpdocarsrv.ini'
db_host="${DB_HOST-''}"
db_port="${DB_PORT-''}"
db_user="${DB_USER-''}"
db_pass="${DB_PASS-''}"
db_name="${DB_NAME-''}"
db_type="${DB_TYPE-''}"
db_installOrUpdate="${DB_UPDATE-'yes'}"
aim_url="${AIM_URL-''}"
aim_token="${AIM_TOKEN-''}"

echo "TYPE = $db_type" >> "$dpinifile"
echo "SERVER = $db_host" >> "$dpinifile"
echo "PORT = $db_port" >> "$dpinifile"
echo "DATABASE = $db_name" >> "$dpinifile"
echo "LOGIN = $db_user" >> "$dpinifile"
echo "PASSWORD = $db_pass" >> "$dpinifile"
echo "INSTALL OR UPDATE DB AT STARTUP = $db_installOrUpdate" >> "$dpinifile"


echo " " >> "$dpinifile"
echo "[AIM]" >> "$dpinifile"
echo "URL = $aim_url" >> "$dpinifile"
echo "APPLICATION TOKEN = $aim_token" >> "$dpinifile"

echo " " >> "$dpinifile"
echo "[LICENSE]" >> "$dpinifile"
echo "ADDRESS = localhost" >> "$dpinifile"
echo "PORT = 1765" >> "$dpinifile"
    
cd /usr/local/docpath/licenseserver/licenseserver/Bin
./startServer.sh

cd /usr/local/tomcat/bin
./startup.sh

cd /usr/local/docpath/docmanagerarpack6/service
wait-for-it localhost:1765 -t 30 -- java -Xmx2048m -jar dpdocarsrv.war