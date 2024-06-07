---
title: 自動化測試 CI/CD
date: 2023-10-25 13:57:45
tags: 
 - GitLab 
 - GitHub 
 - CI/CD 
 - Selenium 
 - Pytest
---

這篇是記錄我在看鐵人賽 [Python 與自動化測試的敲門磚 ](https://ithelp.ithome.com.tw/articles/10290529) 的過程

# CI/CD 簡介
CI/CD 其實是指兩個部分，分別是 Continuous Integration (持續整合) 以及 Continuous Deployment (持續部屬)

## CI 持續整合
在軟體開發的過程中，通常會由無數個開發人員一起工作，然而隨著程式碼以及人數的增加，專案會越來越難進行整合，這個時候我們就可以透過 CI 來進行。與其說 CI 是個工具，不如說 CI 是一種合作模式，藉由簡單的設定來讓 CI 工具替我們進行測試，就可以降低我們的專案在進行更新、整合時碰到問題的機率。

在 CI 執行的過程中，會建議每個開發人員每天上班前先做一次 pull 的動作，於每天下班前至少執行一次 push 的動作，以此確保 CI 的運行效率。

## CD 持續部屬
每當我們透過 CI 將專案整合完成後，便可以透過 CD 來進行自動化的部屬，減少我們在測試與部屬之間所耗費的時間

# CI/CD 常用工具
## GitLab
於 GitLab 上提供了 CI/CD 的介面，藉由在某處部屬好的 docker image，即可進行 CI/CD，為目前主流的 CI/CD 工具


## GitHub
GitHub 於 2019 年推出了 GitHub Actions，此工具可以協助我們進行 CI，不過由於此功能還算新，尚有許多功能不成熟，因此比較建議使用在小型專案的 CI 當中

## Jenkins
為目前主流的 CD 工具，藉由 GitLab 進行 CI 後，會將程式碼打包到 Jenkins 進行自動化部屬

# GitHub 設定

## 建立 yml file

進入 github 專案並點選 Actions 選項
![](https://hackmd.io/_uploads/B1bGcmKlT.png)

![](https://hackmd.io/_uploads/SynUsXKx6.png)
> 需要點擊啟用 Actions 設定
 
![](https://hackmd.io/_uploads/B1Rqj7Fxp.png)
點擊 New Workflow

在 Workflows 欄位底下輸入 "python" 進行搜尋
![](https://hackmd.io/_uploads/SJpG5Xte6.png)

選擇 Python Application，並點選 Configure 選項
![](https://hackmd.io/_uploads/Bkum5mYxp.png)

將跳轉後出現的頁面的程式碼滑到最底下，並將 pytest 更改為 echo "hello"

點選右上方 "Start Commit" 選項
![](https://hackmd.io/_uploads/BkD4qQtla.png)

點選 "Commit new file" 選項
![](https://hackmd.io/_uploads/HycBcXYep.png)

:::info
測試若有設定過會出錯，需要新建立一個repository才會成功
:::

頁面會自動跳轉回專案首頁，請點選回 "Actions"，就可以看到 github 按照剛剛建立的檔案建立了一個 CI 任務

![](https://hackmd.io/_uploads/HyOv9QKlT.png)

點進此任務，並選擇 build 選項
![](https://hackmd.io/_uploads/Bk-uqQFla.png)

點選 "Test with pytest" 部分即可看到剛剛修改的 echo "hello"
![](https://hackmd.io/_uploads/S10t27tgp.png)

![](https://hackmd.io/_uploads/HJ2O9XYlp.png)

## 修改 yml

由於我們剛剛是直接在 github 上進行 commit 來新增 workflows，因此我們要先回到專案上執行 git pull 確保專案同步

執行完 git pull 後即可在專案上看到 ".github" 這個目錄，並且有 "workflows" 這個子目錄

"workflows" 目錄下會有一個 python-app.yml 檔案，這個就是我們等一下要修改的檔案

![](https://hackmd.io/_uploads/rJ-s9mYxp.png)

在修改 yml 前我們先建立幾個簡單的 test case 並存放到 day_22/test_demo.py 目錄下
![](https://hackmd.io/_uploads/Byso9XKx6.png)

```
  def test_export_report_1():
      a = 1 + 1
      b = 2 + 2

      assert b > a


  def test_export_report_2():
    a = 2 + 2
    b = 4 + 4

    assert a < b
```
打開 python-app.yml

將剛剛的 echo "hello" 修改為 pytest -s -v ./day_22/test_demo.py
```
# This workflow will install Python dependencies, run tests and lint with a single version of Python
# For more information see: https://help.github.com/actions/language-and-framework-guides/using-python-with-github-actions

name: Python application

on:
  push:
    branches: [ "master" ]
  pull_request:
    branches: [ "master" ]

permissions:
  contents: read

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Set up Python 3.10
      uses: actions/setup-python@v3
      with:
        python-version: "3.10"
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install flake8 pytest
        if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
    - name: Lint with flake8
      run: |
        # stop the build if there are Python syntax errors or undefined names
        flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
        # exit-zero treats all errors as warnings. The GitHub editor is 127 chars wide
        flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics
    - name: Test with pytest
      run: |
        pytest -s -v ./day_22/test_demo.py
```

## 察看結果
修改完成後，我們就可以將整個專案 push 到 Github 上，這個時候我們就可以回到剛剛的 "Actions" 頁面察看結果了

下圖中我們可以看到 Acitons 這邊多了一個任務，任務名稱會使用剛剛的 commit message 命名
![](https://hackmd.io/_uploads/HkdxiQKxT.png)

點進去該任務後就可以查看 pytest 的執行結果了
![](https://hackmd.io/_uploads/ryZWjQtgT.png)

## python-app.yml

### 運行於指定的 branch 上

我們可以透過 on 參數來設定當哪個 branch 被推上 Github 上時要進行 CI 的動作，由於 CI 的進行也是需要耗費一定的資源，因此不太可能讓所有瑣碎的 branch 被推上去時都自動進行一次，透過設定 branches 可以指定那些 branch 被推上來時要執行 CI

補充：可以看到 on 底下有分為 push 以及 pull_request 兩個層級，分別代表著 Github 上的兩種協作方式
```
on:
  push:
    branches: [ "master" ]
  pull_request:
    branches: [ "master" ]
```

### 建立 CI 任務

| 變數 | 功能 |
| -------- | -------- |
| runs-on    | 為 CI 執行時最底下的一個 docker image 名稱，設定完成後 CI 會於執行時使用該 image 建立環境   | 
| steps   | 為實際 CI 執行的細項，每一個細項開頭都會使用 "-" 來表示 | 
| uses   | 為為運行此 steps 時啟動的服務，為 docker image 名稱 | 
| name   | 為此 step 的名稱 |  
| run   | 為此 step 要執行的命令 | 

```
jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
      
    - name: Set up Python 3.10
      uses: actions/setup-python@v3
      with:
        python-version: "3.10"
    
    - name: Test with pytest
      run: |
        pytest -s -v ./day_22/test_demo.py
```


# GitLab 設定

## 建立 CI/CD runner

在 GitLab 運行 CI/CD 時，同樣需要一個 runner 在背後執行，只是在 GitHub 的時候，他們幫我們做好了，因此我們不需要去碰到這塊，下面的方法為建立 runner 並和 GitLab 上的專案綁定的方法

:::info
接下來的步驟請先在要建立 runner 的電腦上安裝 docker
:::

前往 GitLab 專案的 Setting 裡面的 CI/CD 頁面

![](https://hackmd.io/_uploads/HJPEL21Ma.png)
> Setting > CI/CD


![](https://hackmd.io/_uploads/SJwSU2yfT.png)
> 找到 Runner 部分並打開，可以看到要和 runner 做連線的網址以及 token

打開 terminal

建立 docker volume
```
docker volume create gitlab-runner
```
![](https://hackmd.io/_uploads/SJ1MO21fp.png)

啟動 docker 並將他連上剛剛建立的 volume

```
docker run -d --name gitlab-runner --restart always -v /var/run/docker.sock:/var/run/docker.sock -v gitlab-runner:/etc/gitlab-runner gitlab/gitlab-runner:latest
```

使用下方指令進行 runner 與 GitLab 的連線

```
docker run --rm -it -v gitlab-runner:/etc/gitlab-runner gitlab/gitlab-runner:latest register
```

接下來會開始進行註冊程序，我們會以一個問題搭配一個回答的方式撰寫

| 註冊程序 | 回答 | 
| -------- | -------- | 
| Enter the GitLab instance URL     | 寫上剛剛在 GitLab 上看到的 url  | 
| Enter the registration token     | 寫上剛剛在 GitLab 上看到的 token  | 
| Enter a description for the runner     | 寫上你想要為這個 runner 的描述，這邊使用 "nickchen1998_ithelp_2022_marathon"  | 
| Enter tags for the runner     | 為這個 runner 增加 tag，用來指派 CI/CD 任務用，這邊先寫上 "nickchen1998_ithelp_2022_marathon"  | 
| Enter optional maintenance note for the runner     | 這部份我們不需要，直接按 Enter |  
| Enter an executor | 這邊我們輸入 "docker"，用來作為 runner 運行的環境 | 
| Enter the default Docker image | 當 yaml 檔沒有指定要使用的 image 時，預設會使用的 image，這邊我們輸入 "python:latest" | 

註冊完成


![](https://hackmd.io/_uploads/By4VF3Jz6.png)


![](https://hackmd.io/_uploads/rk4D5nkzT.png)
>回到剛剛的 runner 頁面，我們就可以看到一個新的 runner 被建立給這個專案

## 設定環境變數

我們可以透過 Settings 內的 CI/CD 頁面裡面的 Variables 欄位進行環境變數的設定

![](https://hackmd.io/_uploads/HJsfs2yGp.png)
> Settings > CI/CD > Variables

![](https://hackmd.io/_uploads/ryORi3yz6.png)
>點選 Add Variable 開始設定環境變數

![](https://hackmd.io/_uploads/r13x221zp.png)
> 依序輸入 key、value 並點選 Add Variable

![](https://hackmd.io/_uploads/rJk7hnJza.png)
> 可以看到成功新增的變數

## 設定 yaml 檔案

### 建立 .gitlab-ci.yml
在整個專案的 "最外層" 建立 gitlab-ci.yml 檔案

### 建立流程

直接將工作名稱寫在最外層，並於其下一層利用 stage 表示此工作階段的名稱
```
execute-test:
  stage: test
```

將要執行的指令依序寫在 scripts 後方
```
execute-test:
  stage: test
  script:
    - pip3 install pytest
    - pytest -s -v ./day_25/test_demo.py
```

最後利用 tag 指定我們要執行這個任務的 runner (昨天文章有提到該如何建立 runner)

```
execute-test:
stage: test
script:
  - pip3 install pytest
  - pytest -s -v ./day_25/test_demo.py
tags:
  - nickchen1998_ithelp_2022_marathon
```

### 管理 stage
透過設定 stage 可以來管理我們要執行哪個部份的腳本

透過下面這段程式碼，我們就成功設定執行所有 stage 為 test 的任務了
```
stages:
  - test

execute-test:
  stage: test
  script:
    - pip3 install pytest
    - pytest -s -v ./day_25/test_demo.py
  tags:
    - nickchen1998_ithelp_2022_marathon
```

### 成果展示
可以看到下圖中 GitLab 順利為我們生成一條 CI pipline
![](https://hackmd.io/_uploads/ryHR33Vfa.png)

:::warning
這邊要注意 runner 要指定對並且是執行中才會成功，不然會 Pending
:::

![](https://hackmd.io/_uploads/B1IbpnEMT.png)

##  Selenium 設定

### 修改 .gitlab-ci.yml 設定檔案

首先我們要替我們的 .gitlab-ci.yml 加上 service 表示我們要在指定的任務中運行其他服務

```
stages:
  - test

execute-test:
  stage: test

  services:

  script:
    - pip3 install -r ./requirements.txt
    - pytest -s -v ./day_26/test_demo.py
  tags:
    - nickchen1998_ithelp_2022_marathon
```

接著透過設定 services 底下的 name 參數來指定我們要使用哪個 docker image，我們會需要使用到 selenium/standalone-chrome 這個 image 來替我們建立一個可以遠端執行 Chrome 的環境

```
stages:
  - test

execute-test:
  stage: test

  services:
    - name: selenium/standalone-chrome

  script:
    - pip3 install -r ./requirements.txt
    - pytest -s -v ./day_26/test_demo.py
  tags:
    - nickchen1998_ithelp_2022_marathon
```

最後透過設定 alias 參數來為這個 services 進行命名
```
stages:
  - test

execute-test:
  stage: test

  services:
    - name: selenium/standalone-chrome
      alias: CICD_Selenium

  script:
    - pip3 install -r ./requirements.txt
    - pytest -s -v ./day_26/test_demo.py
  tags:
    - nickchen1998_ithelp_2022_marathon
```

:::info
script 方面我有實際測試，
pip3 install -r ./requirements.txt  
這行實際運行會出錯，我後來調整成這樣可以運行成功

script:
    - pip3 install pytest
    - pip3 install selenium
    - pip3 install webdriver_manager
    - pytest -s -v ./day_26/test_demo.py
:::

### 建立 fixture

建立一個 conftest.py 並將 driver 的 fixture 寫在裡面

```
import sys
import pytest
from typing import Union
from selenium.webdriver import Remote, Chrome
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager


@pytest.fixture(name="driver")
def driver_fixture() -> Union[Remote, Chrome]:
    options = Options()
    options.add_argument("--headless")
    options.add_argument(f"user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                         f"AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36")

    if sys.platform == "win32":
        driver = Chrome(ChromeDriverManager().install(),
                        options=options)
    else:
        driver = Remote(command_executor="http://CICD_Selenium:4444/wd/hub",
                        options=options)

    yield driver

    driver.quit()
```

### 撰寫測試程式
```
from selenium.webdriver import Remote, Chrome
from typing import Union


def test_current_url(driver: Union[Remote, Chrome]):
    driver.get("https://ithelp.ithome.com.tw/")

    correct_url = "https://ithelp.ithome.com.tw/"
    assert driver.current_url == correct_url

    correct_title_start = "iT 邦幫忙"
    assert driver.title.startswith(correct_title_start)
```
