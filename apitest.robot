*** Settings ***
Library    RequestsLibrary
Library    Collections
*** Variables ***
${URL_GET}    https://jsonplaceholder.typicode.com
${URL_POST}     https://jsonplaceholder.typicode.com
*** Keywords ***
Get API USERS
    Create Session    users    ${URL_GET}
    ${resp}=	Get Request	users	/users
    Log    ${resp.text}
    # Check status code
    Should Be Equal As Strings    ${resp.status_code}    200
    # Check return type ??
    # Check data type
    Should Be Equal As Strings    ${resp.headers['content-type']}    application/json; charset=utf-8
    # Check data size
    ${dataSize}=    Get Length    ${resp.content}
    Should Be Equal As Strings    ${dataSize}    5645

Post API 
    Create Session    posts    ${URL_POST}
    &{data}=	Create Dictionary	title=foo	body=bar	userId=1
    &{headers}=	Create Dictionary	Content-Type=application/json; charset=UTF-8
    ${resp}=	Post Request	posts	/posts    data=${data}    headers=${headers}
    Log    ${resp.text}
    # Check status code
    Should Be Equal As Strings    ${resp.status_code}    201
    # Check response match with request
    Should Contain    ${resp.content}    foo
    Should Contain    ${resp.content}    bar
    Should Contain    ${resp.content}    1
    Should Contain    ${resp.content}    101
    # Check some of headers
    ${location_header}=    Get From Dictionary    ${resp.headers}    Location
    Should Be Equal As Strings    ${location_header}    http://jsonplaceholder.typicode.com/posts/101

Convert to json and check https://stackoverflow.com/questions/49618075/robotframework-api-test-how-to-access-a-nested-keyvalue-from-a-json-response

*** Test Cases ***
5. Test Get API User
   Get API USERS
6. Test Post API
   Post API