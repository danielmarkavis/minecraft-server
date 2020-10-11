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


def get_latest_download_link() -> str:
    # Get correct url and open the page
    url = "https://mcversions.net/"
    print(f"Opening url: {url}")
    browser.get(url)
    sleep(5)

    releases_rows_xpath = "//div[contains(@class, 'versions')]//div//h5"
    releases_rows_elements = browser.find_elements_by_xpath(releases_rows_xpath)
    for row in releases_rows_elements:
        if "stable releases" in str(row.text).lower():
            latest_release_mark_xpath = ".." \
                                        "//div[contains(@class, 'items')]" \
                                        "//div[contains(@class, 'item')]" \
                                        "//div[contains(@class, 'info')]" \
                                        "//span[contains(@class, 'latest')]"
            latest_release_mark_element = row.find_element_by_xpath(latest_release_mark_xpath)
            if "latest release" in str(latest_release_mark_element.text).lower():
                latest_release_download_link_xpath = ".." \
                                                     "//.." \
                                                     "//a[contains(@class, 'button')]"
                latest_release_download_link_element = latest_release_mark_element \
                    .find_element_by_xpath(latest_release_download_link_xpath)
                return f"{url}{str(latest_release_download_link_element.get_attribute('href'))}"


def get_version_download_link() -> str:
    return f"https://mcversions.net/download/{os.environ['MINECRAFT_VERSION']}"


try:
    # Get download page
    if str(os.environ['MINECRAFT_VERSION']) == "latest":
        download_link = get_latest_download_link()
    else:
        download_link = get_version_download_link()

    # Find download box for latest release of Forge
    print(download_link)
    browser.get(download_link)
    sleep(5)

    download_buttons_xpath = "//div[contains(@class, 'downloads')]" \
                             "//div[contains(@class, 'download')]"
    download_button_elements = browser.find_elements_by_xpath(download_buttons_xpath)
    for download_button in download_button_elements:
        if "server jar" in str(download_button.find_element_by_tag_name("h5").text).lower():
            direct_download_link = str(download_button.find_element_by_tag_name("a").get_attribute("href"))
            print(f"Link scraped is {direct_download_link}")

            # Execute bash scripts to download and place the jar in a correct place
            file_path = "/McMyAdmin/Minecraft/minecraft_server.jar"
            execute_bash_command(f'mv {file_path} {file_path}_backup')
            execute_bash_command(f'wget -O {file_path} {direct_download_link}')

except:
    # PEP 8: E722 do not use bare 'except'
    # I am such a hooligan for not following the rules
    print("***** An error occurred!")
finally:
    # Close browser
    browser.quit()
