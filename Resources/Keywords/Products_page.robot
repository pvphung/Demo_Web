*** Settings ***
Library  WebHandling
Variables  Resources/Data_test/Log_in_page_data.py
Resource  Resources/Locator/Product_page_locator.robot

*** Keywords ***
Get info of a product
    [Arguments]  ${product_name}
    ${test} =  get all product  ${ALL_ITEM_NAME_TEXT}
    ${index} =  run keyword and continue on failure  get index product by name  ${ALL_ITEM_NAME_TEXT}  ${product_name}
    ${desc_info} =  run keyword and continue on failure  get text element   ${DESC_ITEM_NAME_TEXT}   index=${index}
    ${rice_info} =  run keyword and continue on failure  get text element   ${PRICE_ITEM_NAME_TEXT}  index=${index}
