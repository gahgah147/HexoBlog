---
title: 資料庫:Ubuntu 使用 PostgreSql，搭配 pgAdmin4 圖形化介面操作
date: 2024-11-01 13:58:12
tags:
    - PostgreSQl
    - 資料庫
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/SJZCoyfZJg.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---


![image](https://hackmd.io/_uploads/SJZCoyfZJg.png)


我在之前專案都是習慣使用 MySQL 做開發，在新專案中，我們選擇 PostgreSQL 作為主要資料庫管理系統，它具有強大的 ACID 特性和可擴展性。
為了便於管理資料庫，我使用 pgAdmin4 作為圖形化界面操作，本文將分享如何在 Ubuntu 上安裝 PostgreSQL 以及 pgAdmin4 的基本設定方法。

# 什麼是 PostgreSQL？

![image](https://hackmd.io/_uploads/Hy_3GVUgkl.png)
>https://www.postgresql.org/

PostgreSQL（常縮寫為 Postgres）是一個功能強大的開源關聯式資料庫管理系統（RDBMS）。它由加州大學柏克萊分校於 1986 年開發而來，並且自 1996 年正式以 PostgreSQL 名稱發布。PostgreSQL 以其高穩定性、豐富的功能和開放的社群支持而聞名，成為眾多企業和開發者在建構資料密集型應用時的首選。

# PostgreSQL 的核心功能

1. 完全的 ACID 支援
PostgreSQL 遵循 ACID（原子性、一致性、隔離性、持久性）原則，提供強大的事務處理功能，保證數據操作的安全性和一致性，這使其適合處理關鍵任務的應用程式。

2. 先進的查詢優化器
PostgreSQL 內建一個強大的查詢優化器，可以針對每個查詢自動選擇最佳的執行計畫，以提升執行效率，尤其在面對大型資料集時效果更為顯著。

3. 擴展性與模組化設計
PostgreSQL 支援使用者自訂的函式、型別和索引，甚至可以創建自訂演算子，滿足多樣化的業務需求。此外，透過擴充模組，使用者可以將 PostGIS 等擴展功能加入 PostgreSQL，進行地理資料處理。

4. 多樣的資料型別
除了標準的數值、文字、時間等型別外，PostgreSQL 還支援 JSON、hstore、陣列、範圍等複雜型別，這使得開發者可以更靈活地儲存非結構化數據。

5. 多版本併發控制（MVCC）
PostgreSQL 內建多版本併發控制技術，可以在不鎖定資料的情況下實現並發操作，減少系統阻塞的情況，提升整體性能。

# PostgreSQL 的優勢

1. 穩定可靠：多年來，PostgreSQL 已被證明為高可靠性、高穩定性的資料庫解決方案，適合用於要求嚴謹的生產環境。

2. 開源與活躍的社群：PostgreSQL 是完全開源的，並擁有龐大的開發社群，為其提供持續的支援與更新，使其可以快速回應新技術需求和安全漏洞。

3. 支援 NoSQL 功能：PostgreSQL 除了是關聯式資料庫，還能處理 JSON 等非結構化數據，具備 NoSQL 資料庫的靈活性。這讓它成為一個同時支援 SQL 和 NoSQL 的多功能資料庫。

4. 跨平台支援：PostgreSQL 可以在多種作業系統（如 Linux、Windows、macOS）上運行，適合不同的開發環境需求。

# PostgreSQL 的適用場景

1. 企業級應用
由於 PostgreSQL 的高穩定性和強大事務支援，許多企業選擇將其用於金融、電信等關鍵任務應用程式。例如，大量需要保證數據一致性的財務系統就非常適合採用 PostgreSQL。

2. 資料密集型應用
PostgreSQL 能處理龐大的數據量，並且在查詢和操作速度上表現良好。對於需要大量數據分析的應用，例如電子商務、用戶行為分析等，PostgreSQL 是理想的選擇。

3. 地理資訊系統（GIS）
透過 PostGIS 擴展，PostgreSQL 提供了豐富的空間資料處理功能，支援地理座標、地圖等數據的處理。這對於地理資訊系統或與地理位置相關的應用非常實用，例如地圖應用、物流管理系統等。

4. 結合 NoSQL 的應用
當應用程序同時需要處理結構化和非結構化數據時，PostgreSQL 的 JSON 和 XML 支援使其成為合適的選擇，這樣開發者可以在一個資料庫中同時處理關聯式和非關聯式數據。

# MySQL 與 PostgreSQL 之間有什麼差異？

跟相同是關聯式資料庫的 Mysql 有什麼差異呢?
以下aws有整理出一個比對

![image](https://hackmd.io/_uploads/ryGF9JzWJg.png)
>https://aws.amazon.com/tw/compare/the-difference-between-mysql-vs-postgresql/

MySQL 是一個關聯式資料庫管理系統，可讓您將資料做為包含資料列和資料欄的資料表來存放。這是一種常用的系統，可為眾多 Web 應用程式、動態網站和內嵌式系統提供支援。PostgreSQL 是一個物件關聯式資料庫管理系統，可提供比 MySQL 更多的功能。使用該系統，您在資料類型、可擴展性、並行性和資料完整性方面具有更大的靈活性。

也就是說 PostgreSQL 是一個物件關連式資料庫提供比 MySQL 更多進階功能。

PostgreSQL 與 MySQL 的差異摘要:

| 類別         | MySQL                                      | PostgreSQL                                                                                                                                                  |
|--------------|-------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **資料庫技術** | 純粹的關聯式資料庫管理系統                | 物件型關聯式資料庫管理系統                                                                                                                                  |
| **功能**      | 對檢視、觸發程序和程序等功能的支援有限   | 支援進階功能，如具體化視觀表、INSTEAD OF 觸發程序、多種語言的預存程序                                                                                     |
| **資料類型**  | 支援數字、字元、日期與時間、空間、JSON  | 支援所有 MySQL 的資料類型，並額外支援幾何、枚舉、網路地址、陣列、範圍、XML、hstore、複合等多樣化資料類型                                                  |
| **ACID 合規** | 僅在 InnoDB 和 NDB 叢集存儲引擎符合 ACID | 始終符合 ACID                                                                                                                                               |
| **索引**      | 支援 B 型樹狀結構和 R 型樹狀結構索引      | 支援多種索引類型，如表達式索引、部分索引、雜湊索引和多種樹狀結構                                                                                          |
| **效能**      | 高頻讀取操作效能較佳                      | 高頻寫入操作效能較佳                                                                                                                                       |
| **初學者支援**| 容易上手，工具支援較廣泛                  | 相對較複雜，非技術使用者的工具集有限                                                                                                                       |



# PostgreSQL 安裝與基本使用

官方安裝 PostgreSQL 的頁面

點選Download
![image](https://hackmd.io/_uploads/r100MEUgkg.png)

## Linux 系統安裝
![image](https://hackmd.io/_uploads/rJEu3fwlkl.png)

這邊我選擇 Ubuntu
![image](https://hackmd.io/_uploads/B1vAnMvlJl.png)

##  Linux 安裝 PostgreSQL 步驟 

### 選項 1：Linux 使用內建套件庫安裝 PostgreSQL
這個方式簡單快速，但可能不是最新版本。

#### 更新套件庫：
```
sudo apt update
```

#### 安裝 Postgres 套件以及添加一些額外實用程式和功能的 -contrib 套件：
```
sudo apt install postgresql postgresql-client postgresql-contrib postgresql-common
```

#### 檢查 PostgreSQL 服務狀態：
```
sudo systemctl start postgresql.service
```

若服務正常運行，你應該會看到類似於 active (running) 的訊息。
![image](https://hackmd.io/_uploads/rJ3vyXPeJl.png)
>像圖中這邊有 active (exited)代表正在運行

#### 連接到 PostgreSQL： 使用 psql 工具進入 PostgreSQL。
```
sudo -u postgres psql
```
![image](https://hackmd.io/_uploads/Hk_wxQvlJe.png)

在 psql 內，你可以執行 SQL 指令。例如：
```
\l   -- 列出所有資料庫
\q   -- 退出 psql
```
![image](https://hackmd.io/_uploads/ryPieXvl1l.png)

#### 檢查 PostgreSQL 版本
```
psql --version
```
![image](https://hackmd.io/_uploads/SJJpfXwe1l.png)

### 選項 2：透過 PostgreSQL 官方 Apt Repository 安裝（建議使用）
如果你想使用較新的 PostgreSQL 版本，請依照以下步驟：

#### 安裝所需工具
```
sudo apt install -y curl ca-certificates gnupg
```
![image](https://hackmd.io/_uploads/r1sgz7wlyg.png)


#### 匯入 PostgreSQL 簽名金鑰
```
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /usr/share/keyrings/postgresql.asc
```
![image](https://hackmd.io/_uploads/Byy4fmwl1e.png)


#### 添加 PostgreSQL 官方 Repository
```
echo "deb [signed-by=/usr/share/keyrings/postgresql.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
```
![image](https://hackmd.io/_uploads/rJAYGmwx1x.png)


#### 更新套件列表：

```
sudo apt update
```
![image](https://hackmd.io/_uploads/Sye_jMmPlyg.png)

#### 安裝 PostgreSQL： 這裡將安裝最新版本。如果你需要特定版本，如 PostgreSQL 16，可以將 postgresql 替換為 postgresql-16。

```
sudo apt -y install postgresql
```

![image](https://hackmd.io/_uploads/SyDEmmwx1x.png)


#### 啟動並檢查 PostgreSQL 服務狀態：
```
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo systemctl status postgresql
```
![image](https://hackmd.io/_uploads/rkg877PxJg.png)


#### 使用 psql 連接 PostgreSQL：
```
sudo -u postgres psql

```

![image](https://hackmd.io/_uploads/SkwkV7wgyg.png)

#### 檢查 PostgreSQL 版本
```
psql --version
```
![image](https://hackmd.io/_uploads/SJvEVQDgJl.png)

這邊可以看到使用方法二安裝的postgreSQL 版本是 17.0

#### 建立新資料庫與使用者（選用）： 在 psql 內，你可以使用以下指令建立新的資料庫和使用者：
```
CREATE DATABASE mydb;
CREATE USER myuser WITH ENCRYPTED PASSWORD 'mypassword';
GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;
```

## 驗證安裝是否成功
### 檢查 PostgreSQL 版本
```
psql --version
```

### 確認你可以登入資料庫並執行 SQL 指令：
```
sudo -u postgres psql
```

# 問題排解

## 常見問題與解決方式

### 檢查 `public` Schema 權限


應用程式在使用 TypeORM 連接 PostgreSQL 資料庫時，遇到 `permission denied for schema public` 的權限問題。

---
即使你已授予部分權限，可能還有一些權限不足或授權未正確應用。

1. **確認用戶是否擁有 `public` schema 的完整權限：**
   重新進入 PostgreSQL 並檢查目前的權限：

   ```bash
   sudo -u postgres psql
   \c <your_db>
   ```

   執行：
   ```sql
   SELECT grantee, privilege_type 
   FROM information_schema.role_table_grants 
   WHERE table_schema = 'public';
   ```

2. **確保授予足夠的權限：**
   再次執行以下指令，確保 `<user>` 用戶擁有所有必須的權限：

   ```sql
   GRANT USAGE, CREATE ON SCHEMA public TO <user>;
   GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO <user>;
   GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO <user>;
   ALTER SCHEMA public OWNER TO <user>;
   ```


### PostgreSQL 服務無法啟動
確保安裝過程順利完成，並檢查服務日誌：
```
sudo journalctl -u postgresql
```

### 防火牆阻擋遠端連線
如果需要從遠端連接 PostgreSQL，請確保防火牆已開啟所需的埠（預設為 5432）
```
sudo ufw allow 5432/tcp

```
### 修改 PostgreSQL 設定允許遠端連線
編輯 PostgreSQL 的設定檔 /etc/postgresql/版本號/main/postgresql.conf：
```
listen_addresses = '*'

```

然後在 /etc/postgresql/版本號/main/pg_hba.conf 中新增：
```css
host    all             all             0.0.0.0/0            md5

```
重新啟動服務
```
sudo systemctl restart postgresql

```

## windows系統安裝

{% note warning simple %}
我這邊實測windows安裝比較多問題，我決定要先嘗試用linux下載postgresql設定server ，但是後續會使用到`pgAdmin4` 功能來圖形化連接操作，所以大家可以先跳到設定 `pgAdmin4`這邊

{% endnote %}
點選Windows
![image](https://hackmd.io/_uploads/HyIl7VLlJx.png)
點選 Download the installer

![image](https://hackmd.io/_uploads/HypzmEIg1e.png)
選擇合適的版本

下載完成後執行開始安裝
![image](https://hackmd.io/_uploads/HyN37VLeJg.png)


![image](https://hackmd.io/_uploads/r1A27EUxkl.png)

![image](https://hackmd.io/_uploads/By66QV8x1l.png)


![image](https://hackmd.io/_uploads/rJUCX4UlJx.png)
選擇安裝路徑

![image](https://hackmd.io/_uploads/rJOkENIlkl.png)
這邊設定資料庫密碼

![image](https://hackmd.io/_uploads/H12gVV8xkx.png)
這邊設定PORT 

![image](https://hackmd.io/_uploads/SJQ_NNUgke.png)
選擇地點，這邊可以選擇Taiwan

![image](https://hackmd.io/_uploads/r1jjNELgkx.png)

![image](https://hackmd.io/_uploads/BkB3EE8gyl.png)

![image](https://hackmd.io/_uploads/BJz6V4Uekx.png)


開啟  PostgreSQL 

開啟開始工具列，搜尋並打開 PostgreSQL 的目錄，點選執行＂SQL Shell (psql)＂。

![image](https://hackmd.io/_uploads/S1qYY4Ie1x.png)

{% note warning simple %}
這邊我有遇到這個錯誤
![image](https://hackmd.io/_uploads/H1lr4r8l1l.png)

這邊應該是權限不足，可以使用系統管理員再安裝一次
{% endnote %}

 輸入連線資訊，先按預設值照著打。Password 就前面安裝時輸入的密碼。

![image](https://hackmd.io/_uploads/Byta9EUxkx.png)


# 設定 `pgAdmin4`
## Step 1. 設定 PostgreSQL 所在位置

點選 `Add New Server`

![image](https://hackmd.io/_uploads/rkMBPVUgJg.png)


## Step 2. 設定連線名稱
設定Server資料，通常這個Server我會直接設成local，因為它代表著local的資料

![image](https://hackmd.io/_uploads/SkvoDNLe1g.png)

## Step 3. 設定所要連線到的 `PostgreSQL` 的 `IP`

`Connection` 頁籤中的 `Host name/address` 欄位輸入 `PostgreSQL` 的 `IP`

`Connection` 頁籤中的 `Password` 欄位輸入 `postgres` 帳號的登入密碼


![image](https://hackmd.io/_uploads/r1Q3PwyZke.png)

之後就可以成功進入該Server的Database了

![image](https://hackmd.io/_uploads/HJZ4_DJZyx.png)


接下來點擊資料庫之後可以下 query 開始查詢使用資料庫，這邊使用起來就跟phpmyadmin大同小異了。

# 總結

PostgreSQL 是一個非常強大且靈活的資料庫解決方案，其豐富的功能、穩定性、擴展性和開源性，使其成為現代企業和開發者的理想選擇。無論是處理高併發的應用場景，還是需要處理複雜查詢的分析應用，PostgreSQL 都能夠滿足需求。

如果你正在尋找一個穩定、擴展性高且支持 NoSQL 功能的資料庫，那麼 PostgreSQL 無疑是一個值得考慮的選擇。希望這篇文章能幫助你更好地了解 PostgreSQL 的特點與應用！
