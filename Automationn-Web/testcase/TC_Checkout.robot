
*** Settings ***
Library            SeleniumLibrary
Library            Collections
Resource           ../service/resource.robot

*** Variables ***
${USERNAME}    standard_user
${PASSWORD}    secret_sauce
${Product}    Sauce Labs Backpack
${Qty}    1
${postal-code}    15154
${first-name}    Rizki
${last-name}    Ayuanriyani


*** Test Cases ***
Scenario: User logs in, adds product to cart, and checks out
        Given the browser is opened
        When The user logs in with valid credentials
        And The user adds a product to the cart
        And The user next proceeds to checkout
        And The user fills out checkout information
        Then The user should successfully complete the purchase



*** Keywords ***
The browser is opened
    Open Browser     ${BASE_URL}    ${BROWSER}
    Maximize Browser Window   

The user logs in with valid credentials
    Input Text    id=user-name    ${USERNAME}
    Input Text    id=password     ${PASSWORD}
    Click Button  id=login-button
    Wait Until Element Is Visible    id=inventory_container    10s
    Title Should Be    Swag Labs

The user adds a product to the cart
    Click Button    id=add-to-cart-sauce-labs-backpack
    Wait Until Element Is Visible    xpath=//a[@class='shopping_cart_link']    5s
    ${cart_badge}=    Get Text    xpath=//span[@class='shopping_cart_badge']
    Should Be Equal    ${cart_badge}    ${Qty}
    
    Click Link      xpath://a[@class='shopping_cart_link']
    ${cart_description}=    Get Text    xpath=//div[@class='inventory_item_name']
    Should Be Equal    ${cart_description}     ${Product}

The user next proceeds to checkout
    ${buttoncheckout}=    Get Text    id=checkout
    Should Be Equal    ${buttoncheckout}     Checkout
    Click Button    id=checkout

The user fills out checkout information
    Wait Until Element Is Visible    xpath=//span[text()='Checkout: Your Information']    5s
    Input Text    id=first-name    ${first-name}
    Input Text    id=last-name     ${last-name}
    Input Text    id=postal-code    ${postal-code}
    Click Button  id=continue
    Wait Until Element Is Visible    xpath://button[@id='finish']    5s

The user should successfully complete the purchase
    Wait Until Element Is Visible    xpath=//span[text()='Checkout: Overview']    5s    
    Click Button  id=finish

    Wait Until Element Is Visible    xpath=//span[text()='Checkout: Complete!']    5s    
     ${thanksgift}=    Get Text    xpath=//h2[@class='complete-header']
    Should Be Equal    ${thanksgift}     Thank you for your order!