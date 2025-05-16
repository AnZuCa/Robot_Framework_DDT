*** Settings ***
Documentation        Post User Tests

Resource            ${EXECDIR}${/}API${/}Request${/}api_helper.resource
Resource            ${EXECDIR}${/}API${/}Request${/}create_user.resource
Variables           ${EXECDIR}${/}Static${/}Data${/}${EXECUTION_ENV}${/}User${/}Create_User_200_Status_Code.yaml
Variables           ${EXECDIR}${/}Static${/}Data${/}${EXECUTION_ENV}${/}User${/}Create_User_400_Status_Code.yaml

Test Template    Validate POST User

*** Test Cases ***                        DATA
Create User - 200 Status Code             ${Create_User_200_Status_Code}
    [Documentation]    Verify Create User endpoint is returning a 
    ...    200 status code for valid scenario
    [Tags]    12345
   # [Setup]    Authentication Preconditions    data=${data}

Create User - 400 Status Code             ${Create_Duplicated_User}
    [Documentation]    Verify Create User endpoint is returning a 
    ...    400 status code for duplicated users
    [Tags]    123456

*** Keywords ***
Validate POST User
    [Documentation]    Validate Create User endpoint
    [Arguments]    ${data}
    Post Create User     ${data}
    Verify Post User Schema    ${data}

