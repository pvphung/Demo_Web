*** Settings ***
Library  WebHandling
Variables  Resources/Data_test/Log_in_page_data.py
Variables  Resources/Data_test/Checkout_page_data.py
Resource  ../Locator/Checkout_page_locator.robot

*** Keywords ***
User Input Fist Name
    [Arguments]  ${fist_name}
    Input Text   ${FIST_NAME_TEXT_BOX}   ${fist_name}

User Input Last Name
    [Arguments]  ${last_name}
    Input Text   ${LAST_NAME_TEXT_BOX}   ${last_name}

User Input Zip Code
    [Arguments]  ${zip_name}
    Input Text   ${ZIP_CODE_TEXT_BOX}   ${zip_name}

User Click On CONTINUE Button
    Click Button  CONTINUE

Verify Error Message '${error_mesasge}' Is Displayed
    Page Should Contain   ${error_mesasge}