*** Settings ***
Documentation    Create Asset Resources for Assets API Tests

Resource            ${EXECDIR}${/}Resources${/}asset_api_common.resource

*** Variables ***
${POST_ASSET_URL} =  ${Assets_API.base_url}${common_urls.assets_api.post_asset}
${POST_ASSET_200_STATUS_CODE_SCHEMA} =    post_asset_schema.json
${POST_ASSET_401_STATUS_CODE_SCHEMA} =    invalid_request_schema.json
${POST_ASSET_422_STATUS_CODE_SCHEMA} =    post_asset_422_status_code_schema.json



*** Keywords ***
Post Create Asset
    [Documentation]    Post an asset
    [Arguments]    ${data}
    Create Asset API Headers    ${data}
    ${request_data} =    Evaluate    json.dumps(${data}[Request][Body])
    ${response} =    POST
    ...    url=${POST_ASSET_URL}
    ...    headers=${data}[Request][Headers]
    ...    data=${request_data}
    ...    expected_status=${data}[Expected_Response][httpStatus]
    Set To Dictionary    dictionary=${data}    Actual_Response=${response.json()}
    RETURN    ${response}

Verify Post Asset Schema
    [Documentation]    Validate the post asset Schema.
    [Arguments]    ${data}
    ${expected_status}=    Get From Dictionary    ${data}[Expected_Response]    httpStatus
    IF    ${expected_status} == '200'
        Validate Schema    ${data}    schema_path=${POST_ASSET_200_STATUS_CODE_SCHEMA}
    ELSE IF    ${expected_status} == '401'
        Validate Schema    ${data}    schema_path=${POST_ASSET_401_STATUS_CODE_SCHEMA}
    ELSE IF    ${expected_status} == '422'
        Validate Schema    ${data}    schema_path=${POST_ASSET_422_STATUS_CODE_SCHEMA}
    END

Verify Post Asset 200 Status Code Response 
    [Documentation]    Validate the Post Asset Response - 200 status code.
    [Arguments]    ${data}
    ${expected_body}=    Get From Dictionary    ${data}[Expected_Response]    Body
    ${actual_body}=      Get From Dictionary    ${data}    Actual_Response
    FOR    ${key}    IN    @{expected_body.keys()}
        Should Be Equal    ${expected_body}[${key}]    ${actual_body}[${key}]
    END

Verify Post Asset Response
    [Documentation]    Validate the Post Asset Response.
    [Arguments]    ${data}
    Should Be Equal    ${data}[Actual_Response]   ${data}[Expected_Response][Body]
    ...    msg=The response for creating an asset unexpectedly did not match the actual response.