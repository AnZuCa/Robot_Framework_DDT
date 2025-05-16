*** Settings ***
Documentation       Assets API Test resources file containing keywords for
...    test scope keywords (e.g. shared test steps, test preconditions, etc.)

Resource            ${EXECDIR}${/}Resources${/}asset_api_common.resource


*** Variables ***
${DEFAULT_ASSETS_API_PASSWORD_NAME} =             DEFAULT_ASSETS_API_PASSWORD_${EXECUTION_ENV}
${DEFAULT_ASSETS_API_PASSWORD} =                  %{${DEFAULT_ASSETS_API_PASSWORD_NAME}}
${AUTHENTICATE_URL} =                             ${Assets_API.base_url}${common_urls.assets_api.login}

*** Keywords ***
###  Individual Precondition Keywords  ###

Authentication Preconditions
    [Documentation]    Precondition steps to authenticate a user.
    [Arguments]    ${data}
    ${preconditions} =    Get From Dictionary    dictionary=${data}    key=Preconditions
    ${password} =    Get From Dictionary If Exists    dictionary=${preconditions}    key=Password    default=${DEFAULT_ASSETS_API_PASSWORD}
    ${user_name} =    Get From Dictionary    dictionary=${preconditions}    key=Username
    ${headers}=  Create Headers    ${None}    application/x-www-form-urlencoded
    ${data_request}=    Create Dictionary    username=${user_name}    password=${password}
    ${response} =    Post    url=${AUTHENTICATE_URL}    headers=${headers}    expected_status=200    data=${data_request}
    ${token} =     Create Dictionary
    ...    Authentication=${response.json()}
    Set To Dictionary    dictionary=${data}    Authentication_Token=${token}[Authentication][access_token]


Create Headers
    [Arguments]    ${token}=None    ${content_type}=application/json
    &{headers}=    Create Dictionary    Content-Type=${content_type}
    IF   '${token}' != 'None'    
        Set To Dictionary    ${headers}    Authorization=Bearer ${token}    
    END
    RETURN    ${headers}


