*** Settings ***
Documentation    All the page objects and keywords of the Shop page
Library    SeleniumLibrary
Library    String
Library    Collections
Resource    generic.robot

*** Variables ***
${Navigation_link}     css:.nav-link  
${Checkout_Button}    css:li.active a


*** Keywords ***
Wait until Element is located in the page
    Wait until element passed is located on the Page    ${Navigation_link}

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

Select Checkout Button
    Click Link    ${Checkout_Button}     
    