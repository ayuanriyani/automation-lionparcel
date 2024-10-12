*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem
Resource            ../service/resource.robot


*** Variables ***
${job_payload}    QA Engineering
${name_payload}    Ayuanriyani    

*** Test Cases ***
Scenario: User get requests a detail users
        Given the API is available
        When I send a POST request    /api/users
        Then The response status code should be    201
        And The response data is match
        

    
*** Keywords ***
The API is available
     [Tags]     POST  
    Create Session    Createuser    ${BASE_URL}    verify=True
    

I send a POST request
    ${body}=                              Create Dictionary
    ...                                   name=${name_payload}
    ...                                   job=${job_payload}
    [Arguments]    ${url_endpoint}
    ${Response}=    POST On Session    Createuser    ${url_endpoint}    json=${body}
    Set Suite Variable    ${response}
    Log    Response: ${response.text}

The response status code should be
    [Arguments]    ${status_code}
    ${resp.status_code}=    Convert To String    ${Response.status_code}
    Should Be Equal    ${resp.status_code}    ${status_code}
    Set Suite Variable    ${response}
    Log    Response: ${response.text}

The response data is match
    ${response_json}=    To JSON    ${response.text}
    Set Suite Variable  ${response_json}
    ${name}=            Set Variable        ${response_json['name']}
    ${job}=             Set Variable        ${response_json['job']}
 
    #verify is match
    Should Be Equal      ${name}         ${name_payload}
    Should Be Equal    ${job}          ${job_payload}
   

To JSON
    [Arguments]    ${response_text}
    ${json_data}=    Evaluate    json.loads('''${response_text}''')    json
    [Return]    ${json_data}
 

    