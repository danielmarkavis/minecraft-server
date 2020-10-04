import enum
import fileinput
import os


class EnvironmentToMcmaMapping(enum.Enum):
    """
    Mapping of environment variable names and names of properties in McMyAdmin.conf file
    """
    WEBSERVER_PORT = "Webserver.Port"
    JAVA_PATH = "Java.Path"
    JAVA_MEMORY = "Java.Memory"
    JAVA_GC = "Java.GC"
    JAVA_CUSTOM_OPTS = "Java.CustomOpts"


separator = "="
for line in fileinput.input("/McMyAdmin/McMyAdmin.conf", inplace=True):
    if line[:1] != "#" and separator in line:
        # split property name, and value based on separator
        property_name_in_file, value = line.split(separator, 1)
        if property_name_in_file in [e.value for e in EnvironmentToMcmaMapping]:
            print('{}{}{}'.format(property_name_in_file,
                                  separator,
                                  os.environ[EnvironmentToMcmaMapping(property_name_in_file).name]), end='')
