---
title: pytest-xdist併發測試
date: 2023-10-27 11:14:43
tags: 
 - pytest 
 - pytest-xdist
---

這篇是記錄我在看鐵人賽 [Python 與自動化測試的敲門磚 ](https://ithelp.ithome.com.tw/articles/10307902) 的過程

pytest-xdist，可以協助我們將 pytest 用併發的方式進行測試，白話來說就是同時進行很多個測試，而不是一個測完才接著下一個

# 套件安裝
```
pip install pytest-xdist
```

# 建立測試程式
建立三個測試程式，並於每個測試案例內都進行等待五秒
```
from time import sleep


def test_case_1():
    sleep(5)


def test_case_2():
    sleep(5)


def test_case_3():
    sleep(5)
```

# 成果展示

未使用併發測試時，可以看到測試總共花了 15 秒左右
![](https://hackmd.io/_uploads/H1XbtoOM6.png)

使用 pytest -n auto 表示要使用併發模式進行測試，可以看到測試時間只花了六秒鐘左右
![](https://hackmd.io/_uploads/B1iHYj_zT.png)

:::warning
併發數量若使用 auto 會自動抓取電腦 CPU 核心數，來建立併發數量，一般建議使用 CPU 核心數 / 2 的併發數量來進行測試
可以透過 pytest -n <concurrency_amount> 來進行併發數量的設定，
例如：pytest -n 3 ./day_29/test_demo.py
:::