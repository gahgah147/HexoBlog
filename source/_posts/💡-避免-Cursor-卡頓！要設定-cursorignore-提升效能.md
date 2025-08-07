---
title: 💡 避免 Cursor 卡頓！要設定 .cursorignore 提升效能
date: 2025-08-07 15:29:52
tags:
    - Cursor
categories:
keywords:
    - Cursor
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

# 💡 避免 Cursor 卡頓！要設定 `.cursorignore` 提升效能

> 🛠 適用對象：使用 [Cursor AI 編輯器](https://www.cursor.sh) 且專案變大後開始卡頓的開發者

---

## 🐢 為什麼 Cursor 用久了會越來越卡？

我們團隊有同事在使用 Cursor 處理大型 monorepo 或資料分析專案時，發現 IDE 開始變得卡頓，出現以下狀況：

* 啟動變慢，載入 Workspace 花很久
* 滑鼠操作延遲，跳轉/補全功能不穩
* 問 AI 問題時明顯 lag
* 系統 CPU / 記憶體使用飆高

其實這些問題，多半來自一個被忽略的小東西：**沒有設定 `.cursorignore`**。

---

## 🧩 `.cursorignore` 是什麼？

`.cursorignore` 就像 `.gitignore` 一樣，是一個你可以放在專案根目錄的檔案，用來告訴 Cursor：

> 哪些檔案或資料夾你不希望它載入、索引或提供 AI 分析。

這可以大幅減少系統負擔，避免浪費資源在「你根本不在乎的檔案」上。

---

## 🛠 怎麼設定 `.cursorignore`？

### 第一步：在專案根目錄建立 `.cursorignore`

```bash
touch .cursorignore
```

### 第二步：加入以下建議設定

```gitignore
# 相依與環境資料夾
node_modules/
.venv/
.env/
__pycache__/

# Build / 輸出檔
dist/
build/
out/

# Python 中介檔
*.pyc

# 測試快照 / coverage
coverage/
*.snap
.nyc_output/

# 大型靜態資料
*.csv
*.tsv
*.log
*.json
*.sqlite
*.db
*.zip

# 可選的資料夾
public/
data/
```

這些設定可以避免 Cursor 去載入成千上萬個不必要的檔案。

---

## ✨ 小技巧：請 Cursor 幫你產生 `.cursorignore`

其實 Cursor 本身就有內建 AI，可以根據你的專案結構主動建議應該忽略的項目。

### ✅ 使用方式：

1. 打開 Cursor 的 Command 面板（Mac：`⌘ + K`，Windows：`Ctrl + K`）

2. 輸入並執行以下 Prompt：

   ```
   幫我依照這個專案產生一個 .cursorignore 設定檔案
   ```

3. Cursor 會根據你的專案結構自動產生 `.cursorignore` 建議，並顯示在側邊編輯器中，讓你直接套用或微調。

---

### 🧪 使用建議：

* 特別適合剛 clone 下來的新專案，或接手別人維護的 codebase。
* 避免忘記忽略某些資料夾，例如 `.next/`、`.turbo/`、`dataset/` 等。
* 可搭配手動編輯 `.cursorignore`，達到最理想的排除效果。

---

## ✅ 設定後的改善效果

只要設定好 `.cursorignore`，並重新載入 Workspace，你會明顯感受到：

* 🚀 啟動速度變快
* 🤖 問 AI 回應速度變快
* 💻 記憶體 / CPU 使用降低
* 🧠 AI 建議更準確（少了多餘干擾資料）

---

## 🧪 實用建議與小技巧

* `.cursorignore` 語法與 `.gitignore` 相同，支援萬用字元與資料夾排除。

* monorepo 架構的話，**每個子資料夾都建議加上 `.cursorignore`**。

* 可以加註註解提醒團隊成員，例如：

  ```gitignore
  # 資料訓練集太大，排除
  data/raw/
  ```

* 團隊開發建議把 `.cursorignore` 一起 commit 到 Git，確保成員都有一致體驗。

---

## 🧭 結語

Cursor 是個非常強大的 AI 編輯器，但它再聰明，也需要你幫它「聚焦」。
透過 `.cursorignore`，你可以讓 AI 更專注在重要的程式碼邏輯上，**也讓你的電腦喘一口氣**。

別再讓 AI 幫你讀 `node_modules` 或 `data.csv` 了 😅

---

📌 如果你覺得這篇文章對你有幫助，歡迎分享給使用 Cursor 的同事、朋友！
💬 有什麼 `.cursorignore` 實用技巧，也歡迎留言交流！

---

✏️ **附註**：這是我在使用 Cursor 開發中整理出的心得，也歡迎大家一起優化自己的開發環境！

---
