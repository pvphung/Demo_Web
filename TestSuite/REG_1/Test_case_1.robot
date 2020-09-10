*** Settings ***
Variables  ../Data_test/Log_in_page_data.py
Resource  Resources/Keywords/Common.robot
Resource  Resources/Keywords/Products_page.robot
Resource  Resources/Keywords/Checkout_page.robot


*** Test Cases ***
TC_01
    [Documentation]    Verify that info of product item is diplayed corect in product detail
    [Tags]     REG1
    [Setup]  Open Browser And Login To Application
    [Teardown]   Close All Browser

    Given Get info of a product  Sauce Labs Bike Light
    When User Click On 'Sauce Labs Bike Light' product
    Then Verify that info of 'Sauce Labs Bike Light' is diplayed corect in product detail

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
    User Click On 'Continue Shopping' button
    User Remove '${lProduct_items}' On 'Product Items' Page
    User Click On Shopping Cart Icon
    Verify That '${lProduct_items}' Deleted From 'Shopping Cart' Successfully

TC_05
    [Documentation]  Verify that product in shopping cart is removed when user remove product items from product details page
    [Tags]  REG5
    [Setup]  Open Browser And Login To Application
    [Teardown]  Close All Browser

    User Add Product Items To Cart  ${lProduct_items}
    User Click On Shopping Cart Icon
    Verify that product items have been added to cart must be displayed into shopping cart   ${lProduct_items}
    User Click On 'Continue Shopping' button
    User Click On 'Sauce Labs Bolt T-Shirt' product
    User Remove 'Sauce Labs Bolt T-Shirt' On 'Product Details' Page
    User Click On Shopping Cart Icon
    Verify That 'Sauce Labs Bolt T-Shirt' Deleted From 'Shopping Cart' Successfully

TC_06
    [Documentation]  Verify that user can not checkout when user input invalid information at checkout page
    [Tags]  REG5
    [Setup]  Open Browser And Login To Application
    [Teardown]  Close All Browser

    User Add Product Items To Cart  ${lProduct_items}
    User Click On Shopping Cart Icon
    Verify that product items have been added to cart must be displayed into shopping cart   ${lProduct_items}
    User Click On 'CHECKOUT' button
    Verify 'Checkout: Your Information' Header Is Displayed
    Checkout_page.User Input Fist Name    ${EMPTY}
    Checkout_page.User Input Last Name    ${sLast_Name}
    Checkout_page.User Input Zip Code     ${sZip_Code}
    User Click On CONTINUE button
    Checkout_page.Verify Error Message 'First Name is required' Is Displayed
    Checkout_page.User Input Fist Name    ${sFist_Name}
    Checkout_page.User Input Last Name    ${EMPTY}
    Checkout_page.User Input Zip Code     ${sZip_Code}
    User Click On CONTINUE button
    Checkout_page.Verify Error Message 'Last Name is required' Is Displayed
    Checkout_page.User Input Fist Name    ${sFist_Name}
    Checkout_page.User Input Last Name    ${sLast_Name}
    Checkout_page.User Input Zip Code     ${EMPTY}
    User Click On CONTINUE button
    Checkout_page.Verify Error Message 'Postal Code is required' Is Displayed

TC_07
    [Documentation]  Verify that user can cancel payment at checkout page
    [Tags]  REG5
    [Setup]  Open Browser And Login To Application
    [Teardown]  Close All Browser

    Given User Add Product Items To Cart  ${lProduct_items}
    When User Click On Shopping Cart Icon
    Then Verify that product items have been added to cart must be displayed into shopping cart   ${lProduct_items}
    When User Click On 'CHECKOUT' button
    Then Verify 'Checkout: Your Information' Header Is Displayed
    When Checkout_page.User Input Fist Name    ${sFist_Name}
    And Checkout_page.User Input Last Name    ${sLast_Name}
    And Checkout_page.User Input Zip Code     ${sZip_Code}
    And User Click On CONTINUE button
    Then Verify 'Checkout: Overview' Header Is Displayed
    When User Click On 'CANCEL' button
    Then Verify 'Products' Header Is Displayed
    When User Click On Shopping Cart Icon
    Then Verify that product items have been added to cart must be displayed into shopping cart   ${lProduct_items}

TC_08
    [Documentation]  Verify that user payment product items Successfully
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

