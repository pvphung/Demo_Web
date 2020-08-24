*** Settings ***
Variables  ../Data_test/Log_in_page_data.py
Resource  Resources/Keywords/Common.robot


*** Test Cases ***
Sample Test Case
    [Documentation]    Example test case
    [Tags]     REG1
    [Setup]  Open Browser And Login To Application
    [Teardown]   Close All Browser

    wait for loading

*** Keywords ***
wait for loading
    Sleep  10s
