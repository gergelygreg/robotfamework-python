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

*** Variables ***
@{listOfProduts}    Blackberry    Nokia Edge  

*** Test Cases ***
Validate UnSuccessful Login
    LandingPage.Fill the login Form    ${user_name}    ${invalid_password}
    LandingPage.Wait until Element is located in the page    
    LandingPage.Verify error message is correct              

Validate Cards display in the Shopping Page 
    LandingPage.Fill the login Form    ${user_name}    ${valid_password}
    ShopPage.Wait until Element is located in the page       
    ShopPage.Verify Card titles in the Shop Page 
    Add Items To Cart    @{listOfProduts}   #using 'Add Items To Cart And Checkout' custom python function











  



       