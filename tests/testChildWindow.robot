*** Settings ***
Documentation    To validate Child Window
Library    SeleniumLibrary
Test Setup    Open the browser with the Mortgage payment url                  
Test Teardown    Close Browser Session
Resource    ../PO/generic.robot

*** Variables ***
${Error_Message_Login}    css:.alert-danger 
${Error_Message_Text}    Incorrect username/password.  
${Navigation_link}     css:.nav-link  

*** Test Cases ***
Validate Child window funcionality
    [Tags]    SMOKE
    Select the Link of Child window
    Verify the user is switched to Child widow
    Grab the Email id in the Child window
    Switch to Parent window and enter the Email   

*** Keywords ***
Select the Link of Child window
    Wait Until Element Is Visible    css:.blinkingText    10s
    Click Element    css:.blinkingText

Verify the user is switched to Child widow
    Switch Window    NEW
    Sleep    5
    Element Should Be Visible    css:h1

Grab the Email id in the Child window
    ${text}=    Get Text    css:.red
    @{words}=    Split String    ${text}    at
    #0 -> Please email us at
    #1 -> mentor@rahulshettyacademy.com with below template to receive response
    ${text_split}=    Get From List    ${words}    1
    @{text_split}=    Split String    ${text_split}          
    ${email}=    Get From List    ${text_split}    0
    # Verify it's a real email
    Should Match Regexp    ${email}    ^[\\w\\.-]+@[\\w\\.-]+\\.[a-zA-Z]{2,}$
    Set Global Variable     ${email}
    
Switch to Parent window and enter the Email
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    #Input Text    id:username    ${email}
    