# Todos

## Rename "configure_mcma.sh" to "initialize_mcma.sh"
Because the configuration is done at a later stage

## Add installation files to image
Add files obtained from web (wget) and add them to project and use ADD to copy them to the image directly

## Remove CMD tail -f /dev/null from dockerfile
This was just for test so I can SSH into container

## Apply McMyAdmin configuration (utilise environment variables)
| Variable         | Name in conf file | Default value | Recommended value | Mandatory | Description     |
| ---------------- | ----------------- | ------------- | ----------------- | --------- | --------------- |
| WEBSERVER_PORT   | Webserver.Port    | 8080          | 8081              | No        | x               |
| JAVA_PATH        | Java.Path         | detect        |                   | No        | x               |
| JAVA_MEMORY      | Java.Memory       | 1024          | 3072              | No        | x               |
| JAVA_GC          | Java.GC           | default       | -XX:+UseG1GC      | No        | x               |
| JAVA_CUSTOM_OPTS | Java.CustomOpts   |               | -server           | No        | Make it default?|

## Apply server.properties changes (same as above - environment vars.)
| Variable         | Name in properties file | Default value | Recommended value | Mandatory | Description     |
| ---------------- | ----------------------- | ------------- | ----------------- | --------- | --------------- |

# Not Todos (useful)
## Testing the image
cd ~/projects/private/minecraft-server/
docker build -t mc .
docker run -dit --name mc mc
docker exec -it mc /bin/bash
docker stop mc
docker rm mc
docker image rm mc
docker images prune

## All in one
docker stop mc && docker rm mc && docker image rm mc && docker images prune
docker build -t mc . && docker run -dit --name mc mc && docker exec -it mc /bin/bash
