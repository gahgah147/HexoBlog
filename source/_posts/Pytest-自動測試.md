---
title: Pytest 自動測試
date: 2023-09-22 16:59:32
tags: Pyton 自動化測試 Pytest
---

# Pytest 指令
```
pytest <.py 檔案位置>
```
範例：pytest .\day_03\test_demo.py

## 參數執行
1.列出每個 test case 的執行狀況
```
pytest -v <目錄 or 檔案位置>
```

2.會印出在 test case 內有 print 出來的數值
```
pytest -s <目錄 or 檔案位置>
```

3.不同的參數間，也可以進行混用，這邊進行簡單的範例展示
```
pytest -s -v <目錄 or 檔案位置>：
```

# 產生報表

## 產出 JSON 格式報表

### 安裝 pytest-json-report 套件
```
pip install pytest-json-report 
```

### 套件使用
```
pytest <pytest 原生參數 ex: -s -v> --json-report --json-report-file=<檔案名稱 or ./目錄位置/檔案名稱> <要執行的 .py 檔案 (可省略直接對整個目錄做讀取)>
```
使用範例：pytest -s -v --json-report --json-report-file=.\report\report.json .\test_demo.py

### 報表結果解析


| Column 1 | Column 2 | 
| -------- | -------- |
| duration     | 本次測試執行所耗費的時間     | 
| root     | 從哪個目錄下 pytest 指令的     | 
| environment     | 一些環境的設定，例如 Python 版本    |  
| summary     | 測試結果總攬，collected 的部份表示 pytest 從 root 開始往下蒐集到多少個 test case    | 
| collectors     | 蒐集 test case 的過程  | 
| tests     | 測試的詳細結果，包含 setup、teardown 和 test case 本身的執行過程、時間  | 


## 產出 HTML 報表
### 安裝 pytest-html 套件
```
pip install pytest-html
```
### 套件使用
```
pytest --html=<檔案名稱.html or .\目錄位置\檔案名稱.html> <執行的 .py 檔，省略會直接對整個目錄執行>
```
使用範例：pytest --html=.\report\report.html .\test_demo.py

![](https://hackmd.io/_uploads/r1hrz_F1p.png)

## Allure

### 安裝 Java JDK
可參考這篇安裝 Java JDK
https://medium.com/@pierre.viara/install-java-on-windows-10-linux-subsystem-875f1f286ee8

```
sudo apt update
```
![](https://hackmd.io/_uploads/SyTX8dF1p.png)


```
sudo apt install openjdk-11-jdk
```
![](https://hackmd.io/_uploads/Hkbrv_Yyp.png)

可以用 java --version 確認是否安裝成功
```
java --version
```
![](https://hackmd.io/_uploads/SJqUvOY16.png)

### 安裝 Allure

下載地址: https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/

可以選擇適合的版本
```
curl -O https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/2.9.0/allure-commandline-2.9.0.tgz
```
![](https://hackmd.io/_uploads/rJYSLtK1T.png)


解壓縮
```
tar -zxvf allure-commandline-2.9.0.tgz
```
![](https://hackmd.io/_uploads/SyiLIYtyp.png)

設定環境

進入解壓縮後的資料夾獲得絕對路徑
```
cd allure-2.9.0/bin/

pwd
```

建立軟連結
```
sudo ln -s /home/user/allure-2.9.0/bin/allure /usr/bin/allure
```

![](https://hackmd.io/_uploads/SJ3BtFYk6.png)
>完成後輸入 allure --version 可以驗證是否安裝成功

### 安裝套件
```
pip install allure-pytest
```

### 執行測試與生成報表

執行測試並產生 allure 暫存檔
```
pytest <測試檔案 or 目錄> --alluredir <allure 暫存檔存放位置>
```
使用 allure 暫存檔生成報表
```
allure generate <allure 暫存檔存放位置> -o <輸出報表位置> --clean
```

:::warning
目前測試產生的
:::

# 環境設定

##  setup、teardown 
在 function 等級設定 setup、teardown 時，會於每個 function 的開始以及結束時都會執行一次

### 建立 .env 檔案
env 檔案當中時常會保留我們不想要進入版本控制的重要資訊

:::info
注意： github 上的專案並沒有把 .env 推上去，若想使用請自行建立
:::


```
ACCOUNT="test_account_123"
PASSWORD="test_password_123"
```

### 安裝套件
```
pip install python-dotenv
```

### 撰寫測試環境

建立 test_example.py 檔案

```
import os
import dotenv


def setup_module():
    dotenv.load_dotenv("./.env")


def test_get_env_account():
    print(os.getenv("ACCOUNT"))


def test_get_env_password():
    print(os.getenv("PASSWORD"))
```

## fixture

### 快速建立 fixtures.py 檔案
```
import pytest
import requests
from fake_useragent import FakeUserAgent


@pytest.fixture(name="headers", scope="function", autouse=False)
def headers_fixture() -> dict:
    ua = FakeUserAgent()
    headers = {"User-Agent": ua.random}

    return headers


@pytest.fixture(name="make_user_agent", scope="function", autouse=False)
def make_user_agent_fixture() -> dict:
    ua = FakeUserAgent()
    headers = {"User-Agent": ua.random}

    return headers


@pytest.fixture(name="parse_user_agent", scope="function", autouse=False)
def parse_user_agent_fixture(make_user_agent: dict) -> dict:
    url = "https://httpbin.org/headers"
    res = requests.get(url=url, headers=make_user_agent)
    user_agent = res.json()["headers"]['User-Agent']

    return {"User-Agent": user_agent}
```

fixture 裝飾器參數介紹


| 參數 | 功能 |
| -------- | -------- | 
| scope     | 表示作用域，預設為 "function"，亦即每個有用到此 fixture 的 test case 都會執行，另外還有 module、class 以及 session 三種     | 
| name | 用來設定 fixture 的別名，預設為函式名稱 | 
| autouse | 預設為 False，若為 True，則會自動進行使用 (根據 scope 作用域而定) | 


以上練習是參考 iTHome 鐵人賽 Python 與自動化測試的敲門磚 文章跟著練習的內容


參考文章: https://ithelp.ithome.com.tw/articles/10293187
參考文章: https://blog.csdn.net/qq_24166417/article/details/113850978
參考文章: https://github.com/nickchen1998/2022_ithelp_marathon