*** Settings ***
Documentation        Get All Assets Tests

Resource            ${EXECDIR}${/}API${/}Request${/}api_helper.resource
Resource            ${EXECDIR}${/}API${/}Request${/}get_all_assets.resource
Variables           ${EXECDIR}${/}Static${/}Data${/}${EXECUTION_ENV}${/}Asset${/}Get_Asset_Filtering_By_Category.yaml
Variables           ${EXECDIR}${/}Static${/}Data${/}${EXECUTION_ENV}${/}Asset${/}Get_Asset_Filtering_By_Min_Max_Price.yaml
Variables           ${EXECDIR}${/}Static${/}Data${/}${EXECUTION_ENV}${/}Asset${/}Get_Asset_Filtering_By_Invalid_Min_Max_Price.yaml
Variables           ${EXECDIR}${/}Static${/}Data${/}${EXECUTION_ENV}${/}Asset${/}Get_Asset_Filtering_By_Nonexistent_Status.yaml

Test Template    Validate Get All Assets

*** Test Cases ***                        DATA
Get All Assets - Filtering By Category             ${Get_Asset_Filtering_By_Category}
    [Documentation]    Verify Get All Asset endpoint is returning a 
    ...    200 status code for valid scenario
    [Tags]    123410
    [Setup]    Authentication Preconditions    ${Get_Asset_Filtering_By_Category}

Get All Assets - Filtering By Range Prices             ${Get_Asset_Filtering_By_Range_Prices}
    [Documentation]    Verify Get All Asset endpoint is returning a 
    ...    200 status code when filters by range of prices
    [Tags]    123411
    [Setup]    Authentication Preconditions    ${Get_Asset_Filtering_By_Range_Prices}

Get All Assets - Filtering By Invalid Range Prices             ${Get_Asset_Filtering_By_Invalid_Range_Prices}
    [Documentation]    Verify Get All Asset endpoint is returning a 
    ...    400 status code when filters by invalid range of prices
    [Tags]    123412
    [Setup]    Authentication Preconditions    ${Get_Asset_Filtering_By_Invalid_Range_Prices}

Get All Assets - Filtering By Nonexistent Status         ${Get_Asset_Filtering_By_Nonexistent_Status}
    [Documentation]    Verify Get All Asset endpoint is returning an 
    ...    empty list for nonexistent status
    [Tags]    123413
    [Setup]    Authentication Preconditions    ${Get_Asset_Filtering_By_Nonexistent_Status}


*** Keywords ***
Validate Get All Assets
    [Documentation]    Validate Get All Assets endpoint
    [Arguments]    ${data}
    Get All Assets    ${data}
    Verify Get All Assets Schema    ${data}
    Verify Get All Assets Response    ${data}
