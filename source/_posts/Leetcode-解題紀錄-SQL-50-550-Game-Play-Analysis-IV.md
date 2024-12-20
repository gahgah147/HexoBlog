---
title: Leetcode 解題紀錄 SQL 50 - 550. Game Play Analysis IV
date: 2024-12-20 15:35:33
tags:
    - Leetcode
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/B1DiYYzSyg.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

# Leetcode 解題紀錄 SQL 50 - 550. Game Play Analysis IV


![image](https://hackmd.io/_uploads/B1DiYYzSyg.png)

### 題目背景

這題的目標是計算 **玩家首次登入後第二天是否再次登入的比例**，並將結果四捨五入至小數點後兩位。

---

### 資料表結構

```sql
Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
```

#### 解釋：
- **Primary Key**: `(player_id, event_date)`，代表每位玩家在某天的唯一活動記錄。
- **數據描述**：`player_id` 是玩家的 ID，`event_date` 是登入日期，`games_played` 是當天玩的遊戲數量。

---

### 題目要求

計算 **首次登入後第二天有再次登入的玩家比例**。若符合條件的玩家數量為 1，總玩家數為 3，則結果為：`1 / 3 = 0.33`。

---

### 解法：CTE 實現

```sql
WITH FirstLogin AS (
    SELECT 
        player_id,
        MIN(event_date) AS first_login_date
    FROM 
        Activity
    GROUP BY 
        player_id
),
NextDayLogin AS (
    SELECT 
        f.player_id
    FROM 
        FirstLogin f
    JOIN 
        Activity a
    ON 
        f.player_id = a.player_id
        AND a.event_date = DATE_ADD(f.first_login_date, INTERVAL 1 DAY)
)
SELECT 
    ROUND(COUNT(DISTINCT n.player_id) / COUNT(DISTINCT f.player_id), 2) AS fraction
FROM 
    FirstLogin f
LEFT JOIN 
    NextDayLogin n
ON 
    f.player_id = n.player_id;
```

---

### 解題步驟解析

#### 1. 獲取首次登入日期 (`FirstLogin`)
利用 `MIN(event_date)` 找出每個玩家的首次登入日期：

```sql
WITH FirstLogin AS (
    SELECT 
        player_id,
        MIN(event_date) AS first_login_date
    FROM 
        Activity
    GROUP BY 
        player_id
)
```

#### 2. 確認首次登入後第二天是否有登入 (`NextDayLogin`)
將首次登入日期與原始資料表 `Activity` 做連結，篩選出在 `first_login_date + 1` 有再次登入的玩家：

```sql
WITH NextDayLogin AS (
    SELECT 
        f.player_id
    FROM 
        FirstLogin f
    JOIN 
        Activity a
    ON 
        f.player_id = a.player_id
        AND a.event_date = DATE_ADD(f.first_login_date, INTERVAL 1 DAY)
)
```

#### 3. 計算比例並四捨五入
計算符合條件的玩家數量與總玩家數比例，並用 `ROUND` 將結果四捨五入至小數點後兩位：

```sql
SELECT 
    ROUND(COUNT(DISTINCT n.player_id) / COUNT(DISTINCT f.player_id), 2) AS fraction
FROM 
    FirstLogin f
LEFT JOIN 
    NextDayLogin n
ON 
    f.player_id = n.player_id;
```

---

### 範例數據與輸出

#### 輸入數據：

| player_id | device_id | event_date  | games_played |
|-----------|-----------|-------------|--------------|
| 1         | 2         | 2016-03-01  | 5            |
| 1         | 2         | 2016-03-02  | 6            |
| 2         | 3         | 2017-06-25  | 1            |
| 3         | 1         | 2016-03-02  | 0            |
| 3         | 4         | 2018-07-03  | 5            |

#### 輸出結果：

| fraction |
|----------|
| 0.33     |

---

### 小結

這題的核心在於：
1. **找出每個玩家的首次登入日期**。
2. **檢查首次登入的第二天是否有登入記錄**。
3. **計算符合條件玩家數與總玩家數的比例，並格式化結果**。

希望這篇文章能幫助你解題，並對 SQL 的聚合函數與日期操作有更深入的理解！

