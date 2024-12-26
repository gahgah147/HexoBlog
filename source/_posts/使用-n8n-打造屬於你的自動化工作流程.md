---
title: 使用 n8n 打造屬於你的自動化工作流程
date: 2024-12-26 11:10:19
tags:   
    - 自動化
    - n8n
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/rklSEHcr1g.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

# 使用 n8n 打造屬於你的自動化工作流程

![image](https://hackmd.io/_uploads/rklSEHcr1g.png)

n8n 是一款 開源、免費 的工作流程自動化工具，具有高度靈活性與可擴展性。不僅支援桌面版，還可透過自建環境或 Docker 快速架設，讓使用者能透過拖拉點選的方式輕鬆創建屬於自己的工作流程。

可以輕鬆串接多個應用程式與服務，實現流程自動化。

不僅如此，n8n 提供靈活的設計，讓開發者能輕鬆擴展功能，是一款適合各種場景的自動化解決方案。

---

## 什麼是 n8n？

![image](https://hackmd.io/_uploads/rJl0QB5Syx.png)
>https://n8n.io/

n8n（pronounced as "nodemation"）是一個用 Node.js 打造的自動化工具，具有以下特性：

1. **豐富的整合功能**  
   - 提供多種節點，例如：Webhook、Cron Job、HTTP Request、HTML Extract 等功能，幾乎涵蓋網站資料處理的所有需求。

2. **完整的官方文件**  
   - 每個功能都有詳細的基礎教學與說明，初學者也能快速上手。詳見 [n8n 官方文件](https://docs.n8n.io)。

3. **支援 JavaScript 自定義節點**  
   - 使用者可以撰寫自己的 JavaScript 節點，也能在現有節點中運用 JavaScript 進行操作（例如：日期處理、字串運算、計算長度等）。  

4. **多元社群與平台整合**  
   - 支援整合的社群與聯絡平台包括：  
     - SendGrid  
     - LINE  
     - Slack  
     - Telegram  
     - Twitter  

5. **雲端服務整合**  
   - 支援整合的雲端平台如：  
     - GCP  
     - AWS  
     - Azure  
     - Airtable  
     - Box  

![image](https://hackmd.io/_uploads/HyhQOr5Byl.png)


## **特點總結**  
- **完全開源**：n8n 是全開源工具，提供最大自由度。
- **可擴展性**：不僅支援大量現成服務，還能根據需求自定義新功能。
- **學習成本低**：官方提供的文件與範例教學友好，適合快速入門。  

GitHub Repo：[https://github.com/n8n-io/n8n](https://github.com/n8n-io/n8n) 


---

## n8n 安裝與啟用

以下是如何快速在本地運行 n8n 的步驟：

### 步驟 1. 下載 n8n 專案

首先，將 n8n 的原始碼下載到本地。

```bash
git clone git@github.com:n8n-io/n8n.git
```

### 步驟 2. 使用 Docker 啟動 n8n

假設你的專案放在 `/home/nalson/練習/n8n`，可以使用以下指令啟動：

```bash
sudo docker run -it --rm --name n8n \
  -p 5678:5678 \
  -v /home/nalson/練習/n8n:/home/node/.n8n \
  n8nio/n8n
```

### 步驟 3. 設定時區

為了確保 Cron job 或時間相關功能正確運行，可以設定服務的時區。例如：

```bash
sudo docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -e GENERIC_TIMEZONE="Asia/Taipei" \
  -e TZ="Asia/Taipei" \
  n8nio/n8n
```

---

## 執行結果

![image](https://hackmd.io/_uploads/SyUyIBcH1g.png)

成功啟動後，打開瀏覽器並輸入 [localhost:5678](http://localhost:5678)，進入 n8n 的 Web UI。

![image](https://hackmd.io/_uploads/Hy8ZIr5Syl.png)
設定完成後可以看到這邊的問卷
![image](https://hackmd.io/_uploads/HkQfUSqS1g.png)

![image](https://hackmd.io/_uploads/ryufUBqrJg.png)
結果畫面:
![image](https://hackmd.io/_uploads/SkmwIrqHke.png)

完成註冊並登入後，你就可以開始設計屬於你的自動化工作流程！

---

## 使用情境
以下是一些常見的應用場景：
- **定時抓取資料**：從 API 或網頁擷取數據並儲存到資料庫。
- **跨服務整合**：將新電子郵件自動同步到 Google Sheets。
- **通知提醒**：當指定條件滿足時，發送 Slack 通知。

n8n 的官方網站提供了豐富的文件與範例，幫助使用者快速上手。你可以參考這些資源，探索更多可能性：
![image](https://hackmd.io/_uploads/rycCDB5HJx.png)

---

## 注意事項

1. **記得註冊後再使用**：n8n 的工作流程會存儲在用戶資料中。如果未註冊，重啟 Docker 後將無法找回編輯過的工作流程。
2. **慎記密碼**：在啟用電子郵件服務之前，「忘記密碼」功能無法使用。

---

## 結語

n8n 是一個功能強大且靈活的自動化工具，無論是處理日常任務，還是搭建複雜的數據工作流程，都能輕鬆勝任。試試看，讓 n8n 為你節省時間並提高效率吧！

