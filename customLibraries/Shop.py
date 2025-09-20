from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn

@library
class Shop:

    def __init__(self): #contructor
        self._sel = None

    def _selenium(self):
        if self._sel is None:
            self._sel = BuiltIn().get_library_instance("SeleniumLibrary")
        return self._sel
    
    @keyword("Add Items To Cart")
    def add_items_to_cart(self, *productsList):
        sel = self._selenium()
        #   @{title_elements}=    Get WebElements    css:.card-title
        i = 1
        title_elements = sel.get_webelements("css:.card-title")
        for title_element in title_elements:
            title = title_element.text.strip()
            if title in productsList:
                #sel.click_button("xpath:(//*[@class='card-footer'])["+str(i)+"]/button")
                button = title_element.find_element("xpath", "../following-sibling::div//button[normalize-space()='Add']")
                button.click()
        i = i + 1
       



