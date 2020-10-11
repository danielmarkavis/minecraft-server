import os
import subprocess
from time import sleep

from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.firefox.options import Options


def execute_bash_command(command: str):
    process = subprocess.Popen(command.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    print(output)
    print(error)


# Open Firefox browser
capabilities = DesiredCapabilities().FIREFOX
capabilities["marionette"] = True
options = Options()
options.headless = True
options.add_argument("--disable-notifications")
options.add_argument("disable-infobars")
browser = webdriver.Firefox(capabilities=capabilities, options=options)
browser.implicitly_wait(10)  # wait 10 seconds for all DOM elements

try:
    # Get correct url and open the page
    url = f"https://files.minecraftforge.net/maven/net/minecraftforge/forge/index_{os.environ['MINECRAFT_VERSION']}.html"
    if str(os.environ['MINECRAFT_VERSION']) == "latest":
        url = "http://files.minecraftforge.net/"

    print(f"Opening url: {url}")
    browser.get(url)
    sleep(5)

    # Find download box for latest release of Forge
    download_box_latest = browser.find_element_by_tag_name("body") \
        .find_element_by_xpath("//div[contains(@class, 'downloads')]") \
        .find_element_by_xpath("//div[contains(@class, 'download')]") \
        .find_element_by_xpath("//div[contains(@class, 'title')]")

    if "download latest" in str(download_box_latest.text).lower():
        # Find the box containing installer download and extract the direct link (without ads)
        installer_box_xpath = ".." \
                              "//div[contains(@class, 'links')]" \
                              "//div[contains(@class, 'link')]" \
                              "//a" \
                              "//span[contains(text(), 'Installer')]"
        installer_box_element = download_box_latest.find_element_by_xpath(installer_box_xpath)
        installer_download_url = installer_box_element.find_element_by_xpath("..").get_attribute("href")
        direct_download_link = "https://" + str(installer_download_url).split("https://", 2)[2]

        # Execute bash scripts to download and place the jar in a correct place
        file_path_to_backup = "/McMyAdmin/Minecraft/minecraft_server.jar"
        installer_file_path = "/McMyAdmin/Minecraft/forge-installer.jar"
        forge_mod_file_path = "/McMyAdmin/Minecraft/ForgeMod.jar"
        execute_bash_command(f'mv {file_path_to_backup} {file_path_to_backup}_backup')
        execute_bash_command(f'wget -O {installer_file_path} {direct_download_link}')
        execute_bash_command(f'java -jar {installer_file_path} --installServer')
        execute_bash_command(f'rm {installer_file_path}')
        execute_bash_command(f'mv forge-*.jar {forge_mod_file_path}')

except:
    # PEP 8: E722 do not use bare 'except'
    # I am such a bad boy for not following the rules
    print("***** An error occurred!")
finally:
    # Close browser
    browser.quit()
