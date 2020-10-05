# TO-DOs

## Fix issues with stopping containers
Container is stopped after entrypoint.sh is executed.
Probably needing dumb-init, or something like that...

## Add installation files to image
Add files obtained from web (wget) and add them to project and use ADD to copy them to the image directly.

This is probably not a good idea, as a lot of files would need to be added and on each Minecraft update a new jar would need to be added.
This would also require pre-built Spigot versions.

## Check how worlds are saved when stopping the container
Data should not be lost/corrupted after container stop.

## Consider migrating to AMP
AMP is successor of McMyAdmin2: https://github.com/cubecoders/amp/wiki
The problem is - it needs a service running on host. Then you can use their docker image.
I don't like this. Maybe the docker-compose may help.
I don't have the time for this now...

## Delete this document
It is useful only during the development.

# Not Todos (useful during development)
## Testing the image
```
cd ~/projects/private/minecraft-server/
```

```
docker build -t mc .
```

```
docker run -dit --name mc mc
```

```
docker exec -it mc /bin/bash
```

```
docker stop mc
```

```
docker rm mc
```

```
docker image rm mc
```

```
docker images prune
```

## All in one
### Development
```
docker stop mc && docker rm mc && docker image rm mc && docker images prune
```

```
docker build -t mc . && docker run -dit --name mc -e WEBSERVER_PORT=11 mc && docker exec -it mc /bin/bash
```

### Test run
#### Create
```
docker build -t mc .
```
Run
```
docker run -d \
    --name mc \
    -p 8080:8080 \
    -p 25565:25565 \
    --restart unless-stopped  \
    --stop-timeout 30 \
    -v mc:/McMyAdmin \
    -e JAVA_MEMORY=2048 \
    -e JAVA_CUSTOM_OPTS=-server \
    -e ONLINE_MODE=false \
    -e MINECRAFT_VERSION=1.12.2 \
    mc
```
Remove
```
docker stop mc && docker rm mc && docker image rm mc && docker images prune
```
