FROM ubuntu:20.04

LABEL maintainer="programming@bymatej.com"

ARG DEBIAN_FRONTEND=noninteractive

# Environment variables used for setting up the system
ENV JAVA_MAJOR_VERSION=8

# Environment variables used for initialising McMyAdmin
ENV MCMA_PASSWORD=nimda

# Environment variables used in McMyAdmin.conf
ENV WEBSERVER_PORT=8080 \
    JAVA_PATH=detect \
    JAVA_MEMORY=1024 \
    JAVA_GC=default \
    JAVA_CUSTOM_OPTS=

# Environment variables used in server.properties in Minecraft
ENV ENABLE_JMX_MONITORING=false \
    RCON_PORT=25575 \
    LEVEL_SEED= \
    GAMEMODE=survival \
    ENABLE_COMMAND_BLOCK=false \
    ENABLE_QUERY=false \
    GENERATOR_SETTINGS= \
    LEVEL_NAME=WORLD \
    MOTD="A Minecraft Server" \
    QUERY_PORT=25565 \
    PVP=true \
    GENERATE_STRUCTURES=true \
    DIFFICULTY=easy \
    NETWORK_COMPRESSION_THRESHOLD=256 \
    MAX_TICK_TIME=60000 \
    MAX_PLAYERS=20 \
    USE_NATIVE_TRANSPORT=true \
    ONLINE_MODE=true \
    ENABLE_STATUS=true \
    ALLOW_FLIGHT=false \
    BROADCAST_RCON_TO_OPS=true \
    VIEW_DISTANCE=10 \
    MAX_BUILD_HEIGHT=256 \
    SERVER_IP= \
    ALLOW_NETHER=true \
    SERVER_PORT=25565 \
    ENABLE_RCON=false \
    SYNC_CHUNK_WRITES=true \
    OP_PERMISSION_LEVEL=4 \
    PREVENT_PROXY_CONNECTIONS=false \
    RESOURCE_PACK= \
    ENTITY_BROADCAST_RANGE_PERCENTAGE=100 \
    RCON_PASSWORD= \
    PLAYER_IDLE_TIMEOUT=0 \
    FORCE_GAMEMODE=false \
    RATE_LIMIT=0 \
    HARDCORE=false \
    WHITE_LIST=false \
    BROADCAST_CONSOLE_TO_OPS=true \
    SPAWN_NPCS=true \
    SPAWN_ANIMALS=true \
    SNOOPER_ENABLED=true \
    FUNCTION_PERMISSION_LEVEL=2 \
    LEVEL_TYPE=DEFAULT \
    SPAWN_MONSTERS=true \
    ENFORCE_WHITELIST=false \
    RESOURCE_PACK_SHA1= \
    SPAWN_PROTECTION=16 \
    MAX_WORLD_SIZE=29999984

# Environment variables used for Spigot installation
ENV MINECRAFT_VERSION=latest

# Update and install required software and tools
RUN echo "***** Updating and installing required software and tools" && \
    apt --assume-yes update˛&& \
    apt --assume-yes install openjdk-$JAVA_MAJOR_VERSION-jre-headless \
                             wget \
                             unzip \
                             python3 \
                             dumb-init \
                             locales \
                             ca-certificates \
                             curl \
                             git \
                             screen \
                             gosu

# General system setup
RUN echo "***** Running general system setup" && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-$JAVA_MAJOR_VERSION-openjdk-amd64/jre/bin/java
RUN echo "***** Setting JAVA_HOME environment variable" && \
    echo "JAVA_HOME=/usr/lib/jvm/java-$JAVA_MAJOR_VERSION-openjdk-amd64/jre/bin/java" >> /etc/profile && \
    echo "PATH=$PATH:$HOME/bin:$JAVA_HOME/bin" >> /etc/profile && \
    echo "export JAVA_HOME" >> /etc/profile && \
    echo "export JRE_HOME" >> /etc/profile && \
    echo "export PATH" >> /etc/profile

# Download and install Mono for McMyAdmin
WORKDIR /usr/local
RUN wget http://mcmyadmin.com/Downloads/etc.zip && \
    unzip etc.zip && \
    rm etc.zip

# Download McMyAdmin
WORKDIR /McMyAdmin
RUN wget http://mcmyadmin.com/Downloads/MCMA2_glibc26_2.zip && \
    unzip MCMA2_glibc26_2.zip && \
    rm MCMA2_glibc26_2.zip

# Run initial setup for McMyAdmin
RUN /McMyAdmin/MCMA2_Linux_x86_64 -setpass $MCMA_PASSWORD -configonly -nonotice

# Agree to EULA
#RUN sed -i 's/eula=false/eula=true/g' /McMyAdmin/Minecraft/eula.txt
RUN echo "***** Agreeing to MCMA's EULA: https://mcmyadmin.com/licence.html"
    touch /McMyAdmin/Minecraft/eula.txt && \
    echo "eula=true" >> /McMyAdmin/Minecraft/eula.txt


# Configure McMyAdmin
ADD scripts/configure_mcma.py .
RUN python3 configure_mcma.py

# Install Spigot
#RUN 

# Configure Minecraft server
#ADD scripts/configure_minecraft.py .
#RUN python3 configure_minecraft.py



#temp
CMD tail -f /dev/null
