*** Settings ***
Variables  ../Data_test/Log_in_page_data.py
Resource   ../Keywords/Login_page_keywords.robot

*** Test Cases ***
Sample Test Case
    [Documentation]    Example test case
    [Tags]     REG1
    [Setup]  Run Keywords    Open Browser  ${URL}    ${Browser}
             ...   AND       Maximize Browser Window
    [Teardown]   Close Browser

    User input user name   ${User_Name}
    User input password    ${Password}
    User click login button
    Verify login successfully

*** Keywords ***
wait for loading
    Sleep  10s
