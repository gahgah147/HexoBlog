---
title: Leetcode 練習 - 596. Classes More Than 5 Students
date: 2024-12-27 11:21:46
tags:
    - Leetcode
categories:
keywords:
description:
top_img:
comments:
cover:
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---


![image](https://hackmd.io/_uploads/Hkc-Tcirkl.png)

### **背景**
在學校課程系統中，我們經常需要統計學生選課的情況，特別是找出那些參加人數較多的課程。例如，我們可能想了解哪些課程非常受歡迎，以便更好地分配教學資源。

這次，我們將解決一個類似的問題：找出學生人數至少 5 人的課程。

---

### **題目**

**Table**: `Courses`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
```

- `(student, class)` 是表的主鍵，表示每位學生唯一對應一門課程。
- 每行表示學生的名字以及他選修的課程名稱。

我們需要寫出一個 SQL 查詢，找出所有至少有 5 位學生的課程，並以 **任意順序** 返回。

---

### **範例**

**輸入：**

Courses 表：
```
+---------+----------+
| student | class    |
+---------+----------+
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |
+---------+----------+
```

**輸出：**
```
+---------+
| class   |
+---------+
| Math    |
+---------+
```

**解釋：**
- **Math**：有 6 位學生，符合條件。
- **English**、**Biology**、**Computer**：各只有 1 位學生，不符合條件。

---

### **解法**

我們可以用 SQL 查詢來解決這個問題，步驟如下：

```sql
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
```

**逐步解析：**
1. **`GROUP BY class`**：將所有行按 `class` 分組，每個課程成為一組。
2. **`COUNT(student)`**：計算每個課程組中的學生數量。
3. **`HAVING COUNT(student) >= 5`**：篩選出學生數量大於等於 5 的課程。
4. **`SELECT class`**：返回符合條件的課程名稱。

---

### **延伸思考**

1. 如果要查找學生少於 5 人的課程，只需將 `HAVING` 條件改為：
   ```sql
   HAVING COUNT(student) < 5;
   ```

2. 如果需要同時返回課程名稱和學生數量：
   ```sql
   SELECT class, COUNT(student) AS student_count
   FROM Courses
   GROUP BY class
   HAVING COUNT(student) >= 5;
   ```

3. 如果要返回學生數量最多的課程，可以用：
   ```sql
   SELECT class, COUNT(student) AS student_count
   FROM Courses
   GROUP BY class
   ORDER BY student_count DESC
   LIMIT 1;
   ```

---

### **結語**

這題幫助我們練習了 SQL 中的分組與聚合操作，也是數據分析中的基礎技巧。在實際工作中，類似的問題可以應用於課程報名、人數統計等場景。希望大家能舉一反三，應用到更多的場景中！
