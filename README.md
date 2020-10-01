# minecraft-server




# Environment variables
The *Recommended value* column outlines the values that I personally use for my own server.
This does not mean that the values I provided are in any sense better than the default ones.
Apply the best values for your server. Do not bluntly copy/paste the values from others.
Recommended values are passed using environment variables on `docker run` command using `-e` parameter.

## McMyAdmin password
Initial password is set using the `-setpass` argument in the `inittialise_mcma.sh` script.
| Variable      | Default value | Description                            |
| ------------- | ------------- | -------------------------------------- |
| MCMA_PASSWORD | admin         | Password for McMyAdmin web application |

## McMyAdmin configuration (as in `McMyAdmin.conf` file)
| Variable         | Name in conf file | Default value | Recommended value | Description                                                        |
| ---------------- | ----------------- | ------------- | ----------------- | ------------------------------------------------------------------ |
| WEBSERVER_PORT   | Webserver.Port    | 8080          | 8081              | Port on which MCMA web server is running                           |
| JAVA_PATH        | Java.Path         | detect        | detect            | Path to Java Runtime Environment                                   |
| JAVA_MEMORY      | Java.Memory       | 1024          | 3072              | Amount of RAM avaliable for JVM (Java Virtual Machine)             |
| JAVA_GC          | Java.GC           | default       | -XX:+UseG1GC      | Java Garbage Collector                                             |
| JAVA_CUSTOM_OPTS | Java.CustomOpts   |               | -server           | Extra arguments to pass to Java when starting the Minecraft server |


## Minecraft configuration ( as in `server.properties` file)
All properties and their descriptions can be found here: https://minecraft.gamepedia.com/Server.properties#Java_Edition_3
| Variable                          | Name in properties file           | Default value      | Recommended value           |
| --------------------------------- | --------------------------------- | ------------------ | --------------------------- |
| ENABLE_JMX_MONITORING             | enable-jmx-monitoring             | false              | false                       |
| RCON.PORT                         | rcon.port                         | 25575              | 25575                       |
| LEVEL_SEED                        | level-seed                        |                    |                             |
| GAMEMODE                          | gamemode                          | survival           | survival                    |
| ENABLE_COMMAND_BLOCK              | enable-command-block              | false              | true                        |
| ENABLE_QUERY                      | enable-query                      | false              | false                       |
| GENERATOR_SETTINGS                | generator-settings                |                    |                             |
| LEVEL_NAME                        | level-name                        | world              | World By Matej              |
| MOTD                              | motd                              | A Minecraft Server | A Minecraft Server by Matej |
| QUERY.PORT                        | query.port                        | 25565              | 25565                       |
| PVP                               | pvp                               | true               | true                        |
| GENERATE_STRUCTURES               | generate-structures               | true               | true                        |
| DIFFICULTY                        | difficulty                        | easy               | hard                        |
| NETWORK_COMPRESSION_THRESHOLD     | network-compression-threshold     | 256                | 256                         |
| MAX_TICK_TIME                     | max-tick-time                     | 60000              | 60000                       |
| MAX_PLAYERS                       | max-players                       | 20                 | 6                           |
| USE_NATIVE_TRANSPORT              | use-native-transport              | true               | true                        |
| ONLINE_MODE                       | online-mode                       | true               | false                       |
| ENABLE_STATUS                     | enable-status                     | true               | true                        |
| ALLOW_FLIGHT                      | allow-flight                      | false              | false                       |
| BROADCAST_RCON_TO_OPS             | broadcast-rcon-to-ops             | true               | true                        |
| VIEW_DISTANCE                     | view-distance                     | 10                 | 5                           |
| MAX_BUILD_HEIGHT                  | max-build-height                  | 256                | 128                         |
| SERVER_IP                         | server-ip                         |                    |                             |
| ALLOW_NETHER                      | allow-nether                      | true               | true                        |
| SERVER_PORT                       | server-port                       | 25565              | 25565                       |
| ENABLE_RCON                       | enable-rcon                       | false              | true                        |
| SYNC_CHUNK_WRITES                 | sync-chunk-writes                 | true               | true                        |
| OP_PERMISSION_LEVEL               | op-permission-level               | 4                  | 4                           |
| PREVENT_PROXY_CONNECTIONS         | prevent-proxy-connections         | false              | false                       |
| RESOURCE_PACK                     | resource-pack                     |                    |                             |
| ENTITY_BROADCAST_RANGE_PERCENTAGE | entity-broadcast-range-percentage | 100                | 100                         |
| RCON.PASSWORD                     | rcon.password                     |                    |                             |
| PLAYER_IDLE_TIMEOUT               | player-idle-timeout               | 0                  | 60                          |
| FORCE_GAMEMODE                    | force-gamemode                    | false              | false                       |
| RATE_LIMIT                        | rate-limit                        | 0                  | 0                           |
| HARDCORE                          | hardcore                          | false              | false                       |
| WHITE_LIST                        | white-list                        | false              | false                       |
| BROADCAST_CONSOLE_TO_OPS          | broadcast-console-to-ops          | true               | true                        |
| SPAWN_NPCS                        | spawn-npcs                        | true               | true                        |
| SPAWN_ANIMALS                     | spawn-animals                     | true               | true                        |
| SNOOPER_ENABLED                   | snooper-enabled                   | true               | false                       |
| FUNCTION_PERMISSION_LEVEL         | function-permission-level         | 2                  | 2                           |
| LEVEL_TYPE                        | level-type                        | default            | default                     |
| SPAWN_MONSTERS                    | spawn-monsters                    | true               | true                        |
| ENFORCE_WHITELIST                 | enforce-whitelist                 | false              | false                       |
| RESOURCE_PACK_SHA1                | resource-pack-sha1                |                    |                             |
| SPAWN_PROTECTION                  | spawn-protection                  | 16                 | 10                          |
| MAX_WORLD_SIZE                    | max-world-size                    | 29999984           | 14999992                    |
