#!/bin/bash
set -e

echo "***** Entrypoint..."
echo " -------------------- "

install_spigot() {
  # Install Spigot if required
  if [ ! -f /McMyAdmin/Minecraft/spigot/.buildSuccess ] ; then
    echo "***** Installing Spigot"
    JVM_MAX_MEMORY="Xmx${JAVA_MEMORY}M"
    cd /McMyAdmin/Minecraft/spigot/
    java -"$JVM_MAX_MEMORY" -jar /McMyAdmin/Minecraft/spigot/BuildTools.jar --rev "$MINECRAFT_VERSION" > spigot.log 2>&1
    cp /McMyAdmin/Minecraft/spigot/spigot-*.jar /McMyAdmin/Minecraft/
    mv /McMyAdmin/Minecraft/minecraft_server.jar /McMyAdmin/Minecraft/minecraft_server.jar_backup
    mv /McMyAdmin/Minecraft/spigot-*.jar /McMyAdmin/Minecraft/minecraft_server.jar
    touch /McMyAdmin/Minecraft/spigot/.buildSuccess
    echo "***** Spigot installation done!"
  fi
}

install_forge() {
  # Install Forge if required
  echo "***** Installing Forge"
  python3 /scripts/download_minecraft_forge.py
  echo "***** Forge installation done!"
}

case ${MINECRAFT_FLAVOR^^} in
    VANILLA )
        echo "Vanilla is probably already installed. Doing nothing..."
    ;;
    SPIGOT )
        install_spigot
    ;;
    FORGE )
        install_forge
    ;;
    * )
        echo "$MINECRAFT_FLAVOR is unknown. Nothing will be done here..."
    ;;
esac

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
