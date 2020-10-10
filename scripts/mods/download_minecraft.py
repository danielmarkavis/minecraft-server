from time import sleep

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.support import expected_conditions as ec
from selenium.webdriver.support.ui import WebDriverWait

# Open Firefox browser
capabilities = DesiredCapabilities().FIREFOX
capabilities["marionette"] = True
options = Options()
options.headless = False  # todo: change to True when everything is finished
options.add_argument("--disable-notifications")
options.add_argument("disable-infobars")
browser = webdriver.Firefox(capabilities=capabilities, options=options)
browser.implicitly_wait(10)  # wait 10 seconds for all DOM elements

# Open the page
browser.get("https://files.minecraftforge.net/maven/net/minecraftforge/forge/index_1.14.2.html")
sleep(5)

download_box_latest = browser.find_element_by_tag_name("body") \
    .find_element_by_xpath("//div[contains(@class, 'downloads')]") \
    .find_element_by_xpath("//div[contains(@class, 'download')]") \
    .find_element_by_xpath("//div[contains(@class, 'title')]")

if "download latest" in str(download_box_latest.text).lower():
    download_box_latest.find_element_by_xpath("..")\
        .find_element_by_xpath("//div[contains(@class, 'links')]")\
        .find_element_by_xpath("//div[contains(@class, 'link')//a//i//span[(contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'universal'))]]")

sleep(5)
