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
    User Click On Shopping Cart Icon
    Verify that product items have been added to cart must be displayed into shopping cart   ${lProduct_items}

TC_03
    [Documentation]  Verify that shopping cart is empty when user remove product items into shopping cart page
    [Tags]  REG3
    [Setup]  Open Browser And Login To Application
    [Teardown]  Close All Browser

    User Add Product Items To Cart  ${lProduct_items}
    User Click On Shopping Cart Icon
    User Remove '${lProduct_items}' On 'Shopping Cart' Page
    Verify That '${lProduct_items}' Deleted From 'Shopping Cart' Successfully

TC_04
    [Documentation]  Verify that shopping cart is empty when user remove product items into product items page
    [Tags]  REG4
    [Setup]  Open Browser And Login To Application
    [Teardown]  Close All Browser

    User Add Product Items To Cart  ${lProduct_items}
    User Click On Shopping Cart Icon
    Verify that product items have been added to cart must be displayed into shopping cart   ${lProduct_items}
    User Click On 'Continue Shopping'
    User Remove '${lProduct_items}' On 'Product Items' Page
    User Click On Shopping Cart Icon
    Verify That '${lProduct_items}' Deleted From 'Shopping Cart' Successfully

TC_05
    [Documentation]  Verify that shopping cart is empty when user remove product items into product details page
    [Tags]  REG5
    [Setup]  Open Browser And Login To Application
    [Teardown]  Close All Browser


Test Debug
    [Documentation]  Verify that shopping cart is empty when user remove product items into product details page
    [Tags]  REG5
    [Setup]  Open Browser And Login To Application
    [Teardown]  Close All Browser

    sleep  3
    test locator    xpath://div[@class='pricebar']   2   //button[contains(@class,'btn_secondary btn_inventory')]
    sleep  4

*** Keywords ***

