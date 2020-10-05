#!/bin/bash
set -e

echo "***** Entrypoint..."
echo " -------------------- "

# Install Spigot if required
if [ "$USE_SPIGOT" = true ] && [ ! -f /McMyAdmin/Minecraft/spigot/.buildSuccess ] ; then
  echo "***** Installing Spigot"
  JVM_MAX_MEMORY="Xmx${JAVA_MEMORY}M"
  cd /McMyAdmin/Minecraft/spigot/
  java -"$JVM_MAX_MEMORY" -jar /McMyAdmin/Minecraft/spigot/BuildTools.jar --rev "$MINECRAFT_VERSION" > spigot.log 2>&1
  cp /McMyAdmin/Minecraft/spigot/spigot-*.jar /McMyAdmin/Minecraft/
  mv /McMyAdmin/Minecraft/minecraft_server.jar /McMyAdmin/Minecraft/minecraft_server.jar_backup
  mv /McMyAdmin/Minecraft/spigot-*.jar /McMyAdmin/Minecraft/minecraft_server.jar
  touch /McMyAdmin/Minecraft/spigot/.buildSuccess
fi

# Configure McMyAdmin
echo "***** Configuring McMyAdmin conf file"
python3 /scripts/configure_mcma.py

# Configure Minecraft
echo "***** Configuring Minecraft server properties file"
python3 /scripts/configure_minecraft.py

cd /McMyAdmin/
echo "***** Starting up..."
./MCMA2_Linux_x86_64 -setpass "$MCMA_PASSWORD"

echo "***** Done!"
