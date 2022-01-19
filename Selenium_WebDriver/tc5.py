from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import unittest
import time
Leaving_from = "Ha Noi"
Going_to = "Da Nang"
Local_HaNoi = f".//ul[@class='no-bullet']//button[contains(string(), 'Noi Bai')]"
verify_mess = "Hanoi (HAN) - Da Nang (DAD)"
class Testcase5(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Chrome()
        #self.driver = webdriver.Chrome("C:/Users/internntrantuyen/Downloads/chromedriver.exe")
        time.sleep(3)
        self.base_url = "https://www.expedia.com/"
    def test_case5(self):
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
        driver.find_element_by_xpath('.//select[@id="listings-sort"]/option[contains(string(), "Duration (Longest)")]').click()
        time.sleep(5)
        timelist =[]
        for j in range(1,9):
            time_f = driver.find_element_by_xpath('.//ul/li['+(str(j))+']//div[@data-test-id="journey-duration"]')
            time_f = time_f.text
            time_f = time_f.split()
            time_h = time_f[0]
            time_h = time_h.split('h')
            time_h = time_h[0]
            print(time_h)
            time_h = int(time_h)
            time_m = time_f[1]
            time_m = time_m.split('m')
            time_m = time_m[0]
            print(time_m)
            time_m = int(time_m)
            print('type h',type(time_h))
            print('type m' ,type(time_h))
            time_h =  time_h*60
            time_target = time_h + time_m 
            print(time_target)
            timelist.append(time_target)
        print(timelist) 
        verify_local  =  driver.find_elements_by_xpath('.//div[@data-test-id="arrival-departure"]')
        if any(verify_mess in e.text for e in verify_local):
            for i in range(len(timelist)): 
                for j in range(len(timelist)-1):
                    if(int(timelist[i]) >= int(timelist[j])):
                        print("Testcase PASS")
        else:
            print("Testcase FAIL")
    def tearDown(self):
        self.driver.quit()

if __name__ == "__main__":
    unittest.main()


