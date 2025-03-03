---
title: Casdoor 部署：從安裝到運行的操作紀錄
date: 2025-03-03 10:33:44
tags:
    - Casdoor
    - SSO
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/ByJluhaqJl.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

# Casdoor 部署：從安裝到運行的操作紀錄
![image](https://hackmd.io/_uploads/ByJluhaqJl.png)


![image](https://hackmd.io/_uploads/Byn5qs59kg.png)
>https://casdoor.org/docs/basic/server-installation/


## 1. 前言

Casdoor 是一款強大的 SSO（單一登入）身份認證系統，支援 OAuth 2.0 和 OpenID Connect，適用於多種應用場景。本篇文章將詳細介紹如何在本地或伺服器上部署 Casdoor，並進行基本配置。


---

## 2. 環境需求
在開始部署 Casdoor 之前，請確保您的系統滿足以下條件：

### **作業系統**
- Windows、Linux 或 macOS（均受支援）

### **必要軟體**
- **Go 1.17+**（後端語言）
- **Node.js LTS (18)**（前端框架）
- **Yarn 1.x**（推薦使用 Yarn 來管理前端依賴，避免 UI 樣式問題）

:::info
如果您的網路無法正常同步 Go 依賴包，建議使用 `https://goproxy.cn/` 作為 Go 代理。
:::

### **資料庫支援**
Casdoor 使用 XORM 作為 ORM，支援以下數據庫：
- MySQL
- MariaDB
- PostgreSQL
- CockroachDB
- SQL Server
- Oracle
- SQLite 3
- TiDB

---

## 3. 下載 Casdoor 原始碼
Casdoor 的原始碼托管於 GitHub，您可以使用 `git` 指令下載：

```sh
cd path/to/folder
git clone https://github.com/casdoor/casdoor
```

下載後，您將獲得包含前端（React）和後端（Go）的完整代碼庫。

---

## 4. 配置數據庫
根據您選擇的數據庫，修改 `conf/app.conf` 文件。

### **MySQL 配置**

```ini
driverName = mysql
dataSourceName = root:123456@tcp(localhost:3306)/
dbName = casdoor
```

:::info
請確保 MySQL 數據庫已手動創建，名稱為 `casdoor`。
:::

### **PostgreSQL 配置**

```ini
driverName = postgres
dataSourceName = "user=postgres password=postgres host=localhost port=5432 sslmode=disable dbname=casdoor"
dbName = casdoor
```

### **SQLite3 配置**

```ini
driverName = sqlite
dataSourceName = "file:casdoor.db?cache=shared"
dbName = casdoor
```

---

## 5. 啟動 Casdoor
Casdoor 提供兩種運行模式：**開發模式** 和 **生產模式**。

### **開發模式**

1. **啟動後端（Go）**

```sh
go run main.go
```

![image](https://hackmd.io/_uploads/S1oYhta5yl.png)
> 成功啟動後端的畫面


2. **啟動前端（React）**

```sh
cd web
yarn install
yarn start
```

![image](https://hackmd.io/_uploads/SyaODs6cJg.png)

3. **訪問 Casdoor 後台**

開啟瀏覽器，訪問 `http://localhost:7001`，使用預設管理員帳號登入：

- **帳號：** `admin`
- **密碼：** `123`

這邊是成功登入的畫面

![image](https://hackmd.io/_uploads/ByCrss691g.png)
>http://localhost:7001/

### **生產模式**

1. **編譯後端**

```sh
go build
./casdoor
```

2. **編譯前端**

```sh
cd web
yarn install
yarn build
```

3. **訪問 Casdoor**

瀏覽器打開 `http://localhost:8000`，使用管理員帳號登入。

- **帳號：** `admin`
- **密碼：** `123`



---

## 6. Casdoor 端口設定
根據不同環境，請確保使用正確的端口：

- **開發模式：** `http://localhost:7001`
- **生產模式：** `http://localhost:8000`

若有需求變更端口，請修改 `conf/app.conf` 中的 `httpport` 參數。

---

## 7. 結語
至此，您已成功部署 Casdoor，並完成基本的配置與運行。如果您希望進一步整合到您的應用中，可以參考官方文檔進行 API 調用、OAuth 配置等。
