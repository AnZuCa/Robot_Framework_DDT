*** Settings ***
Documentation       Common Asset API Keywords
Resource            ${EXECDIR}${/}config${/}settings.resource
Library             ${EXECDIR}${/}resources${/}JsonUtil.py

*** Variables ***
${DEFAULT_SCHEMA_PATH} =        ${EXECDIR}${/}Static${/}Data${/}Asset${/}Common${/}Schemas${/}

*** Keywords ***
Validate Schema
    [Documentation]    Validate an api response against a schema.
    [Arguments]    ${data}    ${schema_path}
    ${actual_response} =    Get From Dictionary    dictionary=${data}    key=Actual_Response
    ${passed} =    Validate Json Against Schema    json_object=${actual_response}   schema_path=${DEFAULT_SCHEMA_PATH}${schema_path}
    IF    not $passed
        Fail    msg=Validation of the api response against the schema: ${schema_path} was unsuccessful.
    END

Create Asset API Headers
    [Arguments]    ${data}=None    ${content_type}=application/json
    &{headers}=    Create Dictionary    Content-Type=${content_type}
    ${Uncheck_Authentication} =    Get From Dictionary If Exists    dictionary=${data}    key=Uncheck_Authentication    default=${False}
    IF    not ${Uncheck_Authentication}   
        Set To Dictionary    ${headers}    Authorization=Bearer ${data}[Authentication_Token]
    END
    Set To Dictionary    dictionary=${data}[Request]    Headers=${headers}

Get From Dictionary If Exists
    [Arguments]    ${dictionary}    ${key}    ${default}=None
    IF    '${key}' in ${dictionary}    
        ${value}=    Get From Dictionary    ${dictionary}    ${key}
        RETURN  ${value}  
    ELSE    
        RETURN    ${default}    
    END

Get Test Data Request Params
    [Documentation]    Returns the default params to be used in a request or
    ...    returns an empty dictionary otherwise
    [Arguments]    ${data}
    ${request_params} =    Get From Dictionary If Exists   dictionary=${data}[Request]    key=Params
    IF  not $request_params or not isinstance(${request_params}, dict)
        ${request_params} =  Create Dictionary
        Set To Dictionary  dictionary=${data}[Request]    Params=${request_params}
    END
    RETURN  ${request_params}