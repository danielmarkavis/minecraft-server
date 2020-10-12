import fileinput
import os
import stat
import subprocess

from common.configuration_enums import EnvironmentToMcmaMapping
from common.configuration_enums import EnvironmentToMinecraftPropertiesMapping

config_file_key_value_separator = "="


def execute_bash_commands(commands: []):
    for command in commands:
        command_for_print = " ".join(command)
        print(f"***** Executing command: {command_for_print}")
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output, error = process.communicate()
        print(f"***** Output: {output}")
        print(f"***** Error: {error}")
        print(f"***** Execution of {command_for_print} is done!\n")


def apply_configuration_to_file(file_path_to_configure: str, enum_mapping_type: type):
    os.chmod(file_path_to_configure,
             stat.S_IRUSR |
             stat.S_IWUSR |
             stat.S_IRGRP |
             stat.S_IWGRP |
             stat.S_IROTH)

    for line in fileinput.input(file_path_to_configure, inplace=True):
        if line[:1] != "#" and config_file_key_value_separator in line:
            # split property name, and value based on separator
            property_name_in_file, value = line.split(config_file_key_value_separator, 1)

            if enum_mapping_type is EnvironmentToMcmaMapping:
                configure_mcma_conf(property_name_in_file)
            elif enum_mapping_type is EnvironmentToMinecraftPropertiesMapping:
                configure_minecraft_properties(property_name_in_file)
            else:
                print("***** Unrecognized enum type. Doing nothing...")
                break
        else:
            print(line)


def configure_mcma_conf(property_name_in_file: str):
    if property_name_in_file in [e.value for e in EnvironmentToMcmaMapping]:
        print('{}{}{}'.format(property_name_in_file,
                              config_file_key_value_separator,
                              os.environ[EnvironmentToMcmaMapping(property_name_in_file).name]),
              end='\n')


def configure_minecraft_properties(property_name_in_file: str):
    if property_name_in_file in [e.value for e in EnvironmentToMinecraftPropertiesMapping]:
        print('{}{}{}'.format(property_name_in_file,
                              config_file_key_value_separator,
                              os.environ[EnvironmentToMinecraftPropertiesMapping(property_name_in_file).name]),
              end='\n')
