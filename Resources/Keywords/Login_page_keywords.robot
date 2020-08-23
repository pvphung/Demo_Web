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

Verify login successfully
    ${title} =  get title
    ${title_2} =  get title handler  ${LOGIN_SUCCESS_LABLE}
    log   ${title_2}
    Log   ${title}
    Title Should Be  Swag Labs
    Should Be Equal  ${login_success}   ${title_2}
