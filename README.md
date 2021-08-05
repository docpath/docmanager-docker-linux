# Docker Configuration Files for DocPath® DocManager AR Pack (v6)

This is a complete example about how to deploy DocPath ® DocManager AR Pack in Linux using Docker. The example must be completed with the following files in the same directory as the repositorized files:

- `docmanager-installer-6.X.Y.jar`: DocPath ® DocManager AR Pack Installer.
- `DocPath License File.olc`: License file.
 
## Steps 
To successfully perform the example, follow the steps as indicated below:
- Use the `tomcat:9.0.43-jdk8-openjdk-buster` image. This is a Linux Debian image with OpenJDK 8 and tomcat 9 pre-installed.
- Install DocPath ® DocManager AR Pack.
- Copy the license file into the image.
- Use port 8080 to access DocPath ® DocManager AR Web Tool.
- Use port 1785 to consume DocPath ® DocManager AR Service endpoints.
- Use port 17300 to connect with DocPath ® DocManager AR Service by socket connection.
- Run the `run.sh` file on the container entrypoint. `run.sh` is performed as follows:
  - Starts the license server to allow DocPath ® DocManager AR Service execution.
  - Deploys DocPath ® DocManager AR Web Service.
  - Deploys DocPath ® DocManager AR Web Tool on tomcat.

## Necessary changes
- Change the `docmanager-installer-6.X.Y.jar` with the corresponding version of DocPath ® DocManager AR.
- Change the `DocPath_License_File.olc` file with the corresponding license filename.

## How to build and deploy
Now we are going to build the container by executing the following sentence in the same directory where the dockerfile file is located:

`docker build -t docpath/docmanager .`

**IMPORTANT!** the full stop at the end indicates the directory where the container is located. This is mandatory.

In the installation, the following values has been taken by default:
- -adminusername**admin**
- -adminpassword**admin**
- -licserverpath **/usr/local/docpath/licenseserver**
- -licserverport**1765**
- -databasecheckconnection**false**

Run the container once it has been built, using the following sentence:

`docker run --name docmanager --hostname docmanager -d -p 17300:17300/tcp -p 1785:1785/tcp -p 8080:8080/tcp -e DB_HOST=<db_ip> -e DB_PORT=<db_port> -e DB_USER=<db_user> -e DB_PASS=<db_pass> -e DB_NAME=<db_name> -e DB_TYPE=<db_type> -e DB_UPDATE=YES -e AIM_URL='<aim_url>' -e AIM_TOKEN='<aim_token>' -v <dp_data>:/usr/local/docpath/docmanagerarpack6/service/DP_DATA docpath/docmanager`

The used parameters are:
- `--name`: this parameter indicates the name of the container, in this case docmanager.
- `--hostname`: this parameter indicates the hostname of the machine with the license.
- `-d`: (detach) this parameter indicates that no messages are displayed in the execution console, silent mode.
- `-p 8080:8080`: this parameter indicates the port of both host machine and docmanager for DocPath ® DocManager AR Web Tool http access.
- `-p 1785:1785`: this parameter indicates the port of both host machine and docmanager for DocPath ® DocManager AR Service endpoints access.
- `-p 17300:17300`: this parameter indicates the port of both host machine and docmanager for DocPath ® DocManager AR Service socket access.
- `docpath/docmanager`: this is the name assigned previously while building the container.
- `db_ip`: IP or Hostname of the database service.
- `db_port`: Port of the database.
- `db_user`: User with privileges to connect to the database.
- `db_pass`: Password of the user with privileges.
- `db_name`: Name of the database or schema where DocPath ® DocManager AR is installed.
- `db_type`: Type of the database (SQLServer or Oracle).
- `aim_url`: URL of DocPath® AIM service for authenticacion.
- `aim_token`: Application token in AIM Server. 
- `dp_data`: Path of local folder for store `DP_DATA` directory. 

