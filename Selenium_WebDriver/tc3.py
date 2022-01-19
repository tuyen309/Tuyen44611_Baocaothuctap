from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import unittest
import time
Leaving_from = "Ha Noi"
Going_to = "Da Nang"
Local_HaNoi = f".//ul[@class='no-bullet']//button[contains(string(), 'Noi Bai')]"
verify_mess = "Hanoi (HAN) - Da Nang (DAD)"
class Testcase3(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Chrome()
        time.sleep(3)
        self.base_url = "https://www.expedia.com/"
    def test_case(self):
        driver = self.driver
        driver.get(self.base_url)
        time.sleep(5)
        driver.find_element_by_xpath('.//button[contains(string(),"More travel")]').click()
        time.sleep(5)
        driver.find_element_by_xpath('.//a[@href="/Flights"]').click()
        time.sleep(45)
        driver.find_element_by_xpath('.//button[@aria-label="Leaving from"]').click()
        driver.find_element_by_xpath('.//input[@placeholder="Where are you leaving from?"]').send_keys(Leaving_from)
        time.sleep(5)
        driver.find_element_by_xpath(Local_HaNoi).click()        
        time.sleep(5)
        driver.find_element_by_xpath('.//button[@aria-label="Going to"]').click()
        driver.find_element_by_xpath('.//input[@placeholder="Where are you going to?"]').send_keys(Going_to + Keys.ENTER)
        time.sleep(3)      
        driver.find_element_by_xpath('.//button[@data-testid="submit-button"]').click()
        time.sleep(30)
        driver.find_element_by_xpath('.//select[@id="listings-sort"]').click()
        time.sleep(1)
        driver.find_element_by_xpath('.//select[@id="listings-sort"]/option[contains(string(), "Price (Highest)")]').click()
        time.sleep(5)
        pricelist =[]
        for j in range(1,9):
            priceitem = driver.find_element_by_xpath('.//ul/li['+(str(j))+']//span[@class="uitk-lockup-price"]')
            priceitem = priceitem.text
            priceitem = priceitem.split('$')
            priceitem = priceitem[1]
            priceitem = str(priceitem)
            pricelist.append(priceitem)
        print(pricelist)   
        verify_local  =  driver.find_elements_by_xpath('.//div[@data-test-id="arrival-departure"]')
        if any(verify_mess in e.text for e in verify_local):
            for i in range(len(pricelist)): 
                for j in range(len(pricelist)-1):
                    if(int(pricelist[i]) >= int(pricelist[j])):
                        print("Testcase PASS")
        else:
            print("Testcase FAIL")

    def tearDown(self):
        self.driver.quit()

if __name__ == "__main__":
    unittest.main()

