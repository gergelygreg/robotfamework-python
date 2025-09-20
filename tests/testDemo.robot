*** Settings ***
Documentation    To validate the Login
Library    SeleniumLibrary
Test Teardown    Close Browser
#Resource

*** Variables ***
${Error_Message_Login}    css:.alert-danger 
${Error_Message_Text}    Incorrect username/password.     

*** Test Cases ***
Validate Successful Login
    Open the browser with the Mortgage payment url
    Fill the login Form
    Wait until it checks and displays error message
    Verify error message is correct


*** Keywords ***
Open the browser with the Mortgage payment url
    Create Webdriver    Chrome    C:/bin/chromedriver
    Go To    https://rahulshettyacademy.com/loginpagePractise


Fill the login Form
    Input Text    id:username   rahulshettyacademy    True
    Input Password    id:password  12345678 
    Click Button    signInBtn 

Wait until it checks and displays error message
    Wait Until Element Is Visible    ${Error_Message_Login}    

Verify error message is correct
    ${result}=    Get Text    ${Error_Message_Login}  
    Should Be Equal As Strings    ${result}    ${Error_Message_Text}         
    #Element Should Contain    css:.alert-danger    Incorrect username/password.  

    


       