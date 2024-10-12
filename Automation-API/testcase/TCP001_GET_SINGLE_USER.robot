*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem
Resource            ../service/resource.robot

*** Test Cases ***
Scenario: User get requests a detail users
        Given the API is available
        When I send a GET request    /api/users/2
        Then The response status code should be     200
        And The response should contain the field     "id"    2
        

    
*** Keywords ***
The API is available
     [Tags]     GET  
    Create Session    listuser    ${BASE_URL}    verify=True

I send a GET request
    [Arguments]    ${url_endpoint}
    ${Response}=    GET On Session    listuser    ${url_endpoint}
    Set Suite Variable    ${response}
    Log    Response: ${response.text}

The response status code should be
    [Arguments]    ${status_code}
     ${resp.status_code}=    Convert To String    ${Response.status_code}
    Should Be Equal    ${resp.status_code}    ${status_code}

The response should contain the field
    [Arguments]    ${field}    ${expected_value}
    ${response_json}=    To JSON    ${response.text}
    Set Suite Variable  ${response_json}
    Should Be True     ${response_json['data']['id']}    ${expected_value}    

To JSON
    [Arguments]    ${response_text}
    ${json_data}=    Evaluate    json.loads('''${response_text}''')    json
    [Return]    ${json_data}
 

    