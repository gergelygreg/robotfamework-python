*** Settings ***
Documentation    To validate Items are added to Cart and Checkout
Library    SeleniumLibrary
Library    ../customLibraries/Shop.py
Library    ../customLibraries/Checkout.py
Test Setup    Open the browser with the Mortgage payment url            
Suite Setup
Suite Teardown      
Test Teardown    Close Browser Session
Resource    ../PO/generic.robot
Resource    ../PO/LandingPage.robot
Resource    ../PO/ShopPage.robot
Resource    ../PO/CheckoutPage.robot
Resource    ../PO/ConfirmationPage.robot

*** Variables ***
@{listOfProduts}    Blackberry    Nokia Edge  
${country_name}    Hungary

*** Test Cases ***
Validate UnSuccessful Login
    LandingPage.Fill the login Form    ${user_name}    ${invalid_password}
    LandingPage.Wait until Element is located in the page    
    LandingPage.Verify error message is correct              

End to end ecommerce Product Validation 
    [Tags]    REGRESSION
    LandingPage.Fill the login Form    ${user_name}    ${valid_password}
    ShopPage.Wait until Element is located in the page       
    ShopPage.Verify Card titles in the Shop Page 
    Add Items To Cart    @{listOfProduts}   #using 'Add Items To Cart And Checkout' custom python function
    ShopPage.Select Checkout Button
    Verify Cart Items in Checkout    @{listOfProduts}
    CheckoutPage.Select Checkout Button
    ConfirmationPage.Enter The Country and Select the Terms    ${country_name} 
    ConfirmationPage.Purchase the Product and Confirm the Purchase 












  



       