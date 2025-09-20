*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Test Setup    Open the browser with the Mortgage payment url       
Test Teardown    Close Browser Session
Resource    ../PO/generic.robot

*** Variables ***
${Error_Message_Login}    css:.alert-danger 
${Error_Message_Text}    Incorrect username/password.  
${Navigation_link}     css:.nav-link  

*** Test Cases ***
Validate Successful Login
    [Tags]    SMOKE
    Fill the login Form    ${user_name}    ${invalid_password}
    Wait Until Element Is Visible on the Page    ${Error_Message_Login}      
    Verify error message is correct

Validate Cards display in the Shopping Page 
    Fill the login Form    ${user_name}    ${valid_password}
    Wait Until Element Is Visible    ${Navigation_link}    
    Verify Card titles in the Shop Page 
    Select a Card    ${product_name}
    Verify Checkout

Select the Form and navigate to Child window
    Fill the Login Details and Login Form    ${user_name}    ${valid_password} 


*** Keywords ***
Fill the login Form
    [Arguments]    ${user_name}    ${password}
    Input Text    id:username   ${user_name}    True
    Input Password    id:password  ${password} 
    Click Button    signInBtn 

Wait Until Element Is Visible on the Page 
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}           

Verify error message is correct
    ${result}=    Get Text    ${Error_Message_Login}  
    Should Be Equal As Strings    ${result}    ${Error_Message_Text}         
    #Element Should Contain    css:.alert-danger    Incorrect username/password.  

Verify Card titles in the Shop Page          
    #Wait for titles to be present
    Wait Until Element Is Visible    css:.card-title    10s

    # Get all title elements (returns a list)
    @{title_elements}=    Get WebElements    css:.card-title
    ${count}    Get Length    ${title_elements}
    Log    ${count}
    Should Be Equal As Integers    ${count}    4

    #Collect their text
    @{actual_titles}    Create List
    FOR    ${element}    IN    @{title_elements}
        ${text}=    Get Text    ${element}    # pass one element, not the whole list
        ${text}=    Strip String  ${text}
        Append To List    ${actual_titles}    ${text}    
    END

    @{expectedListofMobiles} =    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    Sort List    ${actual_titles}
    Sort List    ${expectedListofMobiles}
    Lists Should Be Equal    ${actual_titles}    ${expectedListofMobiles}    
    
Select a Card
    [Arguments]    ${product_name}
    # Finds the card that contains an <h4 class="card-title"><a> with the given name, then clicks its "Add" button.
    ${loc}=    Set Variable    xpath=//div[contains(@class,'card')][.//h4[contains(@class,'card-title')]//a[normalize-space()="${product_name}"]]//button[normalize-space()='Add']
    Click Element    ${loc}

Select the Card 
    #different version of 'Select a Card' keyword
    [Arguments]    ${product_name}
    ${elements} =    Get WebElements    css:.card-title
    ${index}=    Set Variable    1
    FOR    ${element}    IN    ${elements}
    Exit For Loop If    '${product_name}' == '${element}'
    
        ${index}=    Evaluate    ${index} + 1 
    END
    Click Button    xpath:(//*[@class='card-footer'][${index}])/button

Verify Checkout
    Element Should Contain    css:.nav-link.btn.btn-primary     Checkout ( 1 )


Fill the Login Details and Login Form
    [Arguments]    ${user_name}    ${password}    
    Input Text          id:username     ${user_name}
    Input Password      id:password     ${password}  
    Click Element       css:input[value='user']
    Wait Until Element Is Visible       css:.modal-body
    Click Button        id:okayBtn
    Click Button        id:okayBtn
    Wait Until Element Is Not Visible   css:.modal-body
    Select From List By Value       css:select.form-control       teach
    Select Checkbox     terms
    Checkbox Should Be Selected     terms   


  



       