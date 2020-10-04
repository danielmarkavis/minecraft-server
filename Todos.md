# Todos

## Add installation files to image
Add files obtained from web (wget) and add them to project and use ADD to copy them to the image directly

## Remove CMD tail -f /dev/null from dockerfile
This was just for test so I can SSH into container

## Add spigot
Add Spigot - build process and jar(s). See if it is better to have them in the image, or is it better to download them (wget).

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
docker build -t mc . && docker run -dit --name mc -e WEBSERVER_PORT=11 mc && docker exec -it mc /bin/bash
