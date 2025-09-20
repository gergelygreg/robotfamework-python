*** Settings ***
Documentation    To validate the Login with data-driven test cases
Library    SeleniumLibrary
Library    DataDriver    file=resources/data.csv    encoding=utf_8    dialect=unix
Test Teardown    Close Browser
Test Template    Validate UnSuccessful Login    

*** Variables ***
${Error_Message_Login}    css:.alert-danger 
${Error_Message_Text}    Incorrect username/password.     

*** Test Cases ***    username    password
Invalid username    dsahed    learning
Invalid passoword    rahulshetty    ploudfg
special characters    @#$    learning

***Keywords***
Validate UnSuccessful Login
    [Arguments]    ${username}    ${password}
    Open the browser with the Mortgage payment url
    Fill the login Form    ${username}    ${password}
    Wait until it checks and displays error message
    Verify error message is correct


Open the browser with the Mortgage payment url
    Create Webdriver    Chrome    C:/bin/chromedriver
    Go To    https://rahulshettyacademy.com/loginpagePractise


Fill the login Form
    [Arguments]    ${username}    ${password}
    Input Text    id:username   ${username}    True
    Input Password    id:password  ${password}
    Click Button    signInBtn 

Wait until it checks and displays error message
    Wait Until Element Is Visible    ${Error_Message_Login}    

Verify error message is correct
    ${result}=    Get Text    ${Error_Message_Login}  
    Should Be Equal As Strings    ${result}    ${Error_Message_Text}         
    #Element Should Contain    css:.alert-danger    Incorrect username/password.  

    


       