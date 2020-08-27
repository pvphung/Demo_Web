*** Variables ***
${ALL_ITEM_NAME_TEXT}               xpath://div[@class='inventory_item_name']
${DESC_ITEM_NAME_TEXT}              xpath://div[@class='inventory_item_desc']
${PRICE_ITEM_NAME_TEXT}             xpath://div[@class='inventory_item_price']
#${ADD_TO_CART_BUTTON}               xpath://button[contains(@class,'btn_primary btn_inventory')]
${ADD_TO_CART_BUTTON}               xpath://div[@class='pricebar']/button
${SHOPPING_CART_ICON}               id:shopping_cart_container

${DESC_ITEM_NAME_DETAIL_TEXT}       xpath://div[@class='inventory_details_desc']
${PRICE_ITEM_NAME_DETAIL_TEXT}      xpath://div[@class='inventory_details_price']
${BACK_BUTTON}                      xpath://div[@class='inventory_details_back_button']

