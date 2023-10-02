---
title: TDD 測試驅動開發流程
date: 2023-10-02 15:59:49
tags: 開發流程 TDD Python Pytest 爬蟲
---

這篇是記錄我在看鐵人賽 [Python 與自動化測試的敲門磚 ](https://ithelp.ithome.com.tw/articles/10290529) 的過程

# TDD 簡介
TDD 全名為 Test-Driven Development 中文翻譯為 「測試驅動開發」，顧名思義就是藉著撰寫測試程式，來一步一步建構出我們的系統，其倡導的概念為，先撰寫測試程式，再撰寫實際相對應的 function，因此程式開發者需要先行和 PM 或使用者討論系統需求，並逐步擬定測試計畫，最後才會真正開始撰寫程式

採用 TDD 開發的優缺點

| 好處 | 壞處 |
| -------- | -------- | 
| 無須事後再補寫測試程式    | 若系統需求溝通不良，會容易造成系統設計不良   |
| 每一位 RD 都可以透過測試程式了解每個 function 的內容，較容易熟悉系統   | 測試程式有很大的機率只有 RD 部門看得懂，需要花費多於成本溝通     |
| 可以確保每個 function 被更動時，可以馬上進行測試，降低錯誤產生    ||

# 3A 原則

在 TDD 當中，對於每個測試程式的撰寫有著 3A 原則 (步驟)，分別為 Arrange、Act 以及 Assert，下面按照順序來進行說明

下面這段程式碼是我們在 demo 3A 原則的時候要進行測試的函式
```
def add_num(num1: int, num2: int) -> int:
    return num1 + num2
```
## Arrange 初始、期望結果
在這個步驟當中，我們要準備我們的測試環境、測試資料 以及預期結果
```
def test_add_num():
    # Arrange
    num1 = 10
    num2 = 20
    except_result = 30
```
## Act 實際呼叫
在這個步驟當中，我們就會實際呼叫我們需要測試的 function 來驗證其正確性
```
def test_add_num():
    # Arrange
    num1 = 10
    num2 = 20
    except_result = 30

    # Act
    result = add_num(num1, num2)
```
## Assert 驗證
最後我們才會進行驗證，看看該 function 是否如預期的回傳我們想要的值
```
def test_add_num():
    # Arrange
    num1 = 10
    num2 = 20
    except_result = 30

    # Act
    result = add_num(num1, num2)

    # Assert
    assert result == except_result
```
以上就是 TDD 針對撰寫每一個 test case 的 3A 原則

# TDD 的開發五步驟
接下來是要講的部分是，TDD 針對開發流程的五步驟，亦即每一組函式的開發過程 (function + test function)，分別為：

## 新增測試程式
選定一個要撰寫的需求、功能 (function)
思考使用情境，準備測試環境以及資料
先建立測試函式，不要先寫 function 本身 (即先撰寫 test_function)
對應到 3A 中的 Arrange)

## 執行測試程式 (亮紅燈)
由於還沒有實踐撰寫 function，因此在這個步驟一定會是錯誤
這個步驟要確定的是錯誤只發生在沒有撰寫 function 的部分，其他部分必須要確保可以正常運行，例如：fixture
是否可以正常接收，測試資料語法是否錯誤

## 撰寫 function
這個步驟我們要開始撰寫 function 本身
撰寫原則為以最低限度可以回傳正確資料為主，不需要對程式碼進行優化
對應到 3A 中的 Act

## 執行測試程式 (亮綠燈)
確保撰寫的功能正常
驗證回傳資料是否正確
對應到 3A 中的 Assert

## 優化程式
在前面四個步驟當中，我們已經將整組 function 以及 test_function 準備完成，接下來我們可以針對 function 進行重構
重構的過程當中我們可以不斷地執行測試程式，確保每一次改動都可以回傳正確資料

#  TDD 實作

## 需求設定
建立一個爬蟲針對 ptt 熱門看板 進行爬取
每執行一次爬蟲腳本，會進行爬取並印出各個版名稱、分類以及最新文章

## 爬蟲部分開發

### 需求思考
需要一個 url 參數，來進行網址的請求
回傳格式為 list，每個版資料使用 dictionary 裝起來
需要驗證項目：
list 不可為空
每個 dictionary 內需要有 board、class 以及 latest_paragraph

### 程式開發
#### 撰寫測試程式
可以看到我們在這個步驟憑空撰寫了一個 get_data 的 function 但是實際上並沒有進行任何的 import
test_utils.py
```
def test_crawler():
    # 建立測試參數
    url = "https://www.ptt.cc/bbs/index.html"
    
    # 呼叫方法
    result = get_data(url=url)

    # 進行驗證
    assert result
    for data in result:
        assert data.get("board")
        assert data.get("class")
        assert data.get("latest_paragraph")
```

:::info
需要安裝套件
pip install beautifulsoup4
pip install lxml
:::
#### 執行測試 (亮紅燈)
接著我們要執行測試，此步驟需要確認錯誤的位置必須在 get_data() 的部分，因為我們還沒有實際撰寫此 function

![](https://hackmd.io/_uploads/S14MLgdeT.png)
> 圖中我們可以確認，發生錯誤的原因確實是因為沒有此 function

#### 建立 function
utils.py
在這個步驟當中，我們實際撰寫了一個爬蟲的 function 並命名為 get_data
```
import requests
from bs4 import BeautifulSoup


def get_data(url: str) -> list:
    res = requests.get(url=url)
    if res.status_code == 200:
        soup = BeautifulSoup(res.text, "lxml")

        result = []
        targets = soup.find_all("div", class_="b-ent")
        for target in targets:
            tmp = {"board": target.find("div", class_="board-name").text,
                   "class": target.find("div", class_="board-class").text,
                   "latest_paragraph": target.find("div", class_="board-title").text}
            result.append(tmp)

        return result
```
#### 進行測試 (亮綠燈)
接著我們要開始進行測試，於測試程式內實際將 get_data 進行 import 並測試調整直到亮綠燈

test_utils.py
```
from utils import get_data


def test_crawler():
    # 建立測試參數
    url = "https://www.ptt.cc/bbs/index.html"

    # 呼叫方法
    result = get_data(url=url)

    # 進行驗證
    assert result
    for data in result:
        assert data.get("board")
        assert data.get("class")
        assert data.get("latest_paragraph")
        
```
下圖中可以看到我們很幸運的一次就成功了，代表可以進入下個步驟
#### 程式碼優化
 在這個過程中，我們就可以開始針對程式碼進行重構，切記，每進行一次重構，就要執行一次對應的 test case
確保每次的異動不會造成 function 異常

由於需求提到需要印出，因此於這個步驟我們替 get_data 加上 print 讓需求完善，並建立腳本進入點
```
import requests
from bs4 import BeautifulSoup
from pprint import pprint


def get_data(url: str) -> list:
    res = requests.get(url=url)
    if res.status_code == 200:
        soup = BeautifulSoup(res.text, "lxml")

        result = []
        targets = soup.find_all("div", class_="b-ent")
        for target in targets:
            tmp = {"board": target.find("div", class_="board-name").text,
                   "class": target.find("div", class_="board-class").text,
                   "latest_paragraph": target.find("div", class_="board-title").text}
            result.append(tmp)

        pprint(result)  # pprint 用於自動排版輸出
        return result


if __name__ == '__main__':
    get_data(url="https://www.ptt.cc/bbs/index.html")
```

下圖為利用 cmd 執行的結果
![](https://hackmd.io/_uploads/B1BjwluxT.png)
>  python3  utils.py


參考文章: 
https://ithelp.ithome.com.tw/articles/10299287