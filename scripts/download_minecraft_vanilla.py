import os
from time import sleep

from common.bash_utils import execute_bash_commands
from common.web_utils import get_firefox_browser

# Get browser
browser = get_firefox_browser()


def get_latest_download_link() -> str:
    # Get correct url and open the page
    url = "https://mcversions.net/"
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


def get_direct_download_link() -> str:
    # Get download page
    if str(os.environ['MINECRAFT_VERSION']) == "latest":
        download_link = get_latest_download_link()
    else:
        download_link = get_version_download_link()

    # Find download box for latest release of Forge
    print(f"Opening url: {download_link}")
    browser.get(download_link)
    sleep(5)

    for a in browser.find_elements_by_tag_name("a"):
        if str(a.get_attribute("download")).startswith("minecraft_server-"):
            return str(a.get_attribute("href"))


# MAIN CODE #
try:
    # Get direct download link
    direct_download_link = get_direct_download_link()
    print(f"Link scraped is {direct_download_link}")

    # Execute bash scripts to download and place the jar in a correct place
    file_path = "/McMyAdmin/Minecraft/minecraft_server.jar"
    commands = [
        ["mv", file_path, f"{file_path}_backup"],
        ["wget", "-O", file_path, direct_download_link]
    ]
    execute_bash_commands(commands)
except:
    # PEP 8: E722 do not use bare 'except'
    # I am such a hooligan for not following the rules
    print("***** An error occurred!")
finally:
    # Close browser
    browser.quit()
