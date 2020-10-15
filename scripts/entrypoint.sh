#!/bin/bash
set -e

echo "***** Entrypoint..."
echo " -------------------- "

install_vanilla() {
  # Install vanilla if required
  export SERVER_TYPE=Official
  if [ ! -f /McMyAdmin/Minecraft/.vanillaInstalled ] ; then
    echo "***** Installing Vanilla"
    python3 /scripts/download_minecraft_vanilla.py
    touch /McMyAdmin/Minecraft/.vanillaInstalled
    echo "***** Vanilla installation done!" ; else
      echo  "***** Minecraft Forge is already installed."
  fi
}

install_spigot() {
  # Install Spigot if required
  export SERVER_TYPE=Official
  if [ ! -f /McMyAdmin/Minecraft/spigot/.buildSuccess ] ; then
    echo "***** Installing Spigot"
    JVM_MAX_MEMORY="Xmx${JAVA_MEMORY}M"
    cd /McMyAdmin/Minecraft/spigot/
    java -"$JVM_MAX_MEMORY" -jar /McMyAdmin/Minecraft/spigot/BuildTools.jar --rev "$MINECRAFT_VERSION" > spigot.log 2>&1
    cp /McMyAdmin/Minecraft/spigot/spigot-*.jar /McMyAdmin/Minecraft/
    mv /McMyAdmin/Minecraft/minecraft_server.jar /McMyAdmin/Minecraft/minecraft_server.jar_backup
    mv /McMyAdmin/Minecraft/spigot-*.jar /McMyAdmin/Minecraft/minecraft_server.jar
    touch /McMyAdmin/Minecraft/spigot/.buildSuccess
    echo "***** Spigot installation done!" ; else
      echo  "***** Spigot is already installed."
  fi
}

install_forge() {
  export SERVER_TYPE=Forge
  # Install Forge if required
  if [ ! -f /McMyAdmin/Minecraft/ForgeMod.jar ] ; then
    echo "***** Installing Forge"
    python3 /scripts/download_minecraft_forge.py
    cd /McMyAdmin/Minecraft
    java -jar /McMyAdmin/Minecraft/forge-installer.jar --installServer /McMyAdmin/Minecraft
    rm /McMyAdmin/Minecraft/forge-installer.jar
    mv /McMyAdmin/Minecraft/forge-*.jar /McMyAdmin/Minecraft/ForgeMod.jar
    echo "***** Forge installation done!" ; else
      echo  "***** Minecraft Forge is already installed."
  fi
}

case ${MINECRAFT_FLAVOR^^} in
    VANILLA )
        install_vanilla
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
