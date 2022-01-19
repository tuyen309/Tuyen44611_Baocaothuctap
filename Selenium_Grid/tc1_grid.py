from selenium import webdriver
from selenium.webdriver.chrome.webdriver import WebDriver
from selenium.webdriver.common.keys import Keys
import unittest
import sys
import time
from datetime import date
from selenium.webdriver.common.by import By

Leaving_from = "Ha Noi"
Going_to = "Ho Chi Minh City"
Local_HaNoi = f".//ul[@class='no-bullet']//button[contains(string(), 'Noi Bai')]"
verify_mess = "Hanoi (HAN) - Ho Chi... (SGN)"
today = date.today()
target_month = today.strftime("%B %Y")
target_day = str(today.strftime("%d"))



class Testcase1(unittest.TestCase):
    PLATFORM = 'WINDOWS'
    BROWSER = 'chrome'
    def setUp(self):
        desired_caps = {}
        desired_caps['platform'] = self.PLATFORM
        desired_caps['browserName'] = self.BROWSER
        self.driver = \
            webdriver.Remote('http://192.168.0.103:8888/wd/hub', 
            desired_caps)      
    def test_case1(self):
        driver = self.driver
        driver = WebDriver()
        driver.get('https://www.expedia.com/')
        time.sleep(5) 
        element = driver.find_element(By.XPATH,'.//button[contains(string(),"More travel")]')
        element.click()
        time.sleep(5)
        driver.driver.find_element(By.XPATH,'.//a[@href="/Flights"]').click()
        time.sleep(30)
        driver.find_element(By.XPATH,'.//button[@aria-label="Leaving from"]').click()
        driver.find_element(By.XPATH,'.//input[@placeholder="Where are you leaving from?"]').send_keys(Leaving_from)
        time.sleep(5)
        driver.find_element_by_xpath(Local_HaNoi).click()        
        time.sleep(5)
        driver.find_element_by_xpath('.//button[@aria-label="Going to"]').click()
        driver.find_element_by_xpath('.//input[@placeholder="Where are you going to?"]').send_keys(Going_to + Keys.ENTER)
        time.sleep(3)
        driver.find_element_by_id("d1-btn").click() 
        time.sleep(3)
        month = driver.find_element_by_xpath('.//*[@class="uitk-calendar"]//h2')
        month = month.text
        if(month == target_month):
            driver.find_element_by_xpath(".//*[@data-day="+target_day+"]").click()
        else:
            previous_click = driver.find_element_by_xpath('.//*[@class="uitk-calendar"]/div/button[1]')
            previous_click.click()   
            time.sleep(2)
            month =  driver.find_element_by_xpath('.//*[@class="uitk-calendar"]//h2')
            month = month.text
            if(month == target_month):
                day =  driver.find_element_by_xpath(".//*[@data-day="+target_day+"]")
                day.click()
                driver.find_element_by_xpath('.//button[@data-stid="apply-date-picker"]').click()
        driver.find_element_by_xpath('.//button[@data-testid="submit-button"]').click()
        time.sleep(30)  
        verify_local  =   driver.find_elements_by_xpath('.//div[@data-test-id="arrival-departure"]')
        if any(verify_mess in e.text for e in verify_local):
            print("Testcase_1 PASS")
        else:
            print("Testcase_1 FAIL")
    def tearDown(self):
        self.driver.quit()
if __name__ == "__main__":
    if len(sys.argv) > 1:
        Testcase1.BROWSER = sys.argv.pop()
        Testcase1.PLATFORM = sys.argv.pop()
    unittest.main(verbosity=2)