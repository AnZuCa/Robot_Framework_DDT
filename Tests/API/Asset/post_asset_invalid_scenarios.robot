*** Settings ***
Documentation        Post User Tests

Resource            ${EXECDIR}${/}API${/}Request${/}api_helper.resource
Resource            ${EXECDIR}${/}API${/}Request${/}create_asset.resource
Variables           ${EXECDIR}${/}Static${/}Data${/}${EXECUTION_ENV}${/}Asset${/}Create_Asset_401_Status_Code.yaml
Variables           ${EXECDIR}${/}Static${/}Data${/}${EXECUTION_ENV}${/}Asset${/}Create_Asset_422_Status_Code.yaml

Test Template    Validate POST Asset

*** Test Cases ***                        DATA
Create Asset - 401 Status Code             ${Create_Asset_401_Status_Code}
    [Documentation]    Verify Create Asset endpoint is returning a 
    ...    401 status code for a non authorized request
    [Tags]    123456
    [Setup]    Authentication Preconditions    ${Create_Asset_401_Status_Code}

Create Asset - 422 Status Code             ${Create_Asset_422_Status_Code}
    [Documentation]    Verify Create Asset endpoint is returning a 
    ...    422 status code for an unprocessable Entity
    [Tags]    123457
    [Setup]    Authentication Preconditions    ${Create_Asset_422_Status_Code}

*** Keywords ***
Validate POST Asset
    [Documentation]    Validate Create Asset endpoint
    [Arguments]    ${data}
    Post Create Asset     ${data}
    Verify Post Asset Schema    ${data}
    Verify Post Asset Response    ${data}
