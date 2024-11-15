---
title: 使用 Docker-Compose 部署 Next.js 應用程式
date: 2024-11-15 13:57:56
tags:
    - Docker-Compose
    - Next.js
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/HkLJfPNfyl.jpg
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---


![使用 Docker-Compose 部署 Next.js 應用程式](https://hackmd.io/_uploads/HkLJfPNfyl.jpg)

將 Next.js 應用程式容器化是一種高效的開發方式，因為它提供了更具隔離性和可重現的環境。
在部屬的時候可以省下一些重複的工作。
在本篇文章中，我將介紹如何使用 Docker 和 Docker-Compose 快速建立與執行 Next.js 應用程式。
讓我們一步步實作，從建立專案到成功啟動。

---

## 1. 建立 Next.js 專案

首先，我們需要建立一個 Next.js 應用程式。執行以下指令：

```bash
npx create-next-app docker-next
```

執行完畢後，將會建立一個名為 `docker-next` 的資料夾。


![image](https://hackmd.io/_uploads/r1r826-fJx.png)


![image](https://hackmd.io/_uploads/rJF5nTWMJx.png)

進入該資料夾：

```bash
cd docker-next
```

---



## 2. 建立 Dockerfile

在 `docker-next` 資料夾中，新增一個名為 `Dockerfile` 的檔案，並填入以下內容：

```dockerfile
FROM node:20

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

CMD ["npm", "run", "dev"]
```

> **注意：** 如果你使用不同版本的 Node.js，請將 `FROM node:20` 替換為對應版本。

---


## 3. 建立 Docker Image 並執行容器

### 建立 Docker Image
執行以下指令建立 Image：

```bash
docker build -t docker-next .
```

### 執行容器
使用以下指令運行容器：

```bash
docker run docker-next -p 3000:3000 -v /app/node_modules -v .:/app
```

- `-p 3000:3000`：將容器內的 3000 埠對應到主機的 3000 埠。
- `-v .:/app`：將當前目錄映射到容器內的 `/app` 目錄。

完成後，可透過瀏覽器訪問 [http://localhost:3000](http://localhost:3000) 查看效果。

---


## 4. 設定 Docker-Compose

為了簡化操作，可以使用 Docker-Compose 管理服務。建立一個 `docker-compose.yml` 檔案，內容如下：

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: docker-next
    ports:
      - '3000:3000'
    volumes:
      - .:/app
      - /app/node_modules
```

---


## 5. 使用 Docker-Compose 啟動專案

執行以下指令啟動專案：

```bash
docker-compose up
```

執行後，終端機會顯示成功啟用的訊息。此時，打開瀏覽器並輸入 [http://localhost:3000](http://localhost:3000)，應該可以看到預設的 Next.js 頁面。

![image](https://hackmd.io/_uploads/H1DwomNG1g.png)

![image](https://hackmd.io/_uploads/BJR-oQNzJe.png)
>成功啟用的畫面

---

## 6. 使用 Docker Desktop 驗證容器狀態（可選）

如果你使用 Docker Desktop，可以在應用程式中檢查容器的執行狀態，確認服務是否正常啟動。

![image](https://hackmd.io/_uploads/r1V2sX4GJg.png)

---

## 總結

今天整理的文章步驟如下

- **建立專案：** `npx create-next-app`
- **撰寫 Dockerfile：** 定義運行環境與應用程式啟動方式。
- **建立與執行容器：** 使用 Docker 指令啟動 Next.js。
- **簡化部署：** 配置 Docker-Compose，自動化服務管理。

這篇文章適合初學者，也可以作為日後快速部署 Next.js 的參考。如果有任何問題或建議，歡迎在留言區與我交流！ 😊

---