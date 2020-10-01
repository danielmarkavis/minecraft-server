"""
This is just a demo, but it gives an overview on how should this be achieved.
"""


import fileinput
import os

# todo: enum?
jrebel_home_var_name = 'JREBEL_HOME'
jrebel_home_var_value = os.environ[jrebel_home_var_name]
jrebel_home_var_new_value = "new/value"
separator = "="
#keys = {}

for line in fileinput.input("test.properties", inplace=True):
    if line[:1] != "#" and separator in line:
        # split property name, and value based on separator
        name, value = line.split(separator, 1)
        if name == jrebel_home_var_name.replace("_", "-").lower():
            print('{}{}{}'.format(name, separator, jrebel_home_var_new_value), end='')

        # Assign key-value pair to dictionary (and strip the whitespaces at the end of strings)
        #keys[name.strip()] = value.strip()

#print(keys)

"""
content of test.properties (it needs to be in the same folder as the script)

#comment
jrebel-home=/Users/matej/Library/Application Support/IntelliJIdea2018.2/jr-ide-idea/lib/jrebel6

"""
