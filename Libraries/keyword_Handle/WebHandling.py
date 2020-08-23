from LoginPagesCustomKeywords import LoginPagesCustomKeywords
from WaitTimeHandler import WaitTimeHandler
from SeleniumLibrary import SeleniumLibrary

__version__ = "1.0.0"


class WebHandling(SeleniumLibrary):
    """
    Class to combine wrapped libraries
    """
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        SeleniumLibrary.__init__(self, timeout=90)
        self.add_library_components([LoginPagesCustomKeywords(self), WaitTimeHandler(self)])
