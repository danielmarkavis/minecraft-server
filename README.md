# minecraft-server
A Minecraft server with: 
- McMyAdmin
- Ability to specify Mod/Flavor (Vanilla, Spigot, Forge) with ability to specify the Minecraft version
- Fully configurable using environment variables
- Volume to access all the configuration files later on

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

# System requirements
This heavily depends on: 
- your settings (world size, build height, view distance, number of players, etc.)
- number of players currently playing
- what is happening on the map (it is not the same to be alone in the desert, and be surrounded by 10 mobs; the latter requires a lot more work on the server side)

Here are the recommendations: https://minecraft.gamepedia.com/Server/Requirements/Dedicated#Console

My server: 
- Lenovo Q190 (an old mini desktop PC)
- 320 GB HDD (not SSD, unfortunately)
- 4GB RAM (1600 MHz)
- Intel Celeron CPU 1017U @ 1.60GHz (Dual Core)

So, it is a pretty low-end machine.
I would recommend at least 2GB of RAM for the McMyAdmin (set using the `JAVA_MEMORY` environment variable).
The settings I use are in the *Recommended* columns in the tables below.

It can run on 1GB of RAM, but it will be sluggish, and there will be a lot of ticks skipping. 
If you see the following entry in the log (in McMyAdmin console) it is not good: `CONSOLE: thread/WARN]: Can't keep up! Did the system time change, or is the server overloaded? Running [####]ms behind, skipping [##] tick(s`

# Running and stopping
Configuration and customization is done by running the default image command (the `CMD` in the dockerfile at the bottom of the file). Do not override the entrypoint, but also do not override the `CMD`.

## Run commands
### Recommended run command
This command will load most of the defaults, except the McMyAdmin password, Java memory and custom opts.

```
docker run -d \
    --name minecraft-server \
    -p 8080:8080 \
    -p 25565:25565 \
    --restart unless-stopped \
    --stop-timeout 30 \
    -v McMyAdmin:/McMyAdmin \
    -e MCMA_PASSWORD=StrongPa55! \
    -e JAVA_MEMORY=2048 \
    -e JAVA_CUSTOM_OPTS=-server \
    bymatej/minecraft-server
```

#### Explanations
Official documentation: https://docs.docker.com/engine/reference/run/

##### `docker run` 
The docker command that runs the image (creates the container out of the specified image).
##### `-d`
This means "detached", so the `run` command is run in background.
##### `--name minecraft-server` 
Specifies the container name. You can change the `minecraft-server` to whatever you like.
##### `-p 8080:8080` and `-p 25565:25565`
Publishes a container's port to the host. So, container's port `8080` is published to port `8080` on the host.

In case, for example, the port `8080` is used by another app on your host, you can do the following: `-p 8080:8081`.
This would publish `8080` in container to `8081` on the host. Your McMyAdmin web panel would be at `http://localhost:8081` in that case.
##### `--restart unless-stopped`
Restarts the container automatically, unless it is stopped intentionally. Good if the container crashes - it will restart automatically.
##### `--stop-timeout 30` 
Gives the container 30 seconds of timeout when stopping. Good for safe container stop.
##### `-v McMyAdmin:/McMyAdmin`
Defines the volume. The `/McMyAdmin` is the folder in the container and the volume name is `McMyAdmin`.
##### `-e MCMA_PASSWORD=StrongPa55!`
Defines the key-value pair for the environment variable. In this case, the key is `MCMA_PASSWORD` and the value is `StrongPa55!`.
Multiple `-e` parameters can be added.
##### `bymatej/minecraft-server`
Specified the image used. No tag is specified, so this is the same as `bymatej/minecraft-server:latest`.

### Create your own run command
Run your container with settings that fit your server the best.

### My run command
```
docker run -d \
    --name minecraft-server \
    -p 8080:8080 \
    -p 25565:25565 \
    --restart unless-stopped \
    --stop-timeout 30 \
    -v McMyAdmin:/McMyAdmin \
    -e MINECRAFT_FLAVOR=Forge \
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

The `StrongPa55!` is, obviously, not my **actual** password. :) 

## Stopping the server
Steps: 
- Stop the Minecraft server in McMyAdmin web panel
- Stop the container (if you want to)

Do not just stop the container without stopping the Minecraft server, so your world does not get corrupted. 

To manage your containers, there is a nifty tool for that called Portainer. Check it out: https://www.portainer.io/

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

## Mod settings
This is only if you want to use Modded version of Minecraft.
Specify the mod using `MINECRAFT_FLAVOR` environment variable.
Options for the variable are: 
- `Vanilla`
- `Spigot`
- `Forge`

You can also specify the Minecraft version (1.12.2, 1.14, etc.). The default value is `latest`. 
Specifying `latest` will use the latest version available.

If `MINECRAFT_FLAVOR` is set to `Vanilla`, the `MINECRAFT_VERSION` is ignored (for now). 
The installed version of Minecraft is the one that comes with McMyAdmin (possibly latest at the time of building the image).
Installing other flavors/mods of Minecraft can also be configured in McMyAdmin GUI later on.

### Vanilla
To use Vanilla, the `MINECRAFT_FLAVOR` should be set to `Vanilla`. This is the default value.
This settings triggers a script that downloads the Minecraft Server Jar file from https://mcversions.net/

### Spigot
This is Spigot: https://www.spigotmc.org/
To use Spigot build, the `MINECRAFT_FLAVOR` should be set to `Spigot`.

The environment variable `MINECRAFT_VERSION` is used when building Spigot jar file. 
Available versions are outlined here: https://www.spigotmc.org/wiki/buildtools/

**Important**: Spigot is built on the first start of the container. 
This take a lot of time, so be patient. 
Check the container log by using `docker logs` command. Once you are past "Installing Spigot" the container will soon finish its entrypoint commands and your McMyAdmin will be ready.

### Forge
This is Forge: http://files.minecraftforge.net/
To use the Forge build, the `MINECRAFT_FLAVOR` should be set to `Forge`.

The environment variable `MINECRAFT_VERSION` is used when getting the download link for Forge jar file.


| Variable           | Default value | Description                                                            |
| ------------------ | ------------- | ---------------------------------------------------------------------- |
| MINECRAFT_FLAVOR   | Vanilla       | Specify which Minecraft Flavor/Mod to install                          |
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

# Resources and additional instructions
## Resources
Resources and technologies used:
- Minecraft: https://www.minecraft.net/
- McMyAdmin: https://mcmyadmin.com/
- Minecraft server: https://mcversions.net/
- Spigot: https://www.spigotmc.org/
- Forge: http://files.minecraftforge.net/
- Java: https://www.java.com/
- Docker: https://www.docker.com/
- Bash: https://www.gnu.org/software/bash/
- Ubuntu: https://ubuntu.com/

## Minecraft and McMyAdmin additional instructions

### Installation
- Installation instructions grabbed from: https://bymatej.com/how-to-set-up-a-minecraft-java-edition-server-with-mcmyadmin2-on-linux/

### Minecraft gameplay
- Download Minecraft (free, unofficial): https://bymatej.com/how-to-download-minecraft-java-edition-via-tlauncher/
- Crafting guide: https://www.minecraftcraftingguide.net/

### McMyAdmin additional configuration
- Whitelisting users in McMyAdmin2 (so only specific people can join your server): https://bymatej.com/how-to-set-up-a-minecraft-java-edition-server-with-mcmyadmin2-on-linux/#Whitelisting
