*** Settings ***
Documentation        Post User Tests

Resource            ${EXECDIR}${/}API${/}Request${/}api_helper.resource
Resource            ${EXECDIR}${/}API${/}Request${/}create_asset.resource
Variables           ${EXECDIR}${/}Static${/}Data${/}${EXECUTION_ENV}${/}Asset${/}Create_Asset_200_Status_Code.yaml

Test Template    Validate POST Asset

*** Test Cases ***                        DATA
Create Asset - 200 Status Code             ${Create_Asset_200_Status_Code}
    [Documentation]    Verify Create Asset endpoint is returning a 
    ...    200 status code for valid scenario
    [Tags]    123459
    [Setup]    Authentication Preconditions    ${Create_Asset_200_Status_Code}


*** Keywords ***
Validate POST Asset
    [Documentation]    Validate Create Asset endpoint
    [Arguments]    ${data}
    Post Create Asset     ${data}
    Verify Post Asset Schema    ${data}
    Verify Post Asset 200 Status Code Response    ${data}
