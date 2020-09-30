# Todos

## Add installation files to image
Add files obtained from web (wget) and add them to project and use ADD to copy them to the image directly

## Remove CMD tail -f /dev/null from dockerfile
This was just for test so I can SSH into container

## Add spigot

## Apply McMyAdmin configuration (utilise environment variables)
| Variable         | Name in conf file | Default value | Recommended value | Mandatory | Description     |
| ---------------- | ----------------- | ------------- | ----------------- | --------- | --------------- |
| WEBSERVER_PORT   | Webserver.Port    | 8080          | 8081              | No        | x               |
| JAVA_PATH        | Java.Path         | detect        |                   | No        | x               |
| JAVA_MEMORY      | Java.Memory       | 1024          | 3072              | No        | x               |
| JAVA_GC          | Java.GC           | default       | -XX:+UseG1GC      | No        | x               |
| JAVA_CUSTOM_OPTS | Java.CustomOpts   |               | -server           | No        | Make it default?|


## Apply server.properties changes (same as above - environment vars.)
All properties and their descriptions can be found here: https://minecraft.gamepedia.com/Server.properties#Java_Edition_3
| Variable                          | Name in properties file           | Default value      | Recommended value | Mandatory | Description     |
| --------------------------------- | --------------------------------- | ------------------ | ----------------- | --------- | --------------- |
| ENABLE_JMX_MONITORING             | enable-jmx-monitoring             | false              |                   | No        | x               |
| RCON.PORT                         | rcon.port                         | 25575              |                   | No        | x               |
| LEVEL_SEED                        | level-seed                        |                    |                   | No        | x               |
| GAMEMODE                          | gamemode                          | survival           |                   | No        | x               |
| ENABLE_COMMAND_BLOCK              | enable-command-block              | false              |                   | No        | x               |
| ENABLE_QUERY                      | enable-query                      | false              |                   | No        | x               |
| GENERATOR_SETTINGS                | generator-settings                |                    |                   | No        | x               |
| LEVEL_NAME                        | level-name                        | world              |                   | No        | x               |
| MOTD                              | motd                              | A Minecraft Server |                   | No        | x               |
| QUERY.PORT                        | query.port                        | 25565              |                   | No        | x               |
| PVP                               | pvp                               | true               |                   | No        | x               |
| GENERATE_STRUCTURES               | generate-structures               | true               |                   | No        | x               |
| DIFFICULTY                        | difficulty                        | easy               |                   | No        | x               |
| NETWORK_COMPRESSION_THRESHOLD     | network-compression-threshold     | 256                |                   | No        | x               |
| MAX_TICK_TIME                     | max-tick-time                     | 60000              |                   | No        | x               |
| MAX_PLAYERS                       | max-players                       | 20                 |                   | No        | x               |
| USE_NATIVE_TRANSPORT              | use-native-transport              | true               |                   | No        | x               |
| ONLINE_MODE                       | online-mode                       | true               |                   | No        | x               |
| ENABLE_STATUS                     | enable-status                     | true               |                   | No        | x               |
| ALLOW_FLIGHT                      | allow-flight                      | false              |                   | No        | x               |
| BROADCAST_RCON_TO_OPS             | broadcast-rcon-to-ops             | true               |                   | No        | x               |
| VIEW_DISTANCE                     | view-distance                     | 10                 |                   | No        | x               |
| MAX_BUILD_HEIGHT                  | max-build-height                  | 256                |                   | No        | x               |
| SERVER_IP                         | server-ip                         |                    |                   | No        | x               |
| ALLOW_NETHER                      | allow-nether                      | true               |                   | No        | x               |
| SERVER_PORT                       | server-port                       | 25565              |                   | No        | x               |
| ENABLE_RCON                       | enable-rcon                       | false              |                   | No        | x               |
| SYNC_CHUNK_WRITES                 | sync-chunk-writes                 | true               |                   | No        | x               |
| OP_PERMISSION_LEVEL               | op-permission-level               | 4                  |                   | No        | x               |
| PREVENT_PROXY_CONNECTIONS         | prevent-proxy-connections         | false              |                   | No        | x               |
| RESOURCE_PACK                     | resource-pack                     |                    |                   | No        | x               |
| ENTITY_BROADCAST_RANGE_PERCENTAGE | entity-broadcast-range-percentage | 100                |                   | No        | x               |
| RCON.PASSWORD                     | rcon.password                     |                    |                   | No        | x               |
| PLAYER_IDLE_TIMEOUT               | player-idle-timeout               | 0                  |                   | No        | x               |
| FORCE_GAMEMODE                    | force-gamemode                    | false              |                   | No        | x               |
| RATE_LIMIT                        | rate-limit                        | 0                  |                   | No        | x               |
| HARDCORE                          | hardcore                          | false              |                   | No        | x               |
| WHITE_LIST                        | white-list                        | false              |                   | No        | x               |
| BROADCAST_CONSOLE_TO_OPS          | broadcast-console-to-ops          | true               |                   | No        | x               |
| SPAWN_NPCS                        | spawn-npcs                        | true               |                   | No        | x               |
| SPAWN_ANIMALS                     | spawn-animals                     | true               |                   | No        | x               |
| SNOOPER_ENABLED                   | snooper-enabled                   | true               |                   | No        | x               |
| FUNCTION_PERMISSION_LEVEL         | function-permission-level         | 2                  |                   | No        | x               |
| LEVEL_TYPE                        | level-type                        | default            |                   | No        | x               |
| SPAWN_MONSTERS                    | spawn-monsters                    | true               |                   | No        | x               |
| ENFORCE_WHITELIST                 | enforce-whitelist                 | false              |                   | No        | x               |
| RESOURCE_PACK_SHA1                | resource-pack-sha1                |                    |                   | No        | x               |
| SPAWN_PROTECTION                  | spawn-protection                  | 16                 |                   | No        | x               |
| MAX_WORLD_SIZE                    | max-world-size                    | 29999984           |                   | No        | x               |

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
