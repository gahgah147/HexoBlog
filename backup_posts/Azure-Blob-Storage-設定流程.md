---
title: Azure Blob Storage 設定流程
date: 2024-01-23 14:38:19
tags:
    - Azure
    - Azure Blob Storage
    - 雲端服務
---


這一篇是參考以下教學文章
[[教學] Azure Blob Storage 使用指南 – 創建篇](https://xenby.com/b/238-%E6%95%99%E5%AD%B8-azure-blob-storage-%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97-%E5%89%B5%E5%BB%BA%E7%AF%87)
實作練習的紀錄


# Azure Blob Storage 設定流程

Microsoft Azure 的 Blob Storage 提供了透過 restful api 來對檔案進行取得檔案以及對其新增、修改刪除的功能，對於在許多機房能夠同時存取非常方便，本篇將教學如何透過 azure portal 創建 Microsoft Azure 的 Blob Storage。

![image](https://hackmd.io/_uploads/SkJpZ2jFp.png)

Blob 主要架構分為三層

![image](https://hackmd.io/_uploads/rJtXbCnFa.png)

| 架構 | 說明 |
| -------- | -------- | 
| 儲存體帳戶 (storage account)     | 表示一個倉庫帳號，一個使用者可以創間多個儲存體帳戶   |
| 容器 (container)     | 類似於硬碟的概念，在一個 storage account 可以有多個 container，用來區分不同用途的檔案    |
| Blob (檔案或資料)  | 類似於檔案系統的檔案，並且可以有資料夾多層式的階層來做更進一步的分類    |


# 創建 storage account

首先進入 azure portal 

![image](https://hackmd.io/_uploads/B1DgMChKa.png)
>https://portal.azure.com/

進入頁面中會有Azure 服務清單，點 [建立資源]

![image](https://hackmd.io/_uploads/HJJdz02Fa.png)
>接著在列表中點 [儲存體] 並選擇 [儲存體帳戶 – Blob、檔案、資料表、佇列]

創建需要填寫儲存體的設定

![image](https://hackmd.io/_uploads/B1Uq4AhK6.png)

* 訂用帳戶：如果是公司的帳號，可能會有多個訂用帳戶用於不同場景，依照需求選擇
* 資源群組：設定該資源設置屬於群組，可以依照不同專案或者是不同用途來區分，之後用來檢視哪些專案使用多少資源會比較方便
* 儲存體帳戶名稱：這會影響預設的資源存取 domain，以及簽署存取簽章時需要，不過也能夠自行更改 domain 可參考：針對 Azure 儲存體帳戶設定自訂網域名稱
* 位置：伺服器機房所在位置
* 效能：空間硬碟的IO速度等級
* 帳戶總類：參考 Azure 儲存體帳戶概觀，一般直接選擇 StorageV2
* 複寫：設定資料在複製多份時會以哪種策略分布
* 存取層：可參考 Azure Blob 儲存體：經常性、非經常性和封存存取層，主要影響讀取的速度，不同總類的價格也不同

進階設定

![image](https://hackmd.io/_uploads/B12CBC2ta.png)

* 需要安全傳輸：進行資料傳輸過程是否加密，例如使用 restful API 存取時是否只允許使用 https
* 大型檔案共用：是否有大檔案的需求，如果勾選後可以存放檔案大小上限達 100TB 的檔案
* Blob 虛刪除：設定檔案刪除是否只是標記為刪除，並且支援將標記的檔案復原功能
* 階層式命名空間：參考 Azure Data Lake 儲存體，對於極大量資料可以有好的效能

網路設定

![image](https://hackmd.io/_uploads/S1qNLR2FT.png)
用於設定哪些網路可以存取此 storage，依據自己的用途選擇

資料保護設定

![image](https://hackmd.io/_uploads/SJciI02K6.png)

加密設定
![image](https://hackmd.io/_uploads/Sk2oPRnY6.png)

標籤設定
![image](https://hackmd.io/_uploads/SyYyOA2F6.png)

最後會驗證必填的資料是否都有填寫，並且確認設定沒有錯誤按下[建立]
![image](https://hackmd.io/_uploads/Skac_Cnta.png)

等待它完成部署
![image](https://hackmd.io/_uploads/HkV1FAnYT.png)

完成部署後，可以點 [前往資源] 進行資源的檢視
![image](https://hackmd.io/_uploads/SkhZYChFp.png)

而如果要讓服務能夠使用需要先建立容器 (container)

在左邊的列表中找到 [Blob服務]，並且點擊 [容器]
![image](https://hackmd.io/_uploads/SkJ_tCnK6.png)

並且點擊左上的新增容器按鈕

![image](https://hackmd.io/_uploads/SJMRF0ntT.png)

輸入自己想要的容器名稱，按下 [確定] 建立容器

![image](https://hackmd.io/_uploads/SyP8qC3Ka.png)
成功後進入容器就可以開始使用，可以選擇手動上傳檔案或是透過程式 API 來進行檔案新增修改刪除

![image](https://hackmd.io/_uploads/r1mqoR3Kp.png)
