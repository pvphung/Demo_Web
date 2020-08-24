*** Settings ***
# Library
Library  WebHandling

# Variables
Variables  Resources/Data_test/Log_in_page_data.py

#Resource
Resource   ../Keywords/Login_page.robot


*** Keywords ***
Open Browser And Login To Application
    [Arguments]   ${user}=${tUser_Name}    ${password}=${tPassword}    ${url}=${tUrl}
    Open Browser  ${url}    ${tBrowser}
    Maximize Browser Window
    User input user name   ${user}
    User input password    ${password}
    User click login button
    Verify login successfully

Close All Browser
    Close Browser


