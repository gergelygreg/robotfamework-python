*** Settings ***
Documentation    All the page objects and keywords of landing page
Library    SeleniumLibrary
Resource    generic.robot

*** Variables ***
${Error_Message_Login}    css:.alert-danger 
${Error_Message_Text}    Incorrect username/password.  

*** Keywords ***
Fill the login Form
    [Arguments]    ${user_name}    ${password}
    Input Text    id:username   ${user_name}    True
    Input Password    id:password  ${password} 
    Click Button    signInBtn 

Verify error message is correct            
    ${result}=    Get Text    ${Error_Message_Login}  
    Should Be Equal As Strings    ${result}    ${Error_Message_Text}         
    #Element Should Contain    css:.alert-danger    Incorrect username/password.  

Wait until Element is located in the page
    Wait until element passed is located on the Page    ${Error_Message_Login}