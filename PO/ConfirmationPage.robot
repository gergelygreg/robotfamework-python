*** Settings ***
Documentation    All the page objects and keywords of confirmation page
Library    SeleniumLibrary
Resource    generic.robot  


*** Variables ***       


*** Keywords ***
Enter The Country and Select the Terms
    [Arguments]    ${country_name}
    Input Text    id:country    ${country_name}
    Sleep    5
    Wait until element passed is located on the Page    //a[text()='${country_name}']   
    Click Element    //a[text()='${country_name}'] 
    Click Element    css:.checkbox label 

Purchase the Product and Confirm the Purchase 
    Click Button    css:.btn-success        
    Page Should Contain     Success!
    