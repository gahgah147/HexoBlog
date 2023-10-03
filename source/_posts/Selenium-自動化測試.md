---
title: Selenium 自動化測試
date: 2023-10-03 11:49:28
tags: Selenium XPATH 自動化測試 Python
---

這篇是記錄我在看鐵人賽 [Python 與自動化測試的敲門磚 ](https://ithelp.ithome.com.tw/articles/10290529) 的過程

# 套件安裝

selenium：用來建立模擬器
webdriver_manager：用來協助我們做驅動程式的安裝，可以無需實際下載瀏覽器的驅動程式
```
pip install selenium
pip install webdriver_manager
```

# 快速入門
程式解析：

透過 make_webdriver 內的程式碼，可以建立一個 Chrome 物件，習慣上我們會將此物件命名為 driver
透過實作該方法得到 driver
透過 driver.get() 對網址進行請求，這個時候 driver 就會實際替我們開啟一個瀏覽器
為了展示開啟成功，使用 time.sleep() 讓瀏覽器畫面停止一下
使用 driver.quit() 來確保瀏覽器完全關閉，不會殘留在記憶體當中

```
import time
from selenium.webdriver import Chrome
from webdriver_manager.chrome import ChromeDriverManager


def make_webdriver() -> Chrome:
    driver = Chrome(ChromeDriverManager().install())

    return driver


if __name__ == '__main__':
    url = "https://ithelp.ithome.com.tw/questions"
    _driver = make_webdriver()
    
    _driver.get(url=url)
    time.sleep(10)
    
    _driver.quit()
```

成果展示：

可以看到下圖當中，透過 selenium 開啟的瀏覽器上方會有註明受到測試軟體控制

# 加上參數

我們可以透過加上一些參數，來設定瀏覽器開啟時的相關設定，下方直接透過程式講解
程式解析：

import Options 這個 class
於 function 內實作此 class
透過 add_argument 加入參數
--headless：讓瀏覽器進入無頭模式，簡單來說就是放在背景運行，不會實際開一個視窗出來
--start-maximized：確保瀏覽器每次執行時都可以開到最大的視窗，避免 RWD 造成一些元素讀不到

```
from selenium.webdriver.chrome.options import Options

def create_options() -> Options:
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--start-maximized")

    return options
```
完整程式碼：
透過在 driver 中添加 options 參數，我們即可為 driver 做一些瀏覽器的設定
```
from selenium.webdriver import Chrome
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager


def make_webdriver() -> Chrome:
    options = create_options()
    driver = Chrome(ChromeDriverManager().install(),
                    options=options)

    return driver


def create_options() -> Options:
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--start-maximized")

    return options


if __name__ == '__main__':
    url = "https://ithelp.ithome.com.tw/questions"
    _driver = make_webdriver()

    _driver.get(url=url)

    _driver.quit()
```

# 搭配 fixture

在撰寫測試程式的時候，driver 就特別適合撰寫成 fixture 來進行使用，下面也是直接附上範例

程式解析：

建立一個 fixture 並命名為 driver
建立 options
建立 driver 並指派 options 參數
透過 yield 將 driver 回傳出去
測試程式結束後回到 fixture 內執行 driver.quit() 退出 driver

```
import pytest
from selenium.webdriver import Chrome
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager


@pytest.fixture(name="driver")
def driver_fixture() -> Chrome:
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--start-maximized")

    driver = Chrome(ChromeDriverManager().install(),
                    options=options)

    yield driver

    driver.quit()
```

# 建立 driver 函式
首先我們先建立一個通用的可以回傳 driver 的函式，這個部份我們昨天介紹過了，今天就直接上範例方便大家對應函式名稱

本次進行範例說明所請求的網址為 PTT 熱門版，下方範例中有附上網址
```
from selenium.webdriver import Chrome
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

url = "https://www.ptt.cc/bbs/index.html"


def make_chrome_driver() -> Chrome:
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--start-maximized")

    driver = Chrome(ChromeDriverManager().install(),
                    options=options)
    return driver
```

# 使用 CSS_SELECTOR 定位
Selenium 的官方文件中，提供了許多種定位 HTML 元素的方式，今天我們就挑兩種比較常用的來進行介紹，首先我們先介紹 CSS_SELECTOR

CSS_SELECTOR 語法：<html 元素名稱><CSS 名稱>，其中 CSS 名稱可以是複數個，下面附上使用範例，至於該如何取得 CSS，我們可以透過在網頁上按又鍵開啟 "檢查" 選項來進行查看

程式解析：

取得 driver 並進行請求
使用 driver.find_element 來尋找元素，並指定使用 CSS_SELECTOR 進行尋找，第二個參數為 CSS 條件
印出該元素的資訊
使用 driver.find_elements 尋找所有在葉面上已出現並符合 CSS 條件的資訊
透過 generator 的方式來印出所有元素的文字資訊
補充說明：
每一個透過 selenium 找到的元素都一定有 text 屬性以及 get_attribute() 方法，其中 text 會印出該元素下所有的文字資訊，get_attribute() 則可以該元素的相關資訊，例如：class、href ... 等等，下方的範例為取得 text

```
from selenium.webdriver.common.by import By

def demo_css_selector():
    driver = make_chrome_driver()
    driver.get(url=url)
    
    # 回傳最先找到的元素，若沒有找到則會跳 error
    data = driver.find_element(By.CSS_SELECTOR, "div.b-ent").text
    print(data)
    
    # 會尋找目前葉面當中所有符合條件的元素，並回傳一個 list，若沒找到會回傳一個空 list
    datas = driver.find_elements(By.CSS_SELECTOR, "div.b-ent")
    [print(tmp.text) for tmp in datas]
```

# 使用 XPATH 定位

接下來的範例當中，我們會使用 XPATH 的方式尋找元素，並使用 get_attribute() 來取得該元素的 class

補充：我們同樣可以透過 "檢查" 來複製該元素在網頁上的 XPATH

在 "檢查" 當中找到該元素
對該元素點選右鍵，選取 "複製" -> "複製 XPATH" or "複製完整 XPATH"
至於 XPATH 的使用方式則不是本次重點，之後可以在鐵人賽後找時間進行說明

程式解析：
運作邏輯基本上一樣，只是 By.CSS_SELECTOR 更換成 By.XPATH，並搭配 XPATH 條件
```
def demo_xpath():
    driver = make_chrome_driver()
    driver.get(url=url)

    data = driver.find_element(By.XPATH, "//*[@id='main-container']/div[2]/div[1]")
    print(data.get_attribute("class"))

    datas = driver.find_elements(By.XPATH, "//*[@id='main-container']/div[2]/div")
    [print(tmp.get_attribute("class")) for tmp in datas]
```
# 等待元素出現
由於 selenium 是實際開啟一個瀏覽器來進行請求，因此會受限於各種情況導致元素會比較慢出現，因此 selenium 提供了一種等待元素的方式，下面附上使用範例

程式解析：

透過 WebDriverWait 進行元素的等待，告訴 Selenium 等待該元素 10 秒，當元素在 10 秒內出現，則會繼續進行下一段程式，但是超過 10 秒還沒出現，則會拋出 Timeout 錯誤
ec.presence_of_element_located 則表示要去尋找目前出現在畫面上的元素，和下方的 of_all 差別為單數之分，用法同 find_element

```
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec


def demo_wait():
    driver = make_chrome_driver()
    driver.get(url=url)
    
    # 單個元素，回傳 webelement 物件
    data = WebDriverWait(driver, 10).until(
        ec.presence_of_element_located((By.CSS_SELECTOR, "div.b-ent")))
    print(data.text)
    
    # 多個元素，回傳 list
    datas = WebDriverWait(driver, 10).until(
        ec.presence_of_all_elements_located((By.CSS_SELECTOR, "div.b-ent")))
    [print(tmp.text) for tmp in datas]
```

# 建立 driver 函式
同樣的我們今天一樣先附上建立 driver 的函式，今天比較不一樣的地方是，我們透過 contextmanager 來建立，
這樣我們就可以透過 yield 以及 with 的方式來操作 driver，並於操作結束後會自動回到此函式內執行 driver.quit()，以此確保瀏覽器會被完全關閉，不殘留在記憶體當中

另外我們今天爬取的目標是 ithelp，因此代入 user-agent 以免被誤認為是機器人而造成範例失敗，理論上如果是拿來測試網頁的話，應該是不用帶入這個參數的，不過還是要視情況而定
```
from contextlib import contextmanager
from selenium.webdriver.chrome.options import Options
from selenium.webdriver import Chrome
from webdriver_manager.chrome import ChromeDriverManager

@contextmanager
def make_chrome_driver() -> Chrome:
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--start-maximized")
    options.add_argument(f"user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                         f"AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36")

    driver = Chrome(ChromeDriverManager().install(),
                    options=options)
    yield driver
    driver.quit()
```

# 取得基本資訊

我們可以透過 driver 物件本身取得一些瀏覽器的資訊，下面列舉三點並附上程式碼做參考：

driver.current_url：取得瀏覽器目前所在頁面的網址
driver.title：取得瀏覽器目前所在頁面的 title，就是我們可以在瀏覽器最上方看到的分頁的名稱
driver.page_source：取得瀏覽器目前所在頁面的 HTML Code，取得後可透過 BeautifulSoup 進行網頁解析

```
def demo_basic_info():
    with make_chrome_driver() as driver:
        driver.get("https://ithelp.ithome.com.tw/")

        # 取得目前頁面的網址
        current_url = driver.current_url
        print(current_url)

        # 取得目前頁面的 title
        current_title = driver.title
        print(current_title)

        # 取得目前頁面的 HTML Code
        current_code = driver.page_source
        print(current_code)
```

# 點選元素

在 selenium 當中點選元素的方式有兩種，分別為透過 selenium 找到元素後進行點選以及找到元素後透過執行 javascript 進行點選，後者通常用於當要被點選的按鈕被某個跳出視窗遮住，或是畫面上被隱藏但是 HTML Code 實際上是存在時，我們就可以透過執行 javascript 直接對其進行點選的動作

## 使用 Selenium 點選

程式解析：

利用 selenium 找到 "技術文章" 按鈕元素
透過呼叫元素當中的 click() 方法即代表使用 selenium 內建的方式進行點選
點選該元素後頁面會進行跳轉，於點選後透過 driver.current_url 來取得該頁面網址
驗證取得的網址是否如同預期該出現的網址內容

```
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec


def demo_click_by_selenium():
    with make_chrome_driver() as driver:
        driver.get("https://ithelp.ithome.com.tw/")
        technical_article_button = WebDriverWait(driver, 30).until(
            ec.presence_of_element_located((By.XPATH, "/html/body/div[1]/nav/div[1]/div/ul[1]/li[2]/a")))

        # click by selenium
        technical_article_button.click()

        technical_article_url = "https://ithelp.ithome.com.tw/articles?tab=tech"
        current_url = driver.current_url

        assert current_url == technical_article_url
```

## 使用 Javascript 點選

語法：driver.execute_script("arguments[0].click();", <元素名稱>)

程式解析：
運作邏輯基本同上面一樣，差別只在於透過 javascript 執行點選的部分，有特別使用註解標記

```
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec

def demo_click_by_javascript():
    with make_chrome_driver() as driver:
        driver.get("https://ithelp.ithome.com.tw/")
        technical_article_button = WebDriverWait(driver, 30).until(
            ec.presence_of_element_located((By.XPATH, "/html/body/div[1]/nav/div[1]/div/ul[1]/li[2]/a")))

        # click by js
        driver.execute_script("arguments[0].click();", technical_article_button)

        technical_article_url = "https://ithelp.ithome.com.tw/articles?tab=tech"
        current_url = driver.current_url

        assert current_url == technical_article_url
```

# 鍵盤操作

在 selenium 當中，我們可以透過 send_keys() 方法來對元素進行文字的輸入，另外也可以透過 selenium 提供的 Keys 類別來模擬鍵盤的操作，下面的範例當中我們就分別使用上述兩種方法來進行帳號密碼的輸入，並用 Enter 鍵進行確認

程式解析：

* 先分別透過 selenium 找到輸入帳號、密碼的元素
* 利用 send_keys() 輸入帳號及密碼
* 輸入完成後於 password 利用 Keys 模擬 Enter 鍵的操作進行確認以及頁面跳轉
* 於跳轉後，取得 user name 並進行驗證

```
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec


def demo_input_keyboard():
    with make_chrome_driver() as driver:
        driver.get("https://member.ithome.com.tw/login")
        account = WebDriverWait(driver, 30).until(ec.presence_of_element_located((By.XPATH, "//*[@id='account']")))
        password = WebDriverWait(driver, 30).until(ec.presence_of_element_located((By.XPATH, "//*[@id='password']")))

        account.send_keys("<你的帳號>")
        password.send_keys("<你的密碼>")
        password.send_keys(Keys.ENTER)

        user_name = WebDriverWait(driver, 30).until(
            ec.presence_of_element_located((By.XPATH, "//*[@id='editNickname']")))

        assert user_name.text == "熊熊工程師"
```

# 建立測試目標

1. 確認瀏覽器請求網址後的網址是否為 "https://ithelp.ithome.com.tw/"，title 開頭是否為 "iT 邦幫忙"
1. 確認請求 "https://ithelp.ithome.com.tw/" 後，網頁上是否有出現 "技術問答" 字樣，且 HTML tag 為 h2
1. 確認請求 "https://ithelp.ithome.com.tw/" 後，網也上是否有出現 "技術問答"、"技術文章"... 等選項按鈕

# 建立 conftest.py

在開始撰寫測試程式前，我們可以先撰寫 fixture 方便後續的測試進行，而由於 driver 確定是每個 test case 都會使用到的功能，因此我們將此 fixture 撰寫在 conftest.py 當中

conftest.py

```
import pytest
from selenium.webdriver import Chrome
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager


@pytest.fixture(name="driver")
def driver_fixture() -> Chrome:
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--start-maximized")
    options.add_argument(f"user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                         f"AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36")

    driver = Chrome(ChromeDriverManager().install(),
                    options=options)

    yield driver

    driver.quit()
```
# 驗證 url 及 title

程式解析：

先對指定網址進行請求
驗證請求後跳轉的網址是否正確
驗證跳轉網址後的頁面的 title 是否開頭為 "iT 邦幫忙"

```
from selenium.webdriver import Chrome


def test_current_url(driver: Chrome):
    driver.get("https://ithelp.ithome.com.tw/")

    correct_url = "https://ithelp.ithome.com.tw/"
    assert driver.current_url == correct_url

    correct_title_start = "iT 邦幫忙"
    assert driver.title.startswith(correct_title_start)
```

# 驗證元素文字是否正確

程式解析：

建立測試資料
進行請求
透過 CSS_SELECTOR 找到元素
驗證該元素的 text 內容是否符合測試資料
```
from selenium.webdriver import Chrome
from selenium.webdriver.common.by import By


def test_text_visible(driver: Chrome):
    correct_text = "技術問答"

    driver.get("https://ithelp.ithome.com.tw/")
    question_h2_element = driver.find_element(
        By.CSS_SELECTOR, "h2.tab-title")

    assert question_h2_element.text == correct_text
```

# 驗證按鈕選項是否都有出現
程式解析：

建立測試資料
進行請求
透過 driver 先找到位於左方的選項列表元素 (ul)
在針對該元素尋找所有的選項內容 (li) 並透過 generator 的方式取得文字內容串列
文字內容串列是否符合正確的測試資料
```
from selenium.webdriver import Chrome
from selenium.webdriver.common.by import By


def test_element_clickable(driver: Chrome):
    correct_options = ["技術問答", "技術文章", "iT 徵才",
                       "Tag", "聊天室", "2022 鐵人賽"]

    driver.get("https://ithelp.ithome.com.tw/")
    options = driver.find_element(
        By.CSS_SELECTOR, "ul.list-unstyled.menu__left")
    options = [tmp.text for tmp in options.find_elements(
        By.CSS_SELECTOR, "li.menu__item")]

    assert options == correct_options
```

# 安裝 Selenium IDE

1. 前往這個網址：https://chrome.google.com/webstore/detail/selenium-ide/mooikfkahbdckldjjndioackbalphokd
1. 點選 "加到 Chrome" 選項
1. 選擇 "新增擴充功能" 選項
1. 過一陣子之後就可以在 Chrome 的右上角看到 Selenium IDE 被成功加入
https://ithelp.ithome.com.tw/upload/images/20221002/20144024nmnQrxsQAM.png

# 介面介紹
## 建立新專案
在開始介面介紹之前，我們先透過下面步驟建立一個簡單的測試計畫

1. 開啟 Selenium IDE
1. 選擇 "Record a new test in a new project" 選項
1. 輸入 project 名稱，範例使用 "demo"
1. 輸入此測試計畫的目標網址，此處使用 https://ithelp.ithome.com.tw/
1. 點選 "START RECORD" 選項開始進行錄製
1. 點選該選項之後，就可以看到他幫我們開啟一個連覽器並且右下角有顯示 Recording 字樣

![](https://hackmd.io/_uploads/Syz_9ZFg6.png)

## 介面介紹
![](https://hackmd.io/_uploads/SkOqcZtla.png)

1. project name：測試計畫名稱，我們可以透過命名計畫名稱來替測試分類
1. test 分類：分別有 Tests、Test Suites、Executing，此為 Selenium IDE，表示 Test 的部分
1. Tests：會列出所有 Test case
1. Test Suites：該計畫內部中的分類，預設會有 Default Suites 的存在
1. Executing：目前正在執行測試的 test case 會出現在此分類
1. test case 列表：依照　test 分類顯示出對應的 test case
1. 指令列表：列出該 test case 當中所有的指令，並會依照順序進行執行
1. 編輯指令：每個指令都可以透過這個視窗進行編輯、更換
1. 存檔
1. 錄製按鈕：按下此按鈕後會開啟瀏覽器並進行錄製

## 錄製腳本展示

我們可以透過錄製腳本的方式來進行測試案例的建立，也可以透過手動插入腳本的方式進行建立，不過在驗證的部分一定是透過手動插入的，Selenium IDE 只能協助我們錄製在我們想驗證的元素出現之前該進行甚麼樣的動作

另外經過筆者實測，建議在開始錄製之前都手動插入一行 open 命令來開啟網址，在錄製的過程中會比較順暢，下面我們就簡單錄製一個腳本給大家看

### 腳本說明

我們會按照下面的步驟來進行腳本的錄製：

1. 開啟　https://ithelp.ithome.com.tw/
1. 放大瀏覽器畫面
1. 點選 "技術文章"
1. 驗證 "h2 技術文章" 元素是否有出現

### 腳本展示

1. 點選紅色方框按鈕可以進行單個測試程式測試，左方按鈕為執行所有測試程式
1. 建議於錄製完成後，都將第一行 open 指令中的 "Target" 修改成想要到達的網址，避免造成錯誤

![](https://hackmd.io/_uploads/Bkq1jbtlp.png)

### 驗證方式

這個部分會說明一些常用的驗證項目，也就是 assert 的選項

* assert alert：驗證是否有跳出提示視窗
* assert element present：驗證元素是否有出現
* assert element not present：驗證元素是否沒出現
* assert text：驗證元素文字是否為指定的數值
* assert not text：驗證元素是否不為指定的數值

### 輸出為 Python 腳本

#### 輸出步驟

透過下面的方式可以將錄製好的腳本輸出為 Python 以及其他語言的腳本，然後就可以交給測試部門的 RD 進行程式的重構或使用，進一步套入 CI/CD 進行自動化測試

回到 Tests 分類

點選要匯出的測試案例旁邊的三個按鈕
https://ithelp.ithome.com.tw/upload/images/20221002/20144024nOaNk5J8ye.jpg

選擇 "EXPORT" 選項

選擇 "Python pytest" 選項

選擇 "EXPORT" 選項

#### 腳本展示

透過 Selenium IDE 所輸出的 Python 腳本，可以直接執行，不如果要套入 CI/CD，或是公司本身自有的測試框架或其他種類流程的話，
都會需要進行某種程度上的重構，這時後錄製腳本的人員如果沒有程式相關背景的話，就可以交給 RD 進行重構並納入自動化測試當中，
或本身是測試部門的 RD 的話，也可以透過這個小工具來減少我們寫 code 的時間，獲取更多偷懶的機會
```
# Generated by Selenium IDE
import pytest
import time
import json
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities


class TestDemo():
    def setup_method(self, method):
        self.driver = webdriver.Chrome()
        self.vars = {}

    def teardown_method(self, method):
        self.driver.quit()

    def test_demo(self):
        self.driver.get("https://ithelp.ithome.com.tw/")
        self.driver.set_window_size(1552, 832)
        self.driver.find_element(By.LINK_TEXT, "技術文章").click()
        elements = self.driver.find_elements(By.XPATH, "//h2[contains(.,\'技術文章\')]")
        assert len(elements) > 0
        self.driver.close()
```

# XPATH

## 建立 driver 函式
這邊就不再贅述，直接上範例，唯一不一樣的地方是，在這個階段我們會直接開啟指定的 url 再將 driver 回傳

```
from contextlib import contextmanager
from selenium.webdriver import Chrome
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager


@contextmanager
def make_chrome_driver() -> Chrome:
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--start-maximized")
    options.add_argument(f"user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                         f"AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36")

    driver = Chrome(ChromeDriverManager().install(),
                    options=options)
    driver.get("https://ithelp.ithome.com.tw/questions")
    yield driver
    driver.quit()
```
## 相對位置 XPATH

在 selenium 當中，我們可以透過相對位置的 XPATH 來定位我們的元素，語法結構大致如下：
```
xpath = "//div[@class='board tabs-content']/div[1]"
```

* //：表示當前網頁 or 元素
* div：要尋找的 HTML tag
* []：為 XPATH 的運算邏輯，在裡面可以增加 class、id 甚至是 and 等條件，語法為 "@<屬性名稱>"，ex: @class、@id、@name...
* div[1]：同層級且同樣的元素可能會有很多個，例如：ithelp 問答葉面的問題列表，可以透過取串列的方式來取得指定的個數，若沒有預設為取得第一個找到符合條件的元素

上述的 XPATH 語法代表要取得 "class 為 board tabs-content 的 div" 底下的 "第一個 div"

範例程式：
```
from selenium.webdriver.common.by import By


def get_question_by_relative_xpath():
    with make_chrome_driver() as driver:
        xpath = "//div[@class='board tabs-content']/div[1]"
        question = driver.find_element(By.XPATH, xpath)
        print(question.text)
```
執行結果：
![](https://hackmd.io/_uploads/ryik6btlp.png)

## 取得多個元素

當你找元素時使用的是 driver.find_elements，XPATH 會協助你將所有符合條件的元素都蒐集回來，下方的範例當中就成功將問答頁面第一頁中所有的問題都爬娶回來並印出數量

範例程式：

可以看到下方範例當中，我們將最後面的 div[1] 取代為 div[@class='qa-list']，表示我們要在這一層取得所有 "class 為 qa-list的 div"

```
from selenium.webdriver.common.by import By


def get_questions_by_relative_xpath():
    with make_chrome_driver() as driver:
        xpath = "//div[@class='board tabs-content']/div[@class='qa-list']"
        questions = driver.find_elements(By.XPATH, xpath)
        print(len(questions))
```

執行結果：
![](https://hackmd.io/_uploads/S1QMaWYx6.png)
