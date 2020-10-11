import os
import pipes
from time import sleep
import sys

from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.firefox.options import Options

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
    # Open the page
    url = f"https://files.minecraftforge.net/maven/net/minecraftforge/forge/index_{os.environ['MINECRAFT_VERSION']}.html"
    if str(os.environ['MINECRAFT_VERSION']) == "latest":
        url = "http://files.minecraftforge.net/"

    print(f"Opening url: {url}")
    browser.get(url)
    sleep(5)

    download_box_latest = browser.find_element_by_tag_name("body") \
        .find_element_by_xpath("//div[contains(@class, 'downloads')]") \
        .find_element_by_xpath("//div[contains(@class, 'download')]") \
        .find_element_by_xpath("//div[contains(@class, 'title')]")

    if "download latest" in str(download_box_latest.text).lower():
        universal_box_xpath = ".." \
                              "//div[contains(@class, 'links')]" \
                              "//div[contains(@class, 'link')]" \
                              "//a" \
                              "//span[contains(text(), 'Universal')]"
        universal_box_element = download_box_latest.find_element_by_xpath(universal_box_xpath)
        universal_download_url = universal_box_element.find_element_by_xpath("..").get_attribute("href")
        direct_download_link = "https://" + str(universal_download_url).split("https://", 2)[2]

        # print(f"Setting {direct_download_link} as value of MINECRAFT_FORGE_SERVER_DOWNLOAD_LINK environment variable")
        # os.environ["MINECRAFT_FORGE_SERVER_DOWNLOAD_LINK"] = str(direct_download_link)
        # print("export MINECRAFT_FORGE_SERVER_DOWNLOAD_LINK=%s" % (pipes.quote(str(direct_download_link))))

        print(str(direct_download_link))
        sys.exit(0)
except:
    print("***** An error occurred!")
finally:
    # Close browser
    browser.quit()
