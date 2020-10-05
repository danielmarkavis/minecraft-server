# minecraft-server
A Minecraft server with: 
- McMyAdmin
- Spigot
- Ability to specify Minecraft version
- Fully configurable using environment variables
- Volume to access configuration files later on

## NOT DONE YET - CHECK **Todos.md** FOR DETAILS

# Disclaimer
By using this Docker image you implicitly agree to the McMyAdmin's EULA.

You may read it here: https://mcmyadmin.com/licence.html

I created this for my own personal use. I use it for fun on my "hacked" server.
If you are not happy with the solution provided here, do one of the following: 
- Create a pull request with desired changes on this project and I will consider it
- Fork this project and modify it
- Write me an email at programming@bymatej.com and tell me what would you like me to change (don't expect me to do it if I don't think it's worth it, or if I don't find the time to do it)
- Use it the way I use it and don't complain
- Check other solutions, like this one, for example: https://github.com/tekgator/docker-mcmyadmin

# Running
Configuration and customization is done at the entrypoint. Do not override the entrypoint.
Default command (CMD) starts the McMyAdmin2 web panel.

## Run commands
- todo: write `docker run` command examples with explanations

### My run command
```
docker run -d \
    --name minecraft-server \
    -p 8080:8080 \
    -p 25565:25565 \
    --restart unless-stopped  \
    --stop-timeout 30 \
    -v McMyAdmin:/McMyAdmin \
    -e MINECRAFT_VERSION=1.12.2 \
    -e MCMA_PASSWORD=StrongPa55! \
    -e JAVA_MEMORY=3072 \
    -e JAVA_GC=-XX:+UseG1GC \
    -e JAVA_CUSTOM_OPTS=-server \
    -e ENABLE_COMMAND_BLOCK=true \
    -e LEVEL_NAME="World By Matej" \
    -e MOTD="A Minecraft Server by Matej" \
    -e DIFFICULTY=hard \
    -e MAX_PLAYERS=6 \ 
    -e ONLINE_MODE=false \
    -e VIEW_DISTANCE=5 \ 
    -e MAX_BUILD_HEIGHT=128 \ 
    -e PLAYER_IDLE_TIMEOUT=60 \
    -e SNOOPER_ENABLED=false \
    -e SPAWN_PROTECTION=10 \
    -e MAX_WORLD_SIZE=14999992 \
    bymatej/minecraft-server
```

# Environment variables
The *Recommended value* column in (some tables below) outlines the values that I personally use for my own server.
This does not mean that the values I provided are in any sense better than the default ones.
Apply the best values for your server. Do not bluntly copy/paste the values from others.
Custom values are passed using environment variables on `docker run` command using `-e` parameter.
Example: `-e MCMA_PASSWORD=xyz`

## Java version
You can specify the major Java version (8, 11, etc.). Recommended and default value is `8`. 
You may specify `11` if your plugins need that exact version. 
Specifying an invalid value will cause errors and nothing will work.

| Variable           | Default value | Description                                                            |
| ------------------ | ------------- | ---------------------------------------------------------------------- |
| JAVA_MAJOR_VERSION | 8             | Java major version                                                     |

## Spigot settings
This is only if you want to use Spigot build.

To use Spigot build, the `USE_SPIGOT` must be set to `true`. 
This is set to `true` by default.

If Spigot build is used, you can also specify the Minecraft version (1.12.2, 1.14, etc.). The default value is `latest`. 
Specifying `latest` will use the latest version available. The environment variable for this is `MINECRAFT_VERSION`.
This version is then used when building Spigot jar file. 
Available versions are outlined here: https://www.spigotmc.org/wiki/buildtools/

If `USE_SPIGOT` is set to `false`, the `MINECRAFT_VERSION` is ignored. 
The installed version of Minecraft is the one that comes with McMyAdmin (latest).
Installing Spigot, and other flavors of Minecraft can also be configured in McMyAdmin GUI later on.

| Variable           | Default value | Description                                                            |
| ------------------ | ------------- | ---------------------------------------------------------------------- |
| USE_SPIGOT         | true          | Install Spigot                                                         |
| MINECRAFT_VERSION  | latest        | Minecraft version                                                      |

## McMyAdmin password
Initial password is set using the `-setpass` argument in the `startup.sh` script.

| Variable      | Default value | Description                                                            |
| ------------- | ------------- | ---------------------------------------------------------------------- |
| MCMA_PASSWORD | nimda         | Password for McMyAdmin web application. Plese, do not use the default. |

## McMyAdmin configuration
Environment variable names reflect the names of the properties in the `McMyAdmin.conf` file. 
Mappings between environment variable names, and names in the conf file, as well as the default values are outlined below.
The recommended values are pretty much the values I personally use.

| Variable         | Name in conf file | Default value | Recommended value | Description                                                        |
| ---------------- | ----------------- | ------------- | ----------------- | ------------------------------------------------------------------ |
| WEBSERVER_PORT   | Webserver.Port    | 8080          | 8081              | Port on which MCMA web server is running                           |
| JAVA_PATH        | Java.Path         | detect        | detect            | Path to Java Runtime Environment                                   |
| JAVA_MEMORY      | Java.Memory       | 1024          | 3072              | Amount of RAM in MB avaliable for JVM (Java Virtual Machine)       |
| JAVA_GC          | Java.GC           | default       | -XX:+UseG1GC      | Java Garbage Collector                                             |
| JAVA_CUSTOM_OPTS | Java.CustomOpts   |               | -server           | Extra arguments to pass to Java when starting the Minecraft server |

## Minecraft configuration
Environment variable names reflect the names of the properties in the `server.properties` file. 
Mappings between environment variable names, and names in the properties file, as well as the default values are outlined below.
The recommended values are pretty much the values I personally use.
All properties and their descriptions can be found here: https://minecraft.gamepedia.com/Server.properties#Java_Edition_3

| Variable                          | Name in properties file           | Default value      | Recommended value           |
| --------------------------------- | --------------------------------- | ------------------ | --------------------------- |
| ENABLE_JMX_MONITORING             | enable-jmx-monitoring             | false              | false                       |
| RCON_PORT                         | rcon.port                         | 25575              | 25575                       |
| LEVEL_SEED                        | level-seed                        |                    |                             |
| GAMEMODE                          | gamemode                          | survival           | survival                    |
| ENABLE_COMMAND_BLOCK              | enable-command-block              | false              | true                        |
| ENABLE_QUERY                      | enable-query                      | false              | false                       |
| GENERATOR_SETTINGS                | generator-settings                |                    |                             |
| LEVEL_NAME                        | level-name                        | world              | World By Matej              |
| MOTD                              | motd                              | A Minecraft Server | A Minecraft Server by Matej |
| QUERY_PORT                        | query.port                        | 25565              | 25565                       |
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
| RCON_PASSWORD                     | rcon.password                     |                    |                             |
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

# Resources
Resources and technologies used:
- Minecraft: https://www.minecraft.net/
- McMyAdmin: https://mcmyadmin.com/
- Spigot: https://www.spigotmc.org/
- Java: https://www.java.com/
- Docker: https://www.docker.com/
- Bash: https://www.gnu.org/software/bash/
- Ubuntu: https://ubuntu.com/