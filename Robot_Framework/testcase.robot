***Settings***
Library		SeleniumLibrary
Library    String
Library    Collections
Library    DateTime
*** Variables ***
${URL}	https://www.expedia.com/
${BROWSER}        Chrome
${leaving_from}   Ha Noi
${Going_to_DN}    Da Nang
${Local_HaNoi}    .//ul[@class='no-bullet']//button[contains(string(), 'Noi Bai')]
${Local_DaNang}    .//ul[@class='no-bullet']//button[contains(string(), 'Da Nang')]
${verify_mess_DN}    Hanoi (HAN) - Da Nang (DAD)
${Going_to_HCM}    Ho Chi Minh City
${Local_HCM}    .//ul[@class='no-bullet']//button[contains(string(), 'Tan Son Nhat')]
${previous_click}   //*[@class='uitk-calendar']/div/button[1]
${verify_mess_HCM}    Hanoi (HAN) - Ho Chi... (SGN)


 
*** Test Cases ***
Test Case 1
    [tags]  tc1
   Open Browser		${URL}		${BROWSER}
   Maximize Browser Window
   Sleep   1
   Click Element    xpath=.//button[contains(string(),"More travel")]
   Sleep  5s
   Click Element    xpath=.//a[@href="/Flights"]
   BuiltIn.Sleep    45s
   Click Element    xpath=.//button[@aria-label="Leaving from"]
   Input Text    xpath=.//input[@placeholder="Where are you leaving from?"]    ${leaving_from}
   Sleep    2
   Click Element    xpath=${Local_HaNoi} 
   Sleep    5
   Click Element    xpath=.//button[@aria-label="Going to"]
   Input Text    xpath=.//input[@placeholder="Where are you going to?"]    ${Going_to_HCM}
   Sleep    2
   Click Element    xpath=${Local_HCM}  
   Sleep    3
   Click Button    id:d1-btn
   Sleep    3
   ${month}    Get Text    xpath=.//*[@class="uitk-calendar"]//h2
   ${target_month}     Get Current Date    result_format=%B %Y
   ${target_day}     Get Current Date    result_format=datetime
   Log To Console    ${target_day.day}
   Log To Console    ${month}
   Log To Console    ${target_month}
   IF   '${month}' == '${target_month}'
   Click Element    xpath=.//*[@data-day="${target_day.day}"]
   Sleep    1
   ELSE
   Click Element    ${previous_click}
   Sleep    2 
   ${month}    Get Text    /xpath=.//*[@class="uitk-calendar"]//h2
       IF    '${month}' == '${target_month}'
       Click Element     xpath=.//*[@data-day="${target_day.day}"]
       Sleep    1
       END
   END
   Click Element    xpath=.//button[@data-stid="apply-date-picker"]
   Sleep    3
   Click Element     xpath=.//button[contains(text(), 'Search')]    
   Sleep    30
   FOR    ${i}    IN RANGE    1    9
        ${verify_local}    Get Text    xpath=.//ul/li[${i}]//div[@data-test-id="arrival-departure"]
        IF    '${verify_local}' == '${verify_mess_HCM}'
            Log To Console    OK   
        END      
    END

Test Case 2
    [tags]  tc2
    Open Browser		${URL}		${BROWSER}
   Maximize Browser Window
   Sleep    1
   Click Element    xpath=.//button[contains(string(),"More travel")]
   Sleep  5s
   Click Element    xpath=.//a[@href="/Flights"]
   BuiltIn.Sleep    45s
   Click Element    xpath=.//button[@aria-label="Leaving from"]
   Input Text    xpath=.//input[@placeholder="Where are you leaving from?"]    ${leaving_from}
   Sleep    2
   Click Element    xpath=${Local_HaNoi} 
   Sleep    5
   Click Element    xpath=.//button[@aria-label="Going to"]
   Input Text    xpath=.//input[@placeholder="Where are you going to?"]    ${Going_to_DN}
   Sleep    2
   Click Element    xpath=${Local_DaNang}  
   Sleep    3
   Click Element     xpath=.//button[contains(text(), 'Search')]    
   Sleep    30
   Click Element    xpath=.//select[@id="listings-sort"]
   Sleep    1
   Click Element    xpath=.//select[@id="listings-sort"]/option[contains(string(), "Price (Lowest)")]
   @{pricelist}=    Create List
   FOR    ${i}    IN RANGE    1    9
       ${Priceitem}     Get Text    xpath=.//ul/li[${i}]//span[@class="uitk-lockup-price"]
       ${Priceitems}=     Split String    ${Priceitem}    $
       ${Priceitem_addlist}=    Get From List    ${Priceitems}    1
       Append To List    ${pricelist}    ${Priceitem_addlist}
    END   
 
   # FOR    ${j}    IN RANGE    1    9
   #    ${verify_local}    Get Text    xpath=.//ul/li[${j}]//div[@data-test-id="arrival-departure"]
   # END    
   ${length_list}=  Get length   ${pricelist}
   # ${verify_local}    xpath=.//div[@data-test-id="arrival-departure"]
   
   # IF    '${verify_local}' == '${verify_mess}'
      FOR    ${i}    IN RANGE    ${length_list}-1
         FOR   ${j}    IN RANGE    ${i}+1    ${length_list}
            ${pricelist_i}    Get From List    ${pricelist}    ${i}
            ${pricelist_j}    Get From List    ${pricelist}    ${j}
            ${verify_local}    Get Text    xpath=.//ul/li[${j}]//div[@data-test-id="arrival-departure"]
            IF    '${pricelist_i}' <= '${pricelist_j}'
               IF    '${verify_local}' == '${verify_mess_DN}'
               Log To Console    OK   
               END   
            END   
         END
      END

Test Case 3
    [tags]  tc3
    Click Element    xpath=.//select[@id="listings-sort"]/option[contains(string(), "Price (Highest)")]
   Sleep    6
   @{pricelist}=    Create List
   FOR    ${i}    IN RANGE    1    9
       ${Priceitem}     Get Text    xpath=.//ul/li[${i}]//span[@class="uitk-lockup-price"]
       ${Priceitems}=     Split String    ${Priceitem}    $
       ${Priceitem_addlist}=    Get From List    ${Priceitems}    1
       Append To List    ${pricelist}    ${Priceitem_addlist}
    END   
 
   # FOR    ${j}    IN RANGE    1    9
   #    ${verify_local}    Get Text    xpath=.//ul/li[${j}]//div[@data-test-id="arrival-departure"]
   # END    
   ${length_list}=  Get length   ${pricelist}
   # ${verify_local}    xpath=.//div[@data-test-id="arrival-departure"]
   
   # IF    '${verify_local}' == '${verify_mess}'
      FOR    ${i}    IN RANGE    ${length_list}-1
         FOR   ${j}    IN RANGE    ${i}+1    ${length_list}
            ${pricelist_i}    Get From List    ${pricelist}    ${i}
            ${pricelist_j}    Get From List    ${pricelist}    ${j}
            ${verify_local}    Get Text    xpath=.//ul/li[${j}]//div[@data-test-id="arrival-departure"]
            IF    '${pricelist_i}' >= '${pricelist_j}'
               IF    '${verify_local}' == '${verify_mess_DN}'
               Log To Console    OK   
               END   
            END   
         END
      END

Test Case 4
    [tags]  tc4
    Click Element    xpath=.//select[@id="listings-sort"]/option[contains(string(), "Duration (Shortest)")]
   Sleep    5
   @{timelist}=    Create List
   FOR    ${i}    IN RANGE    1    9
       ${time}     Get Text    xpath=.//ul[@data-test-id="listings"]/li[${i}]//div[@data-test-id="journey-duration"]
       ${times}=     Split String    ${time}    
       ${time_h}=    Get From List    ${times}    0
       ${time_h}=    Split String    ${time_h}   h
       ${time_h}=    Get From List    ${time_h}    0
       ${time_m}=    Get From List    ${times}    1
       ${time_m}=    Split String    ${time_m}    m
       ${time_m}=    Get From List    ${time_m}    0
       ${time_h}=    Evaluate    ${time_h} * 60
       ${time_target}=    Evaluate    ${time_h} + ${time_m}
       Append To List    ${timelist}    ${time_target}
  
    END   
 
   ${length_list}=  Get length   ${timelist}
   # ${verify_local}    xpath=.//div[@data-test-id="arrival-departure"]
   
   # IF    '${verify_local}' == '${verify_mess}'
      FOR    ${i}    IN RANGE    ${length_list}-1
         FOR   ${j}    IN RANGE    ${i}+1    ${length_list}
            ${timelist_i}    Get From List    ${timelist}    ${i}
            ${timelist_j}    Get From List    ${timelist}    ${j}
            ${verify_local}    Get Text    xpath=.//ul/li[${j}]//div[@data-test-id="arrival-departure"]
            IF    '${timelist_i}' <= '${timelist_j}'
               IF    '${verify_local}' == '${verify_mess_DN}'
               Log To Console    OK   
               END   
            END   
         END
      END
Test Case 5
    [tags]  tc5
    Click Element    xpath=.//select[@id="listings-sort"]/option[contains(string(), "Duration (Longest)")]
   Sleep    5
   @{timelist}=    Create List
   FOR    ${i}    IN RANGE    1    9
       ${time}     Get Text    xpath=.//ul/li[${i}]//div[@data-test-id="journey-duration"]
       ${times}=     Split String    ${time}    
       ${time_h}=    Get From List    ${times}    0
       ${time_h}=    Split String    ${time_h}   h
       ${time_h}=    Get From List    ${time_h}    0
       ${time_m}=    Get From List    ${times}    1
       ${time_m}=    Split String    ${time_m}    m
       ${time_m}=    Get From List    ${time_m}    0
       ${time_h}=    Evaluate    ${time_h} * 60
       ${time_target}=    Evaluate    ${time_h} + ${time_m}
       Append To List    ${timelist}    ${time_target}
  
    END   
 
   ${length_list}=  Get length   ${timelist}
   # ${verify_local}    xpath=.//div[@data-test-id="arrival-departure"]
   
   # IF    '${verify_local}' == '${verify_mess}'
      FOR    ${i}    IN RANGE    ${length_list}-1
         FOR   ${j}    IN RANGE    ${i}+1    ${length_list}
            ${timelist_i}    Get From List    ${timelist}    ${i}
            ${timelist_j}    Get From List    ${timelist}    ${j}
            ${verify_local}    Get Text    xpath=.//ul/li[${j}]//div[@data-test-id="arrival-departure"]
            IF    '${timelist_i}' >= '${timelist_j}'
               IF    '${verify_local}' == '${verify_mess_DN}'
               Log To Console    OK   
               END   
            END   
         END
      END
   