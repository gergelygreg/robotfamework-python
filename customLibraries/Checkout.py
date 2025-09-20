from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn


@library
class Checkout:

    def __init__(self): #contructor
        self._sel = None

    def _selenium(self):
        if self._sel is None:
            self._sel = BuiltIn().get_library_instance("SeleniumLibrary")
        return self._sel
    
    @keyword("Verify Cart Items in Checkout")
    def verify_cart_items_in_checkout(self, *expected_products):
        sel = self._selenium()
        builtin = BuiltIn()


        # Actual cart items
        title_elements = sel.get_webelements("css:h4.media-heading")
        actual_products = [el.text.strip() for el in title_elements]
        print(f"DEBUG - Products in checkout: {actual_products}")

        # given expected products are wrong, backend gives back correct items
        missing = [title_element for title_element in expected_products if title_element not in actual_products]
        if missing:
            builtin.fail(f"Expected products not found in checkout: {missing}.")

        # Unexpected items, Api gives back incorrect items, or Ui displays incorrect items
        unexpected = [title_element for title_element in actual_products if title_element not in expected_products]
        if unexpected:
            builtin.fail(f"Unexpected products in checkout: {unexpected}.")

        print(f"All expected products are in checkout: {expected_products}")  