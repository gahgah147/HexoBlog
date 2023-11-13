---
title: pytest-sugar 測試輸出美化與隨機測試
date: 2023-10-27 11:36:37
tags: 
 - pytest-sugar 
 - pytest-random-order 
 - 自動化測試 
 - pytest
---

今天我們要介紹該如何美化我們在進行測試時終端機的輸出，以及讓我們的測試可以隨機的進行

# 測試輸出美化套件安裝
```
pip install pytest-sugar
```

# 測試案例
下方為本次會使用到的測試案例，透過參數化的方式建立四次測試
```
import pytest

argvalues = [[1, 1, 2], [4, 4, 8]]


@pytest.mark.parametrize(argnames='num1, num2, result', argvalues=argvalues)
def test_add(num1: int, num2: int, result: int):
    assert num1 + num2 == result


@pytest.mark.parametrize(argnames='num1, num2, result', argvalues=argvalues)
def example_add(num1: int, num2: int, result: int):
    assert num1 + num2 == result
```


# 結果展示
```
pytest -s -v ./day_30/test_demo.py
```
沒有使用 pytest-sugar 的終端機測試輸出畫面
![](https://hackmd.io/_uploads/r1kG13_GT.png)

```
pytest -s -v ./day_30/test_demo.py
```
有使用 pytest-sugar 的終端機測試輸出畫面
![](https://hackmd.io/_uploads/ryyu13dMT.png)

# 隨機測試套件安裝
在 pytest 當中，測試預設是一個接著一個按順序進行測試的，若想要隨機進行測試，可以透過安裝 pytest-random-order 這個第三方套件來協助我們進行

```
pip install pytest-random-order
```
# 成果展示
```
pytest -s -v --random-order ./day_30/test_demo.py
```
可以看到下圖當中我們成功將測試打散進行測試
![](https://hackmd.io/_uploads/S1Igg2dfT.png)
