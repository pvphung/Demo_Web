try:
    from SeleniumLibrary.base import keyword, LibraryComponent
    from SeleniumLibrary.keywords import BrowserManagementKeywords
    from SeleniumLibrary.keywords import WaitingKeywords
    from selenium.webdriver.chrome.webdriver import WebDriver as Chrome
    from selenium.webdriver.firefox.webdriver import WebDriver as Firefox
    from selenium import webdriver
    from selenium.webdriver import DesiredCapabilities
    from SeleniumLibrary.keywords import window
    from selenium.webdriver.common.by import By
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
        """
        Find a element and get text
        :param locator:
        :return:
        """
        text = self.find_element(locator).text
        return text

    def get_text_elements(self, locator):
        """
        Find all element and get text
        :param locator:
        :return:
        """
        list_text = [el.text for el in self.find_elements(locator)]
        return list_text

    def find_element_enh(self, locator, index=None):
        """
        Find element with index
        :param locator:
        :param index:
        :return: object element
        """
        loc_type = locator.split(':')[0].lower()
        loc = ''+':'.join(locator.split(':')[1:])
        el = self.driver.find_element(by=loc_type, value="("+format(loc)+")["+format(index)+"]")
        return el

    @keyword
    def get_text_element(self, locator, index=None):
        if index is None:
            text = self.find_element(locator).text
        else:
            text = self.find_element_enh(locator, index=index).text
        return text

    # @keyword
    # def test_locator(self, locator, index=None):
    #     text = self.driver.find_element(by='xpath', value="(//div/div[@class='inventory_item_desc'])[2]").text
    #     text = self.find_element_enh(locator, index=index).text
    #     return text

    @keyword
    def get_text_elements(self, locator):
        list_text = [el.text for el in self.find_elements(locator)]
        return list_text

    @keyword
    def get_all_product(self, locator):
        lProduct = self.get_text_elements(locator)
        self.info(lProduct)
        return lProduct

    @keyword
    def get_index_product_by_name(self, locator, product_name):
        index = self.get_all_product(locator).index(product_name) + 1
        if index:
            return index
        return self.info('Element {0) is not exited'.format(product_name))
