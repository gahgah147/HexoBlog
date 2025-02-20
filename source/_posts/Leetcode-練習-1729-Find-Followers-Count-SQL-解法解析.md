---
title: 'Leetcode 練習 - 1729: Find Followers Count - SQL 解法解析'
date: 2025-02-20 10:35:00
tags:
    - Leetcode
    - SQL
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/r1yEn-Vq1g.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---


![image](https://hackmd.io/_uploads/r1yEn-Vq1g.png)

## **📌 前言**
在社交媒體應用程式中，計算每位用戶的粉絲數是一個常見的需求，而這道 SQL 題目 **Leetcode 1729: Find Followers Count** 正是考察這個概念。這題主要測試 **GROUP BY** 和 **COUNT()** 聚合函數的應用，適合 SQL 初學者練習。本文將解析這題的解法，並探討進階做法。

---

## **📝 題目解析**
### **🔹 題目要求**
- 給定 `Followers` 資料表，該表包含 `user_id` 和 `follower_id`，表示 `follower_id` 是 `user_id` 的粉絲。
- 計算每位 `user_id` 擁有的粉絲數量。
- 結果需按照 `user_id` 升序排列。

### **🔹 輸入範例**
```sql
+---------+-------------+
| user_id | follower_id |
+---------+-------------+
| 0       | 1           |
| 1       | 0           |
| 2       | 0           |
| 2       | 1           |
+---------+-------------+
```

### **🔹 預期輸出**
```sql
+---------+----------------+
| user_id | followers_count|
+---------+----------------+
| 0       | 1              |
| 1       | 1              |
| 2       | 2              |
+---------+----------------+
```

### **🔹 解釋**
- `user_id = 0` 的粉絲有 `{1}`，共 1 位  
- `user_id = 1` 的粉絲有 `{0}`，共 1 位  
- `user_id = 2` 的粉絲有 `{0, 1}`，共 2 位  

---

## **💡 SQL 解法**

這題其實題目很簡單

### **🔹 解法 1：使用 `GROUP BY` 和 `COUNT()`**
這題的核心解法是使用 **GROUP BY** 來將 `user_id` 進行分組，並計算 `follower_id` 的數量。

#### **✅ SQL 語法**
```sql
SELECT
    user_id, COUNT(follower_id) AS followers_count
FROM
    Followers
GROUP BY
    user_id
ORDER BY
    user_id ASC;
```

#### **📌 解法解析**
1. **`GROUP BY user_id`**：對 `user_id` 進行分組，每個 `user_id` 是唯一的一行。
2. **`COUNT(follower_id)`**：計算 `follower_id` 的數量，即該 `user_id` 的粉絲數。
3. **`ORDER BY user_id ASC`**：按照 `user_id` 由小到大排序，符合題目要求。

#### **🔹 時間與空間複雜度分析**
- **時間複雜度：O(N)**（遍歷整個 `Followers` 表一次）
- **空間複雜度：O(1)**（結果集大小與 `user_id` 數量成正比）

---

## **🔍 進階討論**
### **🔹 如果 `Followers` 沒有某個 `user_id`，該怎麼處理？**
- 若 `Followers` 表沒有某個 `user_id`，代表該用戶 **沒有任何粉絲**，但這題沒要求回傳 `0`，所以不需要 `LEFT JOIN`。
- 但如果題目要求 **所有用戶都應該出現在結果中，即使沒有粉絲數也要顯示 `0`**，可以使用 `LEFT JOIN`。

#### **✅ 處理沒有粉絲的用戶 (`LEFT JOIN`)**
```sql
SELECT
    u.user_id,
    COUNT(f.follower_id) AS followers_count
FROM
    (SELECT DISTINCT user_id FROM Followers) u
LEFT JOIN Followers f
ON u.user_id = f.user_id
GROUP BY u.user_id
ORDER BY u.user_id ASC;
```
**這樣的作法確保了即使該 `user_id` 沒有粉絲，也會出現在結果中，粉絲數為 0。**

---

## **🎯 總結**
這道 SQL 題目考察 **GROUP BY** 和 **COUNT()** 兩個 SQL 聚合函數的應用。

**📌 核心 SQL**
```sql
SELECT
    user_id, COUNT(follower_id) AS followers_count
FROM
    Followers
GROUP BY
    user_id
ORDER BY
    user_id ASC;
```

**📌 進階解法**
- **如果用戶沒有粉絲但仍需出現在結果中** ➝ 使用 `LEFT JOIN`
- **Python Pandas 版** ➝ 使用 `groupby().size()`

**🎯 適合讀者**
✅ SQL 初學者：學習 `GROUP BY` 和 `COUNT()` 的基礎用法  
✅ 資料分析師：透過 SQL/Pandas 分析社群數據  
✅ 軟體工程師：優化社群媒體應用的粉絲數查詢  

希望這篇文章能幫助你理解 SQL 聚合函數的應用！🚀



