from common.bash_utils import apply_configuration_to_file
from common.configuration_enums import EnvironmentToMcmaMapping

apply_configuration_to_file("/McMyAdmin/McMyAdmin.conf", EnvironmentToMcmaMapping)
