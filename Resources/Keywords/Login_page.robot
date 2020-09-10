*** Settings ***
Library  WebHandling
Variables  Resources/Data_test/Log_in_page_data.py
Resource  ../Locator/Log_in_page_locator.robot

*** Keywords ***
User input user name
    [Arguments]  ${username}
    Input Text   ${USER_NAME_TEXT}   ${username}

User input password
    [Arguments]  ${password}
    Input Text   ${PASSWORD_TEXT}   ${password}

User click login button
    Click Button  ${LOGIN_BUTTON}
    Wait For Login

Verify '${page_title}' Header Is Displayed
    ${header} =  run keyword if  '${page_title}' != 'Products'  get text element  ${SUB_HEADER_LABLE}  ELSE  get text element  ${LOGIN_SUCCESS_LABLE}
    Log   ${header}
    Should Be Equal  ${page_title}   ${header}
