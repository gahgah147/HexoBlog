---
title: GCP - Google Cloud Storage (GCS) Google 雲端儲存服務介紹
date: 2024-08-19 10:33:08
tags:
    - GCP
    - GCS
    - 雲端
    - Google
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/Hyk8cFhcC.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---
![image](https://hackmd.io/_uploads/Hyk8cFhcC.png)

在現今的雲端計算時代，儲存和管理大量數據變得比以往任何時候都更加重要。Google Cloud Storage (GCS) 作為 Google Cloud Platform (GCP) 的核心服務之一，提供了一個可靠且可擴展的物件儲存解決方案，適用於各種應用場景。

簡單來說 Google Cloud Storage 就是在 Google 雲端平台上用來儲存東西的工具。


## 什麼是 Google Cloud Storage?

有使用 Google cloud plateform(GCP) 的話可以在介面中查詢到cloud storage像是以下這邊的圖案
![image](https://hackmd.io/_uploads/H1tLYq3cC.png)

且在右方可以看到一系列的官方教學說明，其實建議詳細操作之後就會對這個功能比較熟悉
![image](https://hackmd.io/_uploads/HJnpYq29R.png)


另外以下是Google Cloud Storage 的官方介紹文章
![image](https://hackmd.io/_uploads/SJodtt35C.png)
>https://cloud.google.com/storage?hl=zh-TW

Google Cloud Storage 是一個物件儲存服務，它允許使用者在雲端中存儲任意大小的數據，包括結構化和非結構化數據。GCS 提供了高可用性和耐久性，並支持全球範圍內的數據存取，這使得它成為企業和開發者的理想選擇。

以下是官方的教學介紹影片
https://youtu.be/wNOs3LlsH6k

## Google Cloud Storage 的主要功能有哪些?

### 1. **一流的數據分析和機器學習/AI 工具**：當資料存入 Cloud Storage 後，即可輕鬆運用 Google Cloud 的強大工具，包括使用 BigQuery 建立資料倉儲，使用 Dataproc 執行開放原始碼數據分析，或使用 Vertex AI 建構及部署機器學習 (ML) 模型。。
  
![image](https://hackmd.io/_uploads/HJLESc3cA.png)
>https://cloud.google.com/storage?hl=zh-TW#object-storage-for-companies-of-all-sizes

### 2. **自動轉換儲存空間級別**：透過物件生命週期管理 (OLM)、自動調整級別等功能，您可以輕鬆利用不同儲存空間級別來存放物件，獲得最佳成本效益。您可以在值區層級設定政策，按照上次存取時間自動將物件移至存取頻率較低的儲存空間級別。在存取頻率較低的儲存空間級別中，提前刪除資料或擷取資料都不會產生費用，也沒有級別轉換費用。

![image](https://hackmd.io/_uploads/rkp5H9n9C.png)


### 3. **有服務水準協議保證的洲際規模複製機制**：領先業界的雙區域值區支援大量區域。單一的洲際規模值區提供橫跨三大洲的九個區域，復原時間目標 (RTO) 為零。即便服務發生中斷，應用程式也能順暢存取備用區域中的資料，沒有容錯移轉和容錯回復過程。如果機構的可用性需求極高，搭配使用強化型複製功能與雙區域值區可以提供 15 分鐘的復原點目標 (RPO) 服務水準協議。

### 4. **使用 Cloud Storage 做為本機檔案系統**：使用者經常選用 Cloud Storage 儲存訓練資料、模型和查核點，以供 Cloud Storage 值區中的機器學習專案中的機器學習專案使用。Cloud Storage FUSE 不僅能讓您充分發揮 Cloud Storage 可擴充、價格實惠、高處理量和簡單易用的特性，同時更支援使用或需要檔案系統語意的應用程式。 Cloud Storage FUSE 現在也提供快取功能，與原生機器學習架構資料載入器相比，訓練時間縮短為 2.2 倍，訓練處理量也提升達到 2.9 倍。

![image](https://hackmd.io/_uploads/BkY0SqhqR.png)

### 5. **利用檔案目錄報告管理物件儲存空間**:目錄報告包含與物件相關的中繼資料資訊，例如物件的儲存空間級別、ETag 和內容類型。這些資訊可協助您分析儲存成本、稽核及驗證物件，並確保資料安全無虞且符合法規。您可以將目錄報告匯出為半形逗號分隔值 (CSV) 檔案或 Apache Parquet 檔案，進一步使用 BigQuery 等工具進行分析。進一步瞭解儲存空間分析目錄報告。

![image](https://hackmd.io/_uploads/ryXz89n5R.png)
>以上內容都是來自Google cloud storage官方說明文件，還有更多功能可以展開查看https://cloud.google.com/storage?hl=zh-TW#object-storage-for-companies-of-all-sizes

## GCS 的應用場景

### 1. **數據備份和災難恢復**：GCS 是數據備份的理想選擇，並能夠與全球各地的資料中心協同工作來進行災難恢復。

![image](https://hackmd.io/_uploads/BkD0Uq35C.png)
>以上圖片是來自Google cloud storage官方說明文件https://cloud.google.com/storage?hl=zh-TW#object-storage-for-companies-of-all-sizes

運作原理:Cloud Storage 的 [Nearline Storage](https://cloud.google.com/storage/docs/storage-classes#nearline) 提供快速、低成本且高度耐用的儲存服務，可用來存放每月存取不到一次的資料，能降低備份和封存成本，並保留即時存取資料的能力。所有儲存空間級別的延遲時間皆為毫秒等級，且透過同一個 API 來存取，所以除了復原作業之外，Cloud Storage 中的備份資料也可以用於其他用途

[關於Nearline Storage 的詳細介紹可以參考這個官方文件](https://cloud.google.com/storage/docs/storage-classes#nearline)

### 2. **內容存放與傳遞**：GCS 可以作為靜態網站或應用程式資源的存儲位置，並能與 CDN（內容分發網絡）配合，提升內容傳遞速度。

![image](https://hackmd.io/_uploads/BkX0Pqn5A.png)
>以上圖片是來自Google cloud storage官方說明文件https://cloud.google.com/storage?hl=zh-TW#object-storage-for-companies-of-all-sizes

運作原理:利用 Cloud Storage 的異地備援功能，將音訊或視訊直接串流至應用程式或網站。異地備援儲存空間具備最高級別的可用性與效能，因此非常適合以低延遲而高 QPS 的方式，將內容提供給位於不同地理區域的使用者。


3. **大數據分析**：GCS 與 BigQuery 等工具整合，方便儲存並分析大量結構化和非結構化數據。

![image](https://hackmd.io/_uploads/rywxu539R.png)
>以上圖片是來自Google cloud storage官方說明文件https://cloud.google.com/storage?hl=zh-TW#object-storage-for-companies-of-all-sizes

運作原理:建立用於數據分析的資料湖泊
開發及部署資料管道和儲存空間，以便分析大量資料。Cloud Storage 具備高可用性、效能和同步一致性，可讓您安心地準確處理數據分析工作負載。

[關於使用cloud storage建立的資料湖泊(BigLake tables)可以參考這篇官方介紹文件](https://cloud.google.com/bigquery/docs/create-cloud-storage-table-biglake#cloud-storage-as-data-lake)

4. **機器學習與 AI**:GCS 可以啟動 Google 推薦的預先設定解決方案，透過生成式 AI 快速擷取文字，並為儲存在 Cloud Storage 中的大量文件產生摘要。

![image](https://hackmd.io/_uploads/Sk8kiqnqC.png)
>以上圖片是來自Google cloud storage官方說明文件https://cloud.google.com/storage?hl=zh-TW#object-storage-for-companies-of-all-sizes

5. **託管網站**：可以使用 Google Cloud 控制台中建構、託管及經營動態網站。

![image](https://hackmd.io/_uploads/rkWcs525R.png)
>以上圖片是來自Google cloud storage官方說明文件https://cloud.google.com/storage?hl=zh-TW#object-storage-for-companies-of-all-sizes

運作原理:使用 Python 和 JavaScript，推出可公開存取及自訂的直接出貨零售產品範例網站。

## 如何使用 Google Cloud Storage

### 1. **建立 Bucket**：在 GCS 中，所有數據都儲存在 Bucket 中。首先，創建一個 Bucket，並選擇適合的存儲類別與區域。

![image](https://hackmd.io/_uploads/r17mp535C.png)
>可以先點擊畫面中的Create

![image](https://hackmd.io/_uploads/HyaXG7giC.png)
>這邊設定bucket的名字，例如 test-bucket-2024-08-19 

![image](https://hackmd.io/_uploads/S1YcfXxsR.png)
>設定地點

![image](https://hackmd.io/_uploads/SJqnM7lsA.png)
>選擇儲存類型

![image](https://hackmd.io/_uploads/BkVeX7eiC.png)
>選擇如何控制對物件的存取權限

![image](https://hackmd.io/_uploads/B15JEQgoR.png)
>這部份是在解釋如何保護 Google Cloud Storage (GCS) 中的物件數據，以及可用的額外數據保護選項。

**選擇如何保護物件數據**  
您的數據在 Cloud Storage 中始終受到保護，但您還可以選擇以下額外的數據保護選項，以增加安全層級。

**數據保護選項**

**自定義軟刪除策略（用於數據恢復）**  
   啟用後，將覆蓋預設的保留期。刪除的物件將在指定的時間內被保留，在此期間可以恢復。如果設置為 0 天，則刪除的物件無法恢復。了解更多

**物件版本控制（用於版本管理）**  
   用於恢復被刪除或覆蓋的物件。為了最小化存儲版本的成本，建議限制每個物件的非當前版本數量，並設定它們在若干天後過期。了解更多

**保留（用於合規性）**  
   用於在指定的時間內防止刪除或修改存儲桶中的物件。

接下來按下 Create 之後會顯示以下畫面
![image](https://hackmd.io/_uploads/SJ3VVQgoR.png)

這邊可以選擇是否要公開開放存取這個Bucket

![image](https://hackmd.io/_uploads/rkSkLXeoC.png)
>這邊可以看到我們剛剛創建的Bucket

### 2. 上傳與管理數據：使用 GCP 提供的工具或 API，將文件上傳至 Bucket，並設定存取控制與生命周期管理。


![image](https://hackmd.io/_uploads/rkSkLXeoC.png)
>這邊可以點選我們剛剛創建的Bucket進入查看細節

![image](https://hackmd.io/_uploads/B1iPIQgoA.png)
>這邊可以看到Bucket的細節

![image](https://hackmd.io/_uploads/BJ9mP7loR.png)
>這邊可以看到上傳檔案的按紐

![image](https://hackmd.io/_uploads/S1kYP7xoC.png)
>可以測試上傳檔案

### 3. 訪問與整合：透過網址或整合至其他 GCP 服務中訪問存儲在 GCS 的數據，並根據需求設定許可權。

具體來說，可以查看以下兩份文件來實作：

**[公開訪問和連結的官方指南](https://cloud.google.com/storage/docs/access-public-data)** - 這份文件描述如何設定物件的公開連結以及使用不同的 URL 格式來存取 GCS 中的數據。
   
![image](https://hackmd.io/_uploads/H1Mkt7gjA.png)
> 使用URL的方式

![image](https://hackmd.io/_uploads/SkXMt7xsA.png)
>還有使用程式語言的方式存取，可以依照你的需求來選擇

**[使用客戶端程式庫來存取](https://cloud.google.com/storage/docs/reference/libraries)** - 此文件涵蓋了如何將 GCS 與 BigQuery、Compute Engine 以及其他 GCP 服務整合。

![image](https://hackmd.io/_uploads/ByaOK7esA.png)
>這邊可以看到各種程式語言的客戶端程式庫(client library)，這邊可以依照你的環境需求做使用。

## 結論

今天跟大家介紹的Google Cloud Storage的簡單概念跟使用情境，Google Cloud Storage 是一個靈活且強大的物件存儲解決方案，適合各種規模的企業和開發者使用。無論是備份數據、內容傳遞、還是大數據分析，GCS 都能提供高效且經濟的存儲選擇。隨著企業對數據管理需求的不斷增長，GCS 為其提供了穩定且可靠的雲端儲存支持。

如果您有興趣了解更多細節，歡迎在下方留言跟我討論。
