FROM ubuntu:20.04

LABEL maintainer="programming@bymatej.com"

ARG DEBIAN_FRONTEND=noninteractive
# Environment variables used in McMyAdmin.conf
ENV MCMA_PASSWORD=admin
ENV WEBSERVER_PORT=8080
ENV JAVA_PATH=detect
ENV JAVA_MEMORY=1024
ENV JAVA_GC=default
ENV JAVA_CUSTOM_OPTS=
# Environment variables used in server.properties in Minecraft
ENV ENABLE_JMX_MONITORING=false
ENV RCON.PORT=25575
ENV LEVEL_SEED=
ENV GAMEMODE=survival
ENV ENABLE_COMMAND_BLOCK=false
ENV ENABLE_QUERY=false
ENV GENERATOR_SETTINGS=
ENV LEVEL_NAME=WORLD
ENV MOTD="A Minecraft Server"
ENV QUERY.PORT=25565
ENV PVP=true
ENV GENERATE_STRUCTURES=true
ENV DIFFICULTY=easy
ENV NETWORK_COMPRESSION_THRESHOLD=256
ENV MAX_TICK_TIME=60000
ENV MAX_PLAYERS=20
ENV USE_NATIVE_TRANSPORT=true
ENV ONLINE_MODE=true
ENV ENABLE_STATUS=true
ENV ALLOW_FLIGHT=false
ENV BROADCAST_RCON_TO_OPS=true
ENV VIEW_DISTANCE=10
ENV MAX_BUILD_HEIGHT=256
ENV SERVER_IP=
ENV ALLOW_NETHER=true
ENV SERVER_PORT=25565
ENV ENABLE_RCON=false
ENV SYNC_CHUNK_WRITES=true
ENV OP_PERMISSION_LEVEL=4
ENV PREVENT_PROXY_CONNECTIONS=false
ENV RESOURCE_PACK=
ENV ENTITY_BROADCAST_RANGE_PERCENTAGE=100
ENV RCON.PASSWORD=
ENV PLAYER_IDLE_TIMEOUT=0
ENV FORCE_GAMEMODE=false
ENV RATE_LIMIT=0
ENV HARDCORE=false
ENV WHITE_LIST=false
ENV BROADCAST_CONSOLE_TO_OPS=true
ENV SPAWN_NPCS=true
ENV SPAWN_ANIMALS=true
ENV SNOOPER_ENABLED=true
ENV FUNCTION_PERMISSION_LEVEL=2
ENV LEVEL_TYPE=DEFAULT
ENV SPAWN_MONSTERS=true
ENV ENFORCE_WHITELIST=false
ENV RESOURCE_PACK_SHA1=
ENV SPAWN_PROTECTION=16
ENV MAX_WORLD_SIZE=29999984

# Update and install required software and tools
RUN apt --assume-yes update
RUN apt --assume-yes install openjdk-8-jre-headless \
                                  wget \
                                  unzip \
                                  expect \
                                  python3 \
                                  screen

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java" >> /etc/profile && \
    echo "PATH=$PATH:$HOME/bin:$JAVA_HOME/bin" >> /etc/profile && \
    echo "export JAVA_HOME" >> /etc/profile && \
    echo "export JRE_HOME" >> /etc/profile && \
    echo "export PATH" >> /etc/profile

# Set iptables
#RUN iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT && \
#    iptables -A INPUT -p tcp -m tcp --dport 8081 -j ACCEPT && \
#    iptables -A INPUT -p tcp -m tcp --dport 25565 -j ACCEPT && \
#    iptables-save

# Download and install Mono for McMyAdmin
WORKDIR /usr/local
RUN wget http://mcmyadmin.com/Downloads/etc.zip
RUN unzip etc.zip && \
    rm etc.zip

# Download McMyAdmin
WORKDIR /McMyAdmin
RUN wget http://mcmyadmin.com/Downloads/MCMA2_glibc26_2.zip
RUN unzip MCMA2_glibc26_2.zip
RUN rm MCMA2_glibc26_2.zip

# Run initial setup for McMyAdmin
#ADD scripts/initialise_mcma.sh .
#ADD scripts/initialise_mcma.exp .
#RUN ./initialise_mcma.sh
#RUN screen -X at /McMyAdmin/MCMA2_Linux_x86_64 -setpass $MCMA_PASSWORD -configonly stuff y

## Agree to EULA
#RUN sed -i 's/eula=false/eula=true/g' /McMyAdmin/Minecraft/eula.txt
##RUN touch /McMyAdmin/Minecraft/eula.txt
##RUN echo "eula=true" >> /McMyAdmin/Minecraft/eula.txt

## Configure McMyAdmin
#ADD scripts/configure_mcma.py .
#RUN python3 configure_mcma.py

## Configure Minecraft server
#ADD scripts/configure_minecraft.py .
#RUN python3 configure_minecraft.py



#temp
CMD tail -f /dev/null
