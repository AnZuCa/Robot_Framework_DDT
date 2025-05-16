*** Settings ***
Documentation    Get All Assets Resources for Assets API Tests

Resource            ${EXECDIR}${/}Resources${/}asset_api_common.resource

*** Variables ***
${GET_ALL_ASSETS_URL} =  ${Assets_API.base_url}${common_urls.assets_api.get_assets}
${GET_ALL_ASSETS_200_STATUS_CODE_SCHEMA} =    get_all_assets_schema.json
${INVALID_REQUEST_SCHEMA} =    invalid_request_schema.json



*** Keywords ***
Get All Assets
    [Documentation]    Get All Assets
    [Arguments]    ${data}
    Create Asset API Headers    ${data}
    Get Test Data Request Params    ${data}
    ${response} =    GET
    ...    url=${GET_ALL_ASSETS_URL}
    ...    headers=${data}[Request][Headers]
    ...    params=${data}[Request][Params]
    ...    expected_status=${data}[Expected_Response][httpStatus]
    Set To Dictionary    dictionary=${data}    Actual_Response=${response.json()}
    RETURN    ${response}

Verify Get All Assets Schema
    [Documentation]    Validate the get all assets Schema.
    [Arguments]    ${data}
    ${expected_status}=    Get From Dictionary    ${data}[Expected_Response]    httpStatus
    IF    ${expected_status} == '200'
        Validate Schema    ${data}    schema_path=${GET_ALL_ASSETS_200_STATUS_CODE_SCHEMA}
    ELSE IF    ${expected_status} == '400'
        Validate Schema    ${data}    schema_path=${INVALID_REQUEST_SCHEMA}
    END


Verify Get All Assets Response
    [Documentation]    Validate the Get All Assets Response.
    [Arguments]    ${data}
    Should Be Equal    ${data}[Actual_Response]   ${data}[Expected_Response][Body]
    ...    msg=The response for creating an asset unexpectedly did not match the actual response.