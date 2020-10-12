from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.firefox.webdriver import WebDriver


def get_firefox_browser() -> WebDriver:
    # Open Firefox browser
    capabilities = DesiredCapabilities().FIREFOX
    capabilities["marionette"] = True
    options = Options()
    options.headless = True
    options.add_argument("--disable-notifications")
    options.add_argument("disable-infobars")
    browser: WebDriver = webdriver.Firefox(capabilities=capabilities, options=options)
    browser.implicitly_wait(10)  # wait 10 seconds for all DOM elements

    return browser
