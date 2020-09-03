from robot.utils import unic, is_truthy, is_list_like, type_name

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
        loc = '' + ':'.join(locator.split(':')[1:])
        el = self.driver.find_element(by=loc_type, value="(" + format(loc) + ")[" + format(index) + "]")
        return el

    def find_element_by_child(self, locator, index=None, locator_child=None):
        """
        find element child by parent node
        :param locator: locator parent node
        :param index: index parent node
        :param locator_child: locator child node
        :return:
        """
        loc_type = locator_child.split(':')[0].lower()
        loc = '' + ':'.join(locator_child.split(':')[1:])
        if index is None:
            el = self.find_element_enh(locator, index).find_element(by=loc_type, value="(" + format(loc) + ")")
        else:
            el = self.find_element(locator).find_element(by=loc_type, value="(" + format(loc) + ")")
        return el

    # keyword Action _______________________________________________________________________

    @keyword
    def click_element_by_contain(self, contain, index=None):
        if index is None:
            self.driver.find_element(by=By.XPATH, value="(//*[contains(text(),  '" + format(contain) + "')])").click()
        else:
            self.driver.find_element(by=By.XPATH, value="(//*[contains(text(),  '" + format(contain) + "')])[" + format(
                index) + "]").click()

    @keyword
    def click_element_enh(self, locator, index=None):
        self.find_element_enh(locator, index=index).click()

    @keyword
    def click_element_by_child(self, loc_parent, loc_child, index_parent=None):
        self.find_element_by_child(loc_parent, index_parent, loc_child).click()

    # End keyword Action _______________________________________________________________________

    # keyword GET _________________________________________________________________________________

    @keyword
    def get_text_element(self, locator, index=None):
        if index is None:
            text = self.find_element(locator).text
        else:
            text = self.find_element_enh(locator, index=index).text
        return text

    @keyword
    def test_locator(self, locator, index=None, locator_child=None):

        loc_type = locator_child.split(':')[0].lower()
        loc = '' + ':'.join(locator_child.split(':')[1:])
        el = self.find_element_enh(locator, index).find_element(by=loc_type, value="(" + format(loc) + ")")
        return el

    @keyword
    def get_text_elements(self, locator):
        list_text = [el.text for el in self.find_elements(locator)]
        return list_text

    @keyword
    def get_all_product(self, locator):
        lProduct = self.get_text_elements(locator)
        if len(lProduct) == 1:
            self.info(lProduct[0])
            return lProduct[0]
        self.info(lProduct)
        return lProduct

    @keyword
    def get_index_product_by_name(self, locator, product_name):
        index = self.get_all_product(locator).index(product_name) + 1
        if index:
            return index
        return self.info('Element {0) is not exited'.format(product_name))

    # End keyword GET _________________________________________________________________________________

    # Keyword verify
    @keyword
    def list_should_not_contain_sub_list(self, list1, list2, msg=None, values=True):
        """Fails if one of the elements in ``list2`` are found in ``list1``.

        The order of values and the number of values are not taken into
        account.

        See `Lists Should Be Equal` for more information about configuring
        the error message with ``msg`` and ``values`` arguments.
        """
        self._validate_lists(list1, list2)
        diffs = ', '.join(unic(item) for item in list2 if item in list1)
        default = 'Following values were found from first list: ' + diffs
        _verify_condition(not diffs, default, msg, values)

    # END Keyword verify_____________________________________________________________________

    # private Func _____________________________________________________________________

    def _validate_list(self, list_, position=1):
        if not is_list_like(list_):
            raise TypeError("Expected argument %d to be a list or list-like, "
                            "got %s instead." % (position, type_name(list_)))

    def _validate_lists(self, *lists):
        for index, item in enumerate(lists, start=1):
            self._validate_list(item, index)


def _verify_condition(condition, default_msg, msg, values=False):
    if condition:
        return
    if not msg:
        msg = default_msg
    elif is_truthy(values) and str(values).upper() != 'NO VALUES':
        msg += '\n' + default_msg
    raise AssertionError(msg)
