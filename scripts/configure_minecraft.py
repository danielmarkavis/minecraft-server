import enum
import fileinput
import os


class EnvironmentToMinecraftPropertiesMapping(enum.Enum):
    """
    Mapping of environment variable names and names of properties in server.properties file
    """
    ENABLE_JMX_MONITORING = "enable-jmx-monitoring"
    RCON_PORT = "rcon.port"
    LEVEL_SEED = "level-seed"
    GAMEMODE = "gamemode"
    ENABLE_COMMAND_BLOCK = "enable-command-block"
    ENABLE_QUERY = "enable-query"
    GENERATOR_SETTINGS = "generator-settings"
    LEVEL_NAME = "level-name"
    MOTD = "motd"
    QUERY_PORT = "query.port"
    PVP = "pvp"
    GENERATE_STRUCTURES = "generate-structures"
    DIFFICULTY = "difficulty"
    NETWORK_COMPRESSION_THRESHOLD = "network-compression-threshold"
    MAX_TICK_TIME = "max-tick-time"
    MAX_PLAYERS = "max-players"
    USE_NATIVE_TRANSPORT = "use-native-transport"
    ONLINE_MODE = "online-mode"
    ENABLE_STATUS = "enable-status"
    ALLOW_FLIGHT = "allow-flight"
    BROADCAST_RCON_TO_OPS = "broadcast-rcon-to-ops"
    VIEW_DISTANCE = "view-distance"
    MAX_BUILD_HEIGHT = "max-build-height"
    SERVER_IP = "server-ip"
    ALLOW_NETHER = "allow-nether"
    SERVER_PORT = "server-port"
    ENABLE_RCON = "enable-rcon"
    SYNC_CHUNK_WRITES = "sync-chunk-writes"
    OP_PERMISSION_LEVEL = "op-permission-level"
    PREVENT_PROXY_CONNECTIONS = "prevent-proxy-connections"
    RESOURCE_PACK = "resource-pack"
    ENTITY_BROADCAST_RANGE_PERCENTAGE = "entity-broadcast-range-percentage"
    RCON_PASSWORD = "rcon.password"
    PLAYER_IDLE_TIMEOUT = "player-idle-timeout"
    FORCE_GAMEMODE = "force-gamemode"
    RATE_LIMIT = "rate-limit"
    HARDCORE = "hardcore"
    WHITE_LIST = "white-list"
    BROADCAST_CONSOLE_TO_OPS = "broadcast-console-to-ops"
    SPAWN_NPCS = "spawn-npcs"
    SPAWN_ANIMALS = "spawn-animals"
    SNOOPER_ENABLED = "snooper-enabled"
    FUNCTION_PERMISSION_LEVEL = "function-permission-level"
    LEVEL_TYPE = "level-type"
    SPAWN_MONSTERS = "spawn-monsters"
    ENFORCE_WHITELIST = "enforce-whitelist"
    RESOURCE_PACK_SHA1 = "resource-pack-sha1"
    SPAWN_PROTECTION = "spawn-protection"
    MAX_WORLD_SIZE = "max-world-size"


separator = "="
for line in fileinput.input("/McMyAdmin/Minecraft/server.properties", inplace=True):
    if line[:1] != "#" and separator in line:
        # split property name, and value based on separator
        property_name_in_file, value = line.split(separator, 1)
        if property_name_in_file in [e.value for e in EnvironmentToMinecraftPropertiesMapping]:
            print('{}{}{}'.format(property_name_in_file,
                                  separator,
                                  os.environ[EnvironmentToMinecraftPropertiesMapping(property_name_in_file).name]
                                  ), end='')