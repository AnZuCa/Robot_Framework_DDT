*** Settings ***
Documentation    Create User Resources for Assets API Tests

Resource            ${EXECDIR}${/}Resources${/}asset_api_common.resource

*** Variables ***
${POST_USER_URL} =  ${Assets_API.base_url}${common_urls.assets_api.post_user}
${POST_USER_200_STATUS_CODE_SCHEMA} =    post_user_schema.json
${POST_DUPLICATED_USER_SCHEMA} =    post_duplicated_user_schema.json

*** Keywords ***
Post Create User
    [Documentation]    Post a user
    [Arguments]    ${data}
    ${request_data} =    Evaluate    json.dumps(${data}[Request][Body])
    ${response} =    POST
    ...    url=${POST_USER_URL}
    ...    data=${request_data}
    ...    expected_status=${data}[Expected_Response][httpStatus]
    Set To Dictionary    dictionary=${data}    Actual_Response=${response.json()}
    RETURN    ${response}

Verify Post User Schema
    [Documentation]    Validate the post user Schema.
    [Arguments]    ${data}
    ${schema_type}=    Get From Dictionary    ${data}    Schema_Type
    IF    '${schema_type}' == 'Valid'
        Validate Schema    ${data}    schema_path=${POST_USER_200_STATUS_CODE_SCHEMA}
    ELSE
        Validate Schema    ${data}    schema_path=${POST_DUPLICATED_USER_SCHEMA}
    END