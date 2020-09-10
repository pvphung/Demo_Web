*** Settings ***
Library  WebHandling
Variables  Resources/Data_test/Log_in_page_data.py
Resource  Resources/Locator/Product_page_locator.robot

*** Keywords ***
#Keyword Action
User Click On '${item}' ${type_item}
    click element by contain  ${item}

User Click On Shopping Cart Icon
    Click Element  ${SHOPPING_CART_ICON}
    sleep  2

User Remove '${product_item}' On '${name_page}' Page
    ${data_type}  Evaluate     type($product_item).__name__
    ${products} =  run keyword if  ${data_type} == str  create list  ${product_item}  ELSE   set variable   ${product_item}
    :FOR  ${item}  IN  @{products}
     \   Log  ${item}
     \   ${index} =  run keyword if   '${name_page}' != 'Product Details'   get index product by name  ${ALL_ITEM_NAME_TEXT}  ${item}
     \   run keyword if   ${index} == ${None}  click element    ${REMOVE_BUTTON}   ELSE IF   '${name_page}' == 'Product Items'   click element by child    loc_parent=xpath://div[@class='pricebar']  loc_child=${PRODUCT_ITEM_REMOVE}  index_parent=${index}   ELSE      click element enh    ${REMOVE_BUTTON}     ${index}
     \   sleep  2


User Add Product Items To Cart
    [Arguments]     ${product_item}
    ${data_type}  Evaluate     type($product_item).__name__
    ${products} =  run keyword if  ${data_type} == str  create list  ${product_item}  ELSE   set variable   ${product_item}
    :FOR  ${item}  IN  @{products}
     \   Log  ${item}
     \   ${index} =  run keyword and continue on failure   get index product by name  ${ALL_ITEM_NAME_TEXT}  ${item}
     \   run keyword and continue on failure   click element enh    ${ADD_TO_CART_BUTTON}     ${index}
     \   sleep  3

#keyword GET
Get info of a product
    [Arguments]  ${product_name}
    ${all_product_items} =  get all product  ${ALL_ITEM_NAME_TEXT}
    ${index} =  run keyword and continue on failure  get index product by name  ${ALL_ITEM_NAME_TEXT}  ${product_name}
    ${desc_info} =  run keyword and continue on failure  get text element    ${DESC_ITEM_NAME_TEXT}   index=${index}
    ${price_info} =  run keyword and continue on failure  get text element   ${PRICE_ITEM_NAME_TEXT}  index=${index}
    ${dict_item} =  Create Dictionary    product_name=${product_name}    desc=${desc_info}   price=${price_info}
    log  ${dict_item}
    set test variable   ${dict_item}
    [Return]   ${dict_item}

Get info of a product detail
    [Arguments]  ${product_name}
    ${desc_info_detail} =  run keyword and continue on failure  get text element    ${DESC_ITEM_NAME_DETAIL_TEXT}
    ${price_info_detail} =  run keyword and continue on failure  get text element   ${PRICE_ITEM_NAME_DETAIL_TEXT}
    ${dict_detail} =  Create Dictionary    product_name=${product_name}    desc=${desc_info_detail}   price=${price_info_detail}
    log  ${dict_detail}
    set test variable   ${dict_detail}
    [Return]   ${dict_detail}

    #Verify Keywords
Verify that info of '${product}' is diplayed corect in product detail
     ${product_detail} =  Get info of a product detail  ${product}
     should be equal  ${dict_item}   ${product_detail}

Verify that product items have been added to cart must be displayed into shopping cart
    [Arguments]  ${list_product_items}
    ${all_products_in_cart} =   get all product  ${ALL_ITEM_NAME_TEXT}
    should be equal  ${list_product_items}   ${all_products_in_cart}

Verify That '${product_item}' Deleted From '${name_page}' Successfully
    ${data_type}  Evaluate     type($product_item).__name__
    ${products} =  run keyword if  ${data_type} == str  create list  ${product_item}  ELSE   set variable   ${product_item}
    ${products_in_cart} =   get all product  ${ALL_ITEM_NAME_TEXT}
    list should not contain sub list    ${products_in_cart}   ${products}