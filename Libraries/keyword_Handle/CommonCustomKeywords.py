try:
    from SeleniumLibrary.base import keyword, LibraryComponent
    from SeleniumLibrary.keywords import BrowserManagementKeywords
    from SeleniumLibrary.keywords import WaitingKeywords
    from selenium.webdriver.chrome.webdriver import WebDriver as Chrome
    from selenium.webdriver.firefox.webdriver import WebDriver as Firefox
    from selenium import webdriver
    from selenium.webdriver import DesiredCapabilities
    from SeleniumLibrary.keywords import window
    import os
    import time

    from selenium.common.exceptions import NoAlertPresentException, WebDriverException

except ImportError as imp_err:
    print('Errors in importing files - From %s' % __file__)
    print('\n---{{{ Failed - ' + format(imp_err) + ' }}}---\n')
    raise


class CommonCustomKeywords(LibraryComponent):

    def __init__(self, ctx):
        LibraryComponent.__init__(self, ctx)
        self.waiting_management = WaitingKeywords(ctx)
        self.browser_management = BrowserManagementKeywords(ctx)
        self.windows_management = window.WindowKeywords(ctx)

    def get_text_element(self, locator):
        text = self.find_element(locator).text
        return text

    def get_text_elements(self, locator):
        list_text = [el.text for el in self.find_elements(locator)]
        return list_text

    @keyword
    def get_text_element(self, locator):
        text = self.find_element(locator).text
        return text

    @keyword
    def get_text_elements(self, locator):
        list_text = [el.text for el in self.find_elements(locator)]
        return list_text

    @keyword
    def get_all_product(self, locator):
        lProduct = self.get_text_elements(locator)
        return lProduct

