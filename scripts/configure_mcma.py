import enum
import fileinput
import os
import stat


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
os.chmod("/McMyAdmin/McMyAdmin.conf",
         stat.S_IRUSR |
         stat.S_IWUSR |
         stat.S_IRGRP |
         stat.S_IWGRP |
         stat.S_IROTH)
for line in fileinput.input("/McMyAdmin/McMyAdmin.conf", inplace=True):
    if line[:1] != "#" and separator in line:
        # split property name, and value based on separator
        property_name_in_file, value = line.split(separator, 1)
        if property_name_in_file in [e.value for e in EnvironmentToMcmaMapping]:
            print('{}{}{}'.format(property_name_in_file,
                                  separator,
                                  os.environ[EnvironmentToMcmaMapping(property_name_in_file).name]), end='\n')
    else:
        print(line)
