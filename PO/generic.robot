*** Settings ***
Documentation    A resource file with reusable kewords and variable
...
...             The system specific keywords created here using domain 
...             specific language. They utilize keywords provided by 
...             the imported SeleniumLibrary
Library    SeleniumLibrary
Library    Collections
Library    String


*** Variables ***
${user_name}    rahulshettyacademy
${invalid_password}     1234567 
${valid_password}    learning
${product_name}    Blackberry
${url}    https://rahulshettyacademy.com/loginpagePractise   
${browser}    chrome 

*** Keywords ***
Open the browser with the Mortgage payment url
    #Create Webdriver    ${browser}    C:\Users\Gergely\Desktop\GitRepo\robotframework-python\tests\resources\${browser}
    #Go To    https://rahulshettyacademy.com/loginpagePractise
    Open Browser      ${url}      ${browser}     options=add_argument("--incognito")

Close Browser Session
    Close Browser

Wait until element passed is located on the Page
    [Arguments]    ${page_locator}
    Wait Until Element Is Visible    ${page_locator}    

