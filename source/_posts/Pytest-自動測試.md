---
title: Pytest 自動測試
date: 2023-09-22 16:59:32
tags: 
 - Python 
 - 自動化測試 
 - Pytest
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

方法一
執行測試並產生 allure 暫存檔
```
pytest <測試檔案 or 目錄> --alluredir <allure 暫存檔存放位置>
```
使用 allure 暫存檔生成報表
```
allure generate <allure 暫存檔存放位置> -o <輸出報表位置> --clean
```


方法二
```
pip install allure-pytest
```
 
執行測試並產生 allure 暫存檔
py.test --alluredir=<allure 暫存檔存放位置> <測試檔案 or 目錄>
 
使用 allure 暫存檔生成報表
```
allure serve <allure 暫存檔存放位置>
```

:::warning
目前測試產生的
:::

### 使用docker-compose在docker容器中運行pytest
:::info
參考文章: https://geek-docs.com/pytest/pytest-questions/9_pytest_how_to_run_pytest_from_a_docker_container_within_dockercompose.html
:::

安裝套件
```
 pip install pytest pytest-docker
```


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
### 目錄架構
![](https://hackmd.io/_uploads/ByeEkGglT.png)


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

### fixture 裝飾器參數介紹


| 參數 | 功能 |
| -------- | -------- | 
| scope     | 表示作用域，預設為 "function"，亦即每個有用到此 fixture 的 test case 都會執行，另外還有 module、class 以及 session 三種     | 
| name | 用來設定 fixture 的別名，預設為函式名稱 | 
| autouse | 預設為 False，若為 True，則會自動進行使用 (根據 scope 作用域而定) | 

### 程式解釋

利用 @pytest.fixture 標註該函式為 fixture
利用 fake_useragent 隨機生成一個 User-Agent (需另外安裝 fake-useragent 套件)
回傳 headers 給有使用此 fixture 的 test case


### 使用 fixture
接著我們回到 test_demo.py 當中，來使用剛剛所製作的 fixture。使用的方式則非常簡單，首先我們必須將剛剛撰寫好的 fixture 的 function 給 import 進來，這樣 pytest 才抓地到，接著只需要在 test case 接收參數的地方打上剛剛為 fixture 命名的名稱 (若無則預設為 fixture 的 function name)，接著我們就可以在 test case 內使用此 fixture 回傳出的內容了。

1.將要使用 fixture 先進行 import
```
import requests
from fixtures import headers_fixture, parse_user_agent_fixture, make_user_agent_fixture
```

2.利用 https://httpbin.org/headers 來取得我們送出去的 headers
```
def test_assert_headers(headers: dict):
    url = "https://httpbin.org/headers"
    res = requests.get(url=url, headers=headers)

    print(res.status_code)
    print(res.json())

    assert res.status_code == 200
    assert res.json()['headers']["User-Agent"] == headers["User-Agent"]
```
3.最後驗證取得的 headers 和我們利用 fixture 製作的 headers 是否相等
```
def test_assert_user_agent(make_user_agent: dict, parse_user_agent: dict):
    assert make_user_agent == parse_user_agent
```

備註：本測試範例只使用了一個 fixture 作為展示，實際上一個 test case 可以同時使用多個 fixture 是沒問題的

### fixture 使用時機
1. 為 test case 建立環境時
 若是有很多個 test case 在測試前需要做一些環境的建置、參數的準備，則很適合適用 fixture

2. 當你不想使用 setup、teardown 時
 由於使用 setup、teardown 會造成該 .py 檔內的所有 test case 都被引響，而 fixture 若沒有被寫在 test case 接收的參數內，則不會被影響 (除非作用域不為 function 且 autouse=False)



以上練習是參考 iTHome 鐵人賽 Python 與自動化測試的敲門磚 文章跟著練習的內容


# 虛擬資料庫

## 虛擬關聯式資料庫 SQLite

### 專案架構介紹
![](https://hackmd.io/_uploads/BJaRufglp.png)

| 檔案 | 功能 |
| -------- | -------- | 
| crud.py | 存放對資料庫做 CRUD 操作的函式 |
| fixtures.py     | 存放使用 pytest 製作出的 fixture| 
| models.py     | 存放 sqlalchemy 建立的 ORM 架構 | 
| test_demo.py  | 存放 test case | 

### 資料庫路徑

用在將資料庫與 ORM 架構做連線時的資料庫位置

```
mysql+pymysql://<username>:<password>@<host>:<port>/<database_name>
```

今天要介紹的虛擬關聯式資料庫，是使用 SQLite 所提供的 In-memory 的資料庫，使用的路徑非常簡單，如下所示

```
sqlite://
```

且由於 python 內自帶 sqlite 的套件，所以只要將上面的路徑放入資料庫連線的路徑，電腦就會動使用記憶體協助我們進行資料表的建立以及操作

### 建立測試內容

這邊我們會先簡單介紹放在 models 的內容以及要被測試的 CRUD 的函式

models.py
建立一張名為 User 的資料表並且有 id 、 username 以及 birthday 三個欄位

```
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import String, Column, Integer, DATETIME
from datetime import datetime

Base = declarative_base()


class User(Base):
    __tablename__ = "user"
    id: int = Column(Integer, primary_key=True, autoincrement=True)
    username: str = Column(String(64))
    birthday: datetime = Column(DATETIME)
```
crud.py
建立一個可以利用 sqlalchemy 寫入資料的 function
```
from sqlalchemy.orm import Session
from models import User


def create_user_in_sqlite(data: User, session: Session) -> User:
    session.add(data)
    session.commit()
    session.refresh(data)

    return data
```

### 建立 fixture

接下來就是重點了，sqlalchemy 實際對資料庫進行操作的時後，需要一個 session 物件來協助我們進行操作，接下來我們就要利用 fixture 來替我們在測試前做建立資料表以及產生一個 session 的動作

程式解析：

利用剛剛所介紹的方法，先建立一個 engine 並與虛擬的 sqlite 進行連線
在測試之前我們先利用 fixture 替我們將資料表建立好，這樣在測試的過程中就不需要再花時間在撰寫建立環境的部分
接著我們實際建立一個 session 並 yield 出去
使用 yield 的原因是，當 test case 結束後，就會回到 fixture 內執行接下來的動作
由於式使用 with 進行 session 的建立，因此也 test case 結束後回到 fixture 內，此 session 會自動關閉
最後 test case 結束會到 fixture 內將資料表全部刪除，確保下一個 test case 有乾淨的環境做測試

```
import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import Session, sessionmaker
from models import Base


@pytest.fixture(name="sqlite_session")
def sqlite_session_fixture() -> Session:
    # 建立 engine
    engine_url = "sqlite://"
    engine = create_engine(engine_url)

    # 建立資料表
    Base.metadata.create_all(engine)

    #  yield 出 Session
    with sessionmaker(bind=engine)() as session:
        yield session

    # 刪除資料表
    Base.metadata.drop_all(engine)
```

### 建立測試程式

接下來就來就準備撰寫 test case 了，一樣附上程式碼並逐行解釋

程式解析：

將所使用到的套件分別進行 import
建立 test case 並使用 fixture sqlite_session 並提示 IDE 此為一個 Session 型態的參數
利用 User 建立一個測試資料
利用 crud 內的函式對資料庫測式寫入
驗證寫入函式回傳出的 username 是否和我們手動建立的 username 是否一致
```
from crud import create_user_in_sqlite
from models import User
from fixtures import sqlite_session_fixture
from sqlalchemy.orm import Session
from datetime import datetime

use_fixtures = [sqlite_session_fixture]


def test_create_user_in_sqlite(sqlite_session: Session):
    data = User(username="test_user", birthday=datetime.now())

    result: User = create_user_in_sqlite(data=data, session=sqlite_session)
    print(result.__dict__)

    assert result.username == data.username
```

::: info
測試需要安裝套件
pip install sqlalchemy
:::

### 成果展示
接著我們就可以利用 pytest 對 test_demo.py 進行測試了，下方為測試結果截圖
![](https://hackmd.io/_uploads/Hy_SRflxT.png)


## NoSQL 陣營的虛擬資料庫套件 - MongoMock

### 套件安裝
pymongo：正式用來撰寫 mongo 相關的 CRUD 時常用的套件，crud.py 內的 MongoClient，會由此套件產生

```
pip install pymongo
```
mongomock：協助用來建立一個虛擬的 MongoClient 讓我們可以透過 fixture 的方式來進行 crud.py 的測試

```
pip install mongomock
```

### 建立 crud
這邊會在 crud.py 檔案內建立一個寫入資料的方式，直接附上範例並進行解說

:::warning
注意：在正式的專案檔案中 (即非測試程式) 需要使用 pymongo 所提供的 MongoClient，才不會造成不可避免的錯誤
:::

程式解析：

import pymongo 的 MongoClient，進行 mongo 的 CRUD
建立一個 insert_user 函式
進行資料的寫入
寫入的同時取得 id
寫入完畢後透過 id 查詢該筆資料並回傳

```
from pymongo.mongo_client import MongoClient

database_name = "test"
collection_name = "user"


def insert_user(conn: MongoClient, data: dict) -> dict:
    # 插入資料並取得 id
    insert_id = conn[database_name][collection_name].insert_one(data).inserted_id

    # 藉由 id 搜尋並回傳
    result = conn[database_name][collection_name].find_one({"_id": insert_id})
    return result
```

### 建立 fixtures

接著我們要利用 MongoMock 所提供的 MongoClient 來進行 fixture 的撰寫，在開頭有提到，MongoMock 可以很好的兼容 PyMongo，因此我們可以直接使用 MongoMock 的 MongoClient 來進行 CRUD 的測試，範例如下

注意：雖然 MongoMock 可以很好的兼容 PyMongo 不過由於版本問題，某些功能還是會無法使用，因此若測試過程中有跳錯，請留意一下錯誤訊息，看看是否為 MongoMock 還沒支援相關功能

程式解析：

import mongomock 的 MongoClient
建立一個 fixture 命名為 conn
利用 mongomock 的 MongoClient 建立一個虛擬的連線
透過 yield 回傳出去給 test case 使用
```
import pytest
from mongomock.mongo_client import MongoClient


@pytest.fixture(name="conn")
def mongo_client_fixture() -> MongoClient:
    with MongoClient() as conn:
        yield conn
```

### test case 建立
最後我們要來建立測試程式了，直接附上範例進行解釋

程式解析：

將需要使用到的套件 import 進來
建立一筆假資料
調用 crud 當中的 insert_user 進行寫入測試
驗證回傳出的資料是否和我們建立的假資料內容一致
```
from datetime import datetime
from pymongo.mongo_client import MongoClient
from fixtures import mongo_client_fixture
from crud import insert_user

use_fixtures = [mongo_client_fixture]


def test_insert_user(conn: MongoClient):
    # 建立假資料
    data = {"username": "nick",
            "email": "test@test",
            "birthday": datetime(year=2022, month=12, day=31)}
    
    # 測試 CRUD 方法
    result = insert_user(data=data, conn=conn)
    print(result)
    
    # 驗證內容
    assert result["username"] == data["username"]
    assert result["email"] == data["email"]
    assert result["birthday"] == data["birthday"]
```

# 驗證錯誤與跳過案例

## 驗證錯誤

程式解析：

建立 raise_error 函式來手動引發一個錯誤
於 test_error 內使用 pytest.raises(IndexError) 來驗證函式引發的錯誤種類是否如預期

```
import pytest


def raise_error():
    raise IndexError("list 的位置錯誤")


def test_error():
    with pytest.raises(IndexError):
        raise_error()
```

注意：經筆者測試，在 pytest 驗證到預期內的錯誤訊息後，無法在同個 with 區域內進行其他驗證，都會顯示正確，若有需要驗證其他錯誤 or 案例，則需另開一個 with，或是將程式寫在 with 外部

如下方程式所示，手動驗證一個錯誤的條件需要寫在接收到預期錯誤的 with 區域之外，才會被檢查到錯誤

```
def test_error():
    with pytest.raises(IndexError):
        raise_error()

    assert 1 + 1 == 3
```


### 驗證錯誤訊息

pytest.raises() 除了在接收到預期內的錯誤不會報錯之外，我們也可以針對錯誤訊息的內容進行驗證

程式解析：

with pytest.raises(IndexError) as exc 我們可以理解成把接收到的錯誤丟給一個叫做 exc 的變數，並於外部做使用
驗證錯誤訊息的內容
驗證錯誤訊息的 class name

```
def test_error_message():
    # 將接收到的錯誤丟給一個名為 exc 的變數，該變數可於外部使用
    with pytest.raises(IndexError) as exc:
        raise_error()
    
    # 印出錯誤訊息內容並驗證
    print(str(exc.value))
    assert str(exc.value) == "list 的位置錯誤"
    
    # 印出錯誤訊息類別並驗證
    print(str(exc.typename))
    assert exc.typename == IndexError.__name__
```

### 跳過 test case
某些情況下，我們可能會不想讓一些 test case 被執行，比方說某個 function 只能用在某個版本的時候，或是在某種作業系統上該函式使用的套件會失效，又或是暫時不想刪除，碰到這類的情況 pytest 有提供了跳過的功能，分別為 skip 和 skipif

為了測試方便，我們會將接下來的兩個範例連同上面所撰寫的兩個 test case 一起執行，並且觀察 pytest 收集到的 test case 數量

### 直接跳過 skip

程式解析：

利用 @pytest.mark.skip() 裝飾器的方式來標註該案例需要跳過
reason 則是用來撰寫跳過的原因，該原因會被印在 terminal 上
```
@pytest.mark.skip(reason="測試案例跳過範例")
def test_skip_test_case():
    assert 1 + 1 == 3
```
結果展示：

可以看到下方圖片中，pytest 有成功蒐集到三個 test case，而第三個 test case 狀態為 SKIPPED 並且原因印出於狀態後方

### 有條件跳過 skipif

我們可以透過指定 sys 內的條件來進行跳過，下方的範例就是讀取目前的作業系統，如果為 "win32" 就不執行此範例
```
import sys


@pytest.mark.skipif(condition=sys.platform == "win32", reason="測試跳過指定條件範例")
def test_skip_test_case_by_condition():
    assert 1 + 1 == 4
```

另外我們可以透過印出 sys 內的物件及屬性，來查看有哪些條件可以支援
```
print(dir(sys))
```
# parametrize 自動生成多筆測試

今天我們要介紹如何利用 pytest 提供的 parametrize 來自動生成多筆測試，這個方式通常用於硬體的測試，需要使用很多不同的數值來對某個功能做測試，例如：USB 寫入速度跟寫入的檔案大小，但測試的 function 其實是一樣的，像這種情況我們就不需要撰寫多個 test case，利用 parametrize 的方式來進行測試即可

## 簡單範例
下面我們直接上範例來進行解釋

程式解析：

利用裝飾器的方式來進行 parametrize 的撰寫
argnames 為一組字串，分別要對應到 test case 內所需接收的參數
注意：請不要將格式寫成　'num1', 'num2'... 應該將所有名稱包在同一組字串內，如　'num1, num2, ...'
argvalues 用一個串列包起來並將每一組測試資料也用一個串列包起來，形成一個二維串列

```
import pytest


# 基本範例
@pytest.mark.parametrize(argnames='num1, num2, result', argvalues=[(1, 1, 2), (2, 2, 4)])
def test_add(num1: int, num2: int, result: int):
    assert num1 + num2 == result
```

![](https://hackmd.io/_uploads/S1iE5IZea.png)

## 搭配檔案讀取
除此之外，我們也可以將多組測試參數寫進檔案中，在測試之前先讀取進 python 中，於裝飾器內再指派給 test case

test_args.json

```
{"test_add": [[1, 1, 2], [2, 2, 4]]}
```
test_demo.py


```
import json
import pytest


# 搭配檔案讀取
with open("./test_args.json", "r", encoding="utf8") as file:
    test_args = json.loads(file.read())['test_add']


@pytest.mark.parametrize(argnames='num1, num2, result', argvalues=test_args)
def test_add_with_json_file(num1: int, num2: int, result: int):
    assert num1 + num2 == result
```

![](https://hackmd.io/_uploads/BkDTqLWxT.png)
> 測試結果

## ids 的使用
如果同時生成許多組測試，可能會造成閱讀上的不易，這時候我們可以透過 ids 來為每一組測試提供名稱

這邊我們會沿用上方讀取 json 後產生的 test_args，並手動根據 test_args 的長度來建立相關的 id，當然 ids 也可以利用讀取檔案的方式讀取近來，只要數量符合測試資料筆數，且型態為 list 即可

```
# ids 的使用
ids = [f"case: {i}" for i in range(1, len(test_args) + 1)]


@pytest.mark.parametrize(argnames='num1, num2, result', argvalues=test_args, ids=ids)
def test_add_with_json_file_and_ids(num1: int, num2: int, result: int):
    assert num1 + num2 == result
```

![](https://hackmd.io/_uploads/SJkFiIbx6.png)
> 可以看到 pytest 成功為我們的每組測試都加上名稱

## 搭配 fixture 做使用

網路上有很多 fixture 搭配 parametrize 的使用方式，不過筆者試了一下，發現 fixture 其實可以很直覺的 import 進來直接使用，請看下面範例

fixtures.py
建立一個 fixture 用來展示用

```
import pytest
from mongomock.mongo_client import MongoClient


@pytest.fixture(name="conn")
def mongo_client_fixture() -> MongoClient:
    with MongoClient() as conn:
        yield conn


```

test_demo.py
可以看到在這個 test case 當中，直接將 import 進來的 fixture name 打在 test case 最後面的參數，即可進行使用，請務必將 fixture 放在最尾端避免造成額外的錯誤

為了驗證是否真的有被 import 近來，第二個 assert 的部分為驗證 conn 參數是否為 MongoClient 型態，而非 None

```
from fixtures import mongo_client_fixture
from mongomock.mongo_client import MongoClient

use_fixtures = [mongo_client_fixture]


# 搭配 fixture 使用
@pytest.mark.parametrize(argnames='num1, num2, result', argvalues=[(1, 1, 2), (2, 2, 4)])
def test_add_with_fixtures(num1: int, num2: int, result: int, conn: MongoClient):
    assert num1 + num2 == result
    assert isinstance(conn, MongoClient)
```

![](https://hackmd.io/_uploads/SJEtnoMe6.png)

# conftest.py 

## conftest.py 簡介

白話來說 conftest.py 就是一個可以讓我們存放 "經常被使用到" 的 fixture 的地方，被存放在 conftest.py 當中的 fixture 不需要透過 import就可以直接進行使用，pytest 在一開始執行時，就會先去抓是否有 conftest.py 的存在，因此若今天發現你的 fixture 被許多個 test module 使用到的話不彷可以試著將 fixture 放到 conftest.py 當中

順帶一提 conftest.py 的有效範圍是從 conftest.py 所存在的當前目錄以及其所有子目路中的 test case 都可以使用，若於不同目錄則需要另外寫一個 conftest.py

在本次的範例當中，會利用新增 pytest cmd argument 的方式來進行範例展示，下方附上本次專案目錄的結構

![](https://hackmd.io/_uploads/SJuMajGeT.png)

## 範例展示
### 建立 conftest.py
conftest.py
* pytest_addoption 為 pytest 內建的 fixture，可以自定使用 cmd 執行時的參數
* 建立一個名為 permission 的參數，用來識別權限
* 建立 permission_fixture 用來讀取權限檔案，來識別使用者可以測試的範圍

```
import json
import pytest


def pytest_addoption(parser):
    parser.addoption("--permission", default="RD")


@pytest.fixture(name="permission")
def permission_fixture(pytestconfig):
    role = pytestconfig.getoption("permission")
    with open("./permission.json", "r") as file:
        permission_data = json.loads(file.read())
    if role == "RD":
        permission = permission_data["RD"]
    else:
        permission = permission_data["costumer"]

    return permission
```

### 建立 json 檔用來控制權限

permission.json
* 如果角色是 RD，則可以進行 select、update、delete
* 其餘的則定位為 costumer，只能進行 select 的測試
```
{
  "RD": [
    "select",
    "update",
    "delete"
  ],
  "costumer": [
    "select"
  ]
}
```

### 撰寫 test case
test_demo.py
* 大家可以發現，這裡使用 permission 這個 fixture 的時候並沒有像之前一樣進行 import 可以直接使用
* 分別有 select、update 兩項測試，並且於測試之前會進行權限的驗證
* 於 test_update_permission 的時候，若權限不足則會引發錯誤，並驗證錯誤訊息
```
import pytest


def test_select_permission(permission: list):
    if "select" in permission:
        assert True
    else:
        assert False


def test_update_permission(permission: list):
    if "update" in permission:
        assert True
    else:
        with pytest.raises(ValueError) as exc:
            raise ValueError("permission not allow")

        print(str(exc.value))
        assert str(exc.value) == "permission not allow"
```
### 結果展示
啟動 pytest 指令:
```
pytest -s -v --permission costumer .\test_demo.py
```
![](https://hackmd.io/_uploads/r1iJe2Gxp.png)
>可以看到當 permission 為 costumer 時，成功地引發了錯誤並通過錯誤訊息的驗證

```
pytest -s -v --permission RD .\test_demo.py
```
![](https://hackmd.io/_uploads/SkK-ehGxp.png)
>當權限為 RD 時，則 update 的部分不會引發錯誤


# 問題排除

## chrome driver版本過舊
selenium.common.exceptions.SessionNotCreatedException: Message: session not created: This version of ChromeDriver only supports Chrome version 114

這個原因是 chrome 常常會更新  導致 chrome driver版本過舊

這時候要到這邊下載最新的
https://googlechromelabs.github.io/chrome-for-testing/

```
cd /tmp
wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/117.0.5938.92/linux64/chromedriver-linux64.zip
```
解壓縮
```
unzip chromedriver-linux64.zip
```

到 chromedriver-linux64 資料夾
```
cd chromedriver-linux64
```

```
sudo mv chromedriver /usr/bin/chromedriver
sudo chown root:root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver
```



參考文章: 
https://ithelp.ithome.com.tw/articles/10293187
https://blog.csdn.net/qq_24166417/article/details/113850978
https://github.com/nickchen1998/2022_ithelp_marathon