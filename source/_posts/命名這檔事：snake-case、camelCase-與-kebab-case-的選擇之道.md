---
title: 命名這檔事：snake_case、camelCase 與 kebab-case 的選擇之道
date: 2024-11-07 17:29:10
tags:
    - snake_case
    - camelCase
    - kebab-case
    - 命名規則
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/B1tb4yo-kl.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

![image](https://hackmd.io/_uploads/B1tb4yo-kl.png)
>https://juniortoexpert.com/en/naming-convention/

在程式開發中，清晰、一致的命名風格對於程式碼的可讀性與維護性至關重要。本文將介紹三種常見的命名規則：snake_case、camelCase 和 kebab-case，並說明它們的使用場合及特性。

---

#  命名規則簡介

## snake_case
定義：單詞之間以底線（`_`）分隔，所有字母均小寫。
範例：
  - `user_name`
  - `sell_power_request`
  - `start_date`
常見應用：
  - Python 和 Ruby 中的變數和函式名稱。
  - 資料庫欄位名稱（如 SQL）。
  - 用於增加可讀性，特別適合需要簡潔和規則分明的環境。

## camelCase
- 定義：第一個單詞小寫，後續每個單詞首字母大寫，單詞之間不使用任何分隔符，看起來像是駝峰一樣，可以進一步細分為 upper camel case，與lower camel case  差別在於開頭第一個字是否為大寫
- 範例：
  - `userName`
  - `sellPowerRequest`
  - `startDate`
- 常見應用：
  - JavaScript、Java、C# 等語言中的變數與函式命名。
  - JSON 格式的屬性名稱。
  - 強調簡潔並與其他命名規則有所區隔。

## kebab-case
- 定義：單詞之間以連字符（`-`）分隔，所有字母均小寫，有許多另外的別稱 spinal-case,Train-Case,Lisp-case
- 範例：
  - `user-name`
  - `sell-power-request`
  - `start-date`
- 常見應用：
  - URL 和 HTML 屬性命名（如 `data-attribute`）。
  - 前端框架中的 CSS 類名（如 `my-component`）。
  - 強調跨環境兼容性，特別是在 Web 開發中。

---

# 三種命名規則的區別

| **規則**        | **分隔方式**         | **範例**            | **常見應用場景**                |
|-----------------|--------------------|--------------------|-------------------------------|
| **snake_case**  | 底線 `_`            | `user_name`         | Python、Ruby 變數與資料庫欄位名稱 |
| **camelCase**   | 無分隔，後單詞首字母大寫 | `userName`          | JavaScript 函式與變數名稱      |
| **kebab-case**  | 連字符 `-`          | `user-name`         | URL、CSS 類名                 |

---

# 什麼時候使用哪種規則？

選擇命名規則時，需考慮語言的慣例及使用場景：

## snake_case
- 優點：清晰易讀，適合跨平台處理。
- 缺點：在某些語言（如 JavaScript）中顯得笨重。
- 使用場景：
  - Python 變數、函式名稱。
  - SQL 資料表欄位名稱。

## camelCase
- 優點：簡潔且符合 JavaScript、Java 等語言的習慣。
- 缺點：單詞長時會降低可讀性。
- 使用場景：
  - 前端框架的變數、函式命名。
  - JSON 屬性。

## kebab-case
- 優點：與 URL 和 HTML 屬性名稱自然契合。
- 缺點：無法直接用於變數或函式名稱（不合法）。
- 使用場景：
  - CSS 類名和 ID 名稱。
  - RESTful API 的 URL。

---

# 範例應用

## snake_case 範例
```python
# Python 變數和函式命名
def calculate_total_price(price_per_item, quantity):
    total_price = price_per_item * quantity
    return total_price
```

## camelCase 範例
```javascript
// JavaScript 函式和變數命名
function calculateTotalPrice(pricePerItem, quantity) {
    let totalPrice = pricePerItem * quantity;
    return totalPrice;
}
```

## kebab-case 範例
```html
<!-- HTML 屬性 -->
<div class="user-profile" data-user-id="123"></div>

/* CSS 類名 */
.user-profile {
    background-color: #f5f5f5;
}
```

---

# 總結

1. 選擇語言約定：遵循語言或框架的命名慣例。例如：
   - Python 使用 **snake_case**。
   - JavaScript 使用 **camelCase**。
   - CSS 和 URL 使用 **kebab-case**。

2. 團隊統一風格*：在團隊協作中，統一命名規範能提升程式碼的一致性與可讀性。

3. 語意清晰優先：無論使用哪種規則，確保命名能反映實際功能或用途。

最後，良好的命名是可讀程式碼的基石，選擇適合的規範，讓你的程式碼更具可讀性與可維護性！

目前在工作經驗上其實三種都有使用過，主要還是看開發團隊大家想要一起使用哪一種，說好就行了。