#!/bin/bash

docker run --name docmanager --hostname docmanager -d \
    -p 17300:17300/tcp -p 1785:1785/tcp -p 8080:8080/tcp \
    -e DB_HOST=localhost -e DB_PORT=1433 -e DB_USER=dbuser -e DB_PASS=password' -e DB_NAME=docmanager -e DB_TYPE=SQLServer -e DB_UPDATE=yes \
    -e AIM_URL='http://localhost:8081/aim' -e AIM_TOKEN='$2a$10$dBs1HXPGzy4XE80B8LL65.kVfv08KUyFUXVruiFFyTyqKX1EP48ES' \
    -v /home/docker/DocManager6/DP_DATA:/usr/local/docpath/docmanagerarpack6/service/DP_DATA \
    docpath/docmanager