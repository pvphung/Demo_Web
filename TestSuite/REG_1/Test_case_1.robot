*** Settings ***
Variables  ../Data_test/Log_in_page_data.py
Resource  Resources/Keywords/Common.robot
Resource  Resources/Keywords/Products_page.robot


*** Test Cases ***
TC_01
    [Documentation]    Verify that info of product item is diplayed corect in product detail
    [Tags]     REG1
    [Setup]  Open Browser And Login To Application
    [Teardown]   Close All Browser

    Get info of a product  Sauce Labs Bike Light
    User Click On 'Sauce Labs Bike Light'
    Verify that info of 'Sauce Labs Bike Light' is diplayed corect in product detail

TC_02
    [Documentation]  Verify that product items have been added to cart must be displayed into shopping cart
    [Tags]  REG2
    [Setup]  Open Browser And Login To Application
    [Teardown]  Close All Browser

    User Add Product Items To Cart  ${lProduct_items}
#    User Click On Shopping Cart Icon
#    Verify that product items have been added to cart must be displayed into shopping cart   ${lProduct_items}


*** Keywords ***

