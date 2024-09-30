---
title: GCP - 儲存服務與資料庫工具整理與選擇整理
date: 2024-09-20 09:52:54
tags:
    - GCP
    - 雲端服務
    - 資料庫
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/Hk8cKwK6R.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

![image](https://hackmd.io/_uploads/B1XjX8cpC.png)
> GCP的儲存服務與

![image](https://hackmd.io/_uploads/HJOPXL9pC.png)
> GCP的資料庫

Google 推出了很多種儲存跟資料庫的服務，選擇合適的儲存解決方案對於確保應用程式的效能與可擴展性至關重要。Google Cloud Platform (GCP) 提供了多樣化的儲存產品，每種產品針對不同的應用場景與需求進行了優化。今天將透過一個決策流程，幫助您快速理解並選擇適合的 GCP 儲存方案。

大家可以在下面這個網址找到GCP具體總共有哪些服務與圖示
![image](https://hackmd.io/_uploads/ryV1cDY6R.png)

>https://googlecloudcheatsheet.withgoogle.com/

# GCP 有哪些儲存服務與資料庫工具?
![image](https://hackmd.io/_uploads/Hk8cKwK6R.png)


## Cloud Storage
![cloud-storage-productcard](https://hackmd.io/_uploads/B1gG2vtTC.jpg)

Cloud Storage 是 Google Cloud 提供的物件存儲解決方案，適合儲存大量的非結構化數據，如圖片、影片、備份文件等。它具備高度耐久性和可擴展性，適合需要長期存儲和全球訪問的應用程式。

## Cloud Bigtable
![cloud-bigtable-productcard](https://hackmd.io/_uploads/SkxV3PF60.jpg)

Cloud Bigtable 是一個高效能的 NoSQL 資料庫，特別適合大規模數據分析、物聯網數據處理和金融資料管理。它以極低延遲和高吞吐量著稱，適用於需要快速讀寫大量資料的應用場景。

## Cloud Datastore
![datastore-productcard](https://hackmd.io/_uploads/r17PhPYTC.jpg)

Cloud Datastore 是一個分散式 NoSQL 文件資料庫，專為需要高擴展性的應用程式設計。它支持強一致性和事務處理，適合用於儲存具有複雜查詢需求的半結構化數據。

## Cloud Firestore
![firestore](https://hackmd.io/_uploads/ryP3aDF6A.png)

Cloud Firestore 是 Firebase 的一部分，提供即時同步功能，支援 Web 和移動應用程式。它與 Cloud Datastore 有相似之處，但針對即時應用進行了優化，特別適合多設備同步和快速更新數據的應用程式。

## Cloud SQL
![cloud-sql-productcard](https://hackmd.io/_uploads/H1B_3PtaR.jpg)

Cloud SQL 是一個全託管的關聯式資料庫服務，支持 MySQL、PostgreSQL 和 SQL Server。它提供自動化的備份、擴展和維護功能，適合需要傳統 SQL 資料庫的應用程式。

## Persistent Disk
![persistent-disk-productcard](https://hackmd.io/_uploads/H1ASnvtaC.jpg)

Persistent Disk 是一個高性能的持久化塊存儲，主要用於虛擬機器（VM）的數據存儲。它具備高可用性和可擴展性，適合需要快速存取和持久化數據的 VM 應用場景。

## Filestore
![filestore](https://hackmd.io/_uploads/ByTv6vY6A.png)
Filestore 是一個完全託管的檔案存儲服務，支援 NFS（網路檔案系統）協議，適合需要低延遲、高效能的工作負載，如機器學習模型訓練和基於檔案的應用程式。

## MemoryStore
![memorystore](https://hackmd.io/_uploads/HJ8q6PKaC.png)

MemoryStore 是一個完全託管的內存資料庫服務，支持 Redis 和 Memcached。它主要用於緩存數據，提升應用程式的讀取性能，適合需要極低延遲的應用場景。

## Local SSD
![image](https://hackmd.io/_uploads/r1NxV85a0.png)

Local SSD 是 Google Cloud 提供的高速本地存儲，直接連接到虛擬機器（VM）。與 Persistent Disk 不同，Local SSD 提供更高的 IOPS 和更低的延遲，適合需要極高效能的工作負載，如數據庫應用和實時數據處理。需要注意的是，Local SSD 的數據在 VM 停止時不會保留，因此適合臨時數據的存儲需求。

## Backup And DR Service
![image](https://hackmd.io/_uploads/S1LfNL96R.png)
Backup and DR Service 是 GCP 提供的備份與災難恢復解決方案，專為確保數據安全和業務連續性設計。它支持自動化備份管理，幫助企業快速從故障或災難中恢復數據。此服務適合需要數據保護和高可用性的業務。

## Alloy DB
![image](https://hackmd.io/_uploads/HytrQUcT0.png)

AlloyDB 是 Google Cloud 針對高效能工作負載打造的託管 PostgreSQL 資料庫服務。它結合了 Google Cloud 的基礎架構與開源 PostgreSQL，提供極高的性能、可用性和擴展性，適合需要同時滿足高效能與 SQL 功能的應用場景。

什麼是 Alloy DB? 官方介紹影片
https://youtu.be/YODa-x0_3l0

![image](https://hackmd.io/_uploads/SybfmI5T0.png)


## Cloud Spanner
![cloud_spanner](https://hackmd.io/_uploads/HkBSx_taR.png)

Cloud Spanner 是全球分散式的關聯式資料庫，支援水平擴展和強一致性，適合需要高可用性、可擴展性和一致性的應用程式。它是 GCP 的旗艦數據庫服務之一，能同時支持全球分佈的資料寫入和複雜查詢。

## Database Migration Service
![database_migration_service](https://hackmd.io/_uploads/B1uUgdYaC.png)

Database Migration Service 是一個完全託管的資料庫遷移工具，支持將 MySQL、PostgreSQL 和 SQL Server 資料庫無中斷地遷移到 Google Cloud。它簡化了數據庫的遷移過程，確保應用程式能在遷移期間持續運行。

# 如何判斷要選擇什麼產品?

這邊有一個決策樹可以參考
![image](https://hackmd.io/_uploads/B1cTEwKaA.png)

### 1. 資料是否需要直接與使用者互動？

這是選擇儲存方案的第一個問題。如果您的應用程式需要處理來自使用者的即時請求（例如文件上傳或下載），這將大大影響您的選擇。

- **需要 Media SDK**：如果您的應用程式需要支援多媒體處理，則 **Firebase Storage** 是最合適的選擇。Firebase 提供了強大的 SDK，讓您可以輕鬆地與客戶端互動。
- **不需要 Media SDK**：如果不需要多媒體處理，那麼 **Cloud Storage** 是最常用的選擇。它是一個物件存儲服務，適合處理大規模非結構化數據，如圖片、影片、備份檔案等。

### 2. 您的工作負載是否需要分析？

如果您的應用程式需要對數據進行大量的查詢和分析，這將引導您使用不同的儲存方案。

- **需要數據分析**：如果需要進行即時或批量分析，**BigQuery** 是一個理想的選擇。它是一個伺服器無需管理的數據倉儲解決方案，提供了大規模並行查詢的能力。
- **不需要數據分析**：如果您的數據主要用於存儲，而非大量查詢或分析，您可以進一步考慮數據的持久性和一致性需求。

### 3. 您的數據是否需要一致性？

數據的一致性與分佈式系統中的複雜性息息相關。如果數據需要確保高一致性，則會有不同的儲存選項。

- **需要強一致性**：如果您需要強一致性並且您的應用程式數據高度關聯，**Cloud SQL** 或 **Cloud Spanner** 是不錯的選擇。**Cloud SQL** 支援關聯數據庫如 MySQL、PostgreSQL 和 SQL Server，適合傳統應用。**Cloud Spanner** 則是一個全球分佈式的關聯數據庫，適合處理水平擴展的需求。
- **不需要強一致性**：如果應用對於一致性的需求較低，或者資料是非結構化的，您可以考慮 NoSQL 方案，例如 **Firebase Realtime Database** 或 **Cloud Datastore**，這些解決方案更適合快速存取和非結構化資料。

### 4. 是否需要高可用性與橫向擴展？

如果您的應用程式預期將需要大規模的橫向擴展，那麼選擇具有高可用性與自動擴展功能的存儲解決方案是關鍵。

- **需要橫向擴展**：如果您的應用程式需要處理大量的讀寫請求並保持高可用性，**Cloud Spanner** 是最好的選擇之一。它支援全球分佈式存儲，並且具有極高的擴展能力和一致性保證。
- **不需要橫向擴展**：如果應用程式的需求相對穩定並且不需要大規模擴展，**Cloud SQL** 提供了一個簡單且熟悉的選擇，適合中小型應用。

---

# 總結

GCP 提供了各種儲存解決方案，從物件存儲的 **Cloud Storage** 到關聯數據庫的 **Cloud SQL**，再到專為高效能分析設計的 **BigQuery**。根據應用程式的需求，我們可以針對數據的互動性、持久性、一致性和可擴展性來選擇最適合的方案。

