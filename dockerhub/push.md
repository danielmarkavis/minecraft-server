# Push the new version/tag to docker hub

## Pull the latest code from this repo
```
cd /home/matej/projects/minecraft-server && git pull
```

## Log in
```
docker login --username bymatej --password pass
```

## Build
```
docker build -t bymatej/minecraft-server .
```

## Run & test locally
```
docker run bymatej/minecraft-server
```

## Push
```
docker push bymatej/minecraft-server
```

More info: https://docs.docker.com/docker-hub/ 
