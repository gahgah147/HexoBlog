---
title: GCP 學習 - Moniter 官方教學課程紀錄
date: 2024-06-17 11:06:16
tags:
    - Google
    - GCP 
    - GCP Moniter
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
# GCP 學習 - Moniter 官方教學課程紀錄

這邊是 Google Cloud Platform (GCP) 的 Moniter介面
![image](https://hackmd.io/_uploads/HkY6NvtSC.png)
>https://console.cloud.google.com/logs/query

GCP 這邊在使用上都會有一個這樣的了解詳情按紐
![image](https://hackmd.io/_uploads/ry_1rmar0.png)

點擊下去之後就會有詳細的教學文件，我覺得很實用，但是這邊有個問題就是界面都會一直隨著時間改動，可能我現在紀錄的內容過了一年之後就更新了需要重新學習，不過我覺得還是可以做一個參考使用。

# 教學項目
一開始右邊可以看到教學項目，有以下內容

## 說明文件: 使用記錄檔探索工具

您可以使用 Cloud Logging，有效率地擷取、檢視及分析查詢的記錄檔。

![image](https://hackmd.io/_uploads/SyfQsz6HA.png)
>https://cloud.google.com/logging/docs/view/logs-explorer-interface

## 教學課程: 快速入門導覽課程：Cloud Logging 導覽與簡介

課程時間: 20 分鐘
開始使用 Cloud Logging，追蹤應用程式中的問題。
![image](https://hackmd.io/_uploads/SyUa3f6H0.png)


## 教學課程:快速入門導覽課程：運用作業套件代理程式，從 Apache 網路伺服器收集記錄檔

使用作業套件代理程式，從 Apache 網路伺服器收集記錄檔，再透過記錄檔探索工具查看這些檔案。

![image](https://hackmd.io/_uploads/BJDCnGpBR.png)


## 說明文件: Logging 用途

瞭解用途、最佳做法和產業解決方案。
監控與記錄的架構指南

探索監控與記錄的最佳做法和參考架構。

![image](https://hackmd.io/_uploads/B1mOjG6r0.png)



## 說明文件: 透過記錄檔探索工具建構查詢

在記錄檔探索工具中建構查詢，以便擷取、修正及分析記錄檔。

![image](https://hackmd.io/_uploads/BkohsMaBR.png)
>https://cloud.google.com/logging/docs/view/building-queries

## 說明文件: Logging 查詢語言

瞭解用來查詢記錄檔資料及建立記錄檔接收器的 Logging 查詢語言。

![image](https://hackmd.io/_uploads/rJMghzTHC.png)
>https://cloud.google.com/logging/docs/view/logging-query-language

## 說明文件: 使用記錄檔探索工具的查詢範例

查看建議的查詢，讓您輕鬆使用記錄檔探索工具找出重要記錄檔。

![image](https://hackmd.io/_uploads/SJlr3z6BA.png)
>https://cloud.google.com/logging/docs/view/query-library


## 說明文件: 使用 gcloud CLI 寫入及查詢記錄項目

運用記錄工具試用一些 Cloud Logging 的基本功能。

![image](https://hackmd.io/_uploads/HJQ_3G6SC.png)
>https://cloud.google.com/logging/docs/write-query-log-entries-gcloud

以下是個別細項的介紹

## 使用記錄檔探索工具 - View logs by using the Logs Explorer
使用記錄檔探索工具

![image](https://hackmd.io/_uploads/S1DiUPYHC.png)
>https://cloud.google.com/logging/docs/view/logs-explorer-interface

可以使用 Cloud Logging，有效率地擷取、檢視及分析查詢的記錄檔。
這邊的文件寫得非常的詳細

## 快速入門導覽課程：Cloud Logging 導覽與簡介 

這邊是一個教學課程20 分鐘，是有關 Cloud Logging，追蹤應用程式中的問題。

![image](https://hackmd.io/_uploads/rJAlKDKr0.png)

![image](https://hackmd.io/_uploads/Bk0MtvYBR.png)

### 步驟1. 專案設定
![image](https://hackmd.io/_uploads/HJXBYDtSR.png)

### 步驟2. 探索 Cloud Logging 介面
![image](https://hackmd.io/_uploads/SJx_tvFSC.png)

如要輸入篩選條件來限制顯示的記錄檔，請使用「Query Builder」(查詢建立工具) 窗格。

![image](https://hackmd.io/_uploads/B1RIqDYBR.png)

如要查看查詢結果，請使用「Query Results」(查詢結果) 窗格。

![image](https://hackmd.io/_uploads/ByENZuKBC.png)


![image](https://hackmd.io/_uploads/BkdY5DtBC.png)

如要查看不同欄位對應的記錄項目數量，請使用「Log Fields」(記錄檔欄位) 窗格。

舉例來說，這個窗格會列出嚴重性為 Critical 的記錄檔數量。這個窗格中的資料可做為欄位參考清單，撰寫查詢時可派上用場。

![image](https://hackmd.io/_uploads/r1Yp5DtSR.png)

如要查看錯誤率，請使用「Histogram」(直方圖) 圖表。這張圖表不僅可協助您找出值得關注的事件發生的時間點，還可用來做為依時間和日期篩選記錄結果的介面。

![image](https://hackmd.io/_uploads/HyOgjDKSA.png)

如要取得查詢的連結，點選「Share Link」(共用連結) 按鈕，即可針對目前顯示的這組記錄檔複製安全的深層連結。

![image](https://hackmd.io/_uploads/BkLDjvYSC.png)

![image](https://hackmd.io/_uploads/BJ7KivKB0.png)

如要針對顯示或查詢的記錄檔設定時間範圍，請使用時間範圍選取器按鈕。

![image](https://hackmd.io/_uploads/B1hnjDFH0.png)

![image](https://hackmd.io/_uploads/SkupguFB0.png)

### 步驟3. 建立 GKE 叢集
![image](https://hackmd.io/_uploads/Skw7MdKBC.png)

在工具列中按一下  ![image](https://hackmd.io/_uploads/HyzvfuFrR.png)

![image](https://hackmd.io/_uploads/rJS_fuKH0.png)
>這邊會開始佈建 Cloud Shell 機器

在下列指令中，將 PROJECT_ID 替換成您的專案 ID，然後在 Cloud Shell 中執行指令：

```
gcloud container clusters create \
    "logcluster" --project PROJECT_ID \
    --zone us-central1-c --scopes \
    "gke-default" --num-nodes "3" \
    --enable-stackdriver-kubernetes
```
![image](https://hackmd.io/_uploads/Sk0dm_trA.png)

這邊系統題式要啟用 Kubernetese Engine API
![image](https://hackmd.io/_uploads/HJ514_Yr0.png)
>點選啟用

花了一點時間後就成功了
![image](https://hackmd.io/_uploads/Hyt6EdtHA.png)


執行上一個指令後，系統就會建立名為 logcluster 的叢集。這項作業會在幾分鐘內完成。建立叢集時，GKE 會佈建虛擬機器、載入機器映像檔，並設定要執行的 GKE 叢集。

如要安裝會產生記錄的應用程式，請按「Next」(下一步)。


### 步驟4. 安裝應用程式
![image](https://hackmd.io/_uploads/SyT9LOtrC.png)


執行下列指令，連線至 GKE 叢集：

```
gcloud container clusters \
    get-credentials logcluster \
    --zone us-central1-c --project \
    PROJECT_ID
```
    
![image](https://hackmd.io/_uploads/HymbwOYHC.png)

提取 Container Registry 中的應用程式，並部署至叢集：
```
kubectl run chatty \
    --image=gcr.io/cloud-logging-generator/cloud-logging-log-creator
```

![image](https://hackmd.io/_uploads/Hy-wPOtB0.png)

部署應用程式需要一些時間。部署完成後，應用程式就會產生記錄檔。

如要查看應用程式，請參考 GitHub 中的 [cloud-logging-log-creator](https://github.com/GoogleCloudPlatform/cloud-logging-log-creator?hl=zh-TW) 應用程式。

如要瞭解如何查看 GKE 記錄檔，請按「Next」(下一步)。

### 步驟5. 查看 GKE 記錄檔
![image](https://hackmd.io/_uploads/rkLi_OYS0.png)

在「Logs Explorer」(記錄檔探索工具) 頁面中，前往「Log Fields」(記錄檔欄位) 專區。

![image](https://hackmd.io/_uploads/B1JNKOYBA.png)

「Resource Type」(資源類型)

![image](https://hackmd.io/_uploads/SyA3KuKH0.png)
 專區中應該會列出幾個不同的實體，例如「Kubernetes Node」(Kubernetes 節點) 或「Kubernetes Pod」。

按一下「Kubernetes Cluster」(Kubernetes 叢集)。

選取「Kubernetes Cluster」(Kubernetes 叢集) 資源類型後，會發生以下情況：

![image](https://hackmd.io/_uploads/r1hRquKHA.png)


「Query results」(查詢結果) 窗格中顯示的所有記錄，資源類型都設為「Kubernetes Cluster」(Kubernetes 叢集)。
「Query builder」(查詢建立工具) 窗格中的查詢會變更為 resource.type="k8s_cluster"
新類別會出現在「Log fields」(記錄欄位) 窗格中。這些類別包括：
* 記錄檔名稱
* 專案 ID
* 位置

在「Query builder」(查詢建立工具) 工具列中，按一下「Clear Query」(清除查詢)。
![image](https://hackmd.io/_uploads/BkqfjOtSA.png)

### 步驟6. 尋找含有 chattylogs 的記錄檔

1.在「Query Builder」(查詢建立工具) 中輸入 chattylogs。

![image](https://hackmd.io/_uploads/rkh76OtS0.png)

在「Query Builder」(查詢建立工具) 中輸入單一字詞時，該查詢會搜尋各個記錄檔的所有欄位，確認是否有相符項目。這類查詢的效率較低。

在先前的範例中，查詢只會搜尋每個記錄項目的 resource.type 這個欄位。

2.按一下 [執行查詢]。

結果會列出您安裝的應用程式產生的所有記錄檔。

3.請花幾分鐘的時間探索資料。舉例來說，只要前往「Query」(查詢) 窗格中的某個記錄檔，然後按下「Expand」(展開)按鈕，即可探索該記錄檔的各個欄位。
![image](https://hackmd.io/_uploads/ByMLadYSC.png)

4.在「Query builder」(查詢建立工具) 工具列中，按一下「Clear Query」(清除查詢)。
![image](https://hackmd.io/_uploads/HJYup_YS0.png)

### 步驟7. 依嚴重性和記錄檔名稱篩選

1.依嚴重性等級篩選：

按一下「Severity」(嚴重性)。
![image](https://hackmd.io/_uploads/HyxiTOYBR.png)

選取「Critical」(重要)。
![image](https://hackmd.io/_uploads/S1X2adYSR.png)

「Query results」(查詢結果) 窗格會顯示嚴重性等級為 Critical 的記錄。

2.依記錄檔名稱篩選：

* 找到任一項目，然後按一下展開符號。
* 找出 logName 項目，在記錄檔名稱上按一下，然後點選「Show matching items」(顯示相符的項目)。

![image](https://hackmd.io/_uploads/HyXbkYYHC.png)

查詢傳回的結果如下：

```
severity=CRITICAL
logName="projects/PROJECT_ID/logs/chattylogs"
```

系統只會顯示符合 severity 和 logName 篩選條件的記錄檔。

3.探索錯誤直方圖：

* 從查詢建立工具中移除 severity=Critical 這一行，然後按一下「Run Query」(執行查詢)。

![image](https://hackmd.io/_uploads/B1aAlFKSR.png)


* 前往「Histogram」(直方圖) 窗格，找出直方圖顯示紅色長條的時間範圍，然後透過滑桿將時間範圍限縮到該直方圖項目附近。
![image](https://hackmd.io/_uploads/rycyGYKSC.png)

* 移動滑桿後，按一下「Run Query」(執行查詢)。
![image](https://hackmd.io/_uploads/BkQDMKYHC.png)


直方圖會顯示，嚴重性為 Critical 的各個記錄項目前面，會有狀態為 Informational 或 Warning 的其他記錄檔。這些時間較早的記錄檔提供的資訊為，在系統寫入嚴重性為 Critical 的記錄項目前，應用程式處於何種狀態。

### 步驟8. 串流記錄
根據預設，系統會停用記錄檔串流功能，記錄檔探索工具不會直接顯示這些內容。

如要即時查看記錄檔，請按一下「Stream logs」(串流記錄)。

![image](https://hackmd.io/_uploads/BJ_pMFYBC.png)

查看完畢之後，請按一下「Stop streaming」(停止串流)。
![image](https://hackmd.io/_uploads/H16RGtFHA.png)

如要進一步瞭解 Logging，請按「Next」(下一步)。

### 步驟9. 進一步瞭解 Cloud Logging

「Log-based metrics」(記錄指標) 頁面可讓您從記錄項目的內容中取得指標資料。舉例來說，您可以建立指標來計算專案中的 Compute Engine VM 發生了多少 Warning 事件。詳情請參閱「[記錄指標總覽](https://cloud.google.com/logging/docs/logs-based-metrics)」的說明。

「Logs Router」(記錄檔路由器) 頁面可讓您將記錄檔導向不同的目的地，包括 Cloud Logging 記錄檔值區、Cloud Storage 值區、Pub/Sub 主題和 BigQuery 資料集。您可以使用這項功能設定要將哪些記錄檔轉送至特定目的地。詳情請參閱「[轉送和儲存空間總覽](https://cloud.google.com/logging/docs/routing/overview)」的說明。

本快速入門導覽課程需使用資源，如要瞭解如何避免系統向您的 Google Cloud 帳戶收取相關費用，請按「Next」(下一步)。

### 步驟10. 後續步驟 避免產生帳單費用
保留已建立的資源並運用 Logging 執行更多工作，或是清除所用資源來避免產生帳單費用。

運用 Logging 執行更多工作
* 進一步瞭解 Logging 查詢語言：
    * 常見查詢。
    * 建構查詢。
* 瞭解如何查詢及查看記錄檔。
清除所用資源
此逐步操作說明需使用資源，如要避免系統向您的 Google Cloud 帳戶收取相關費用，請按照下列步驟操作。

執行下列指令：
```
gcloud container clusters delete \
    logcluster --zone \
    us-central1-c --project PROJECT_ID \
    -q
```


## 快速入門導覽課程：運用作業套件代理程式，從 Apache 網路伺服器收集記錄檔

使用作業套件代理程式，從 Apache 網路伺服器收集記錄檔，再透過記錄檔探索工具查看這些檔案。

### 步驟1. 運用作業套件代理程式收集來自 Apache 的記錄檔
![image](https://hackmd.io/_uploads/Bk9O9ttBC.png)
瞭解如何使用作業套件代理程式，收集及查看 `syslog` 記錄檔。這些記錄檔是由安裝在 Compute Engine 虛擬機器 (VM) 執行個體上的 Apache 網路伺服器所收集。您可以使用類似本快速入門導覽課程中的程序，[監控其他第三方應用程式](https://cloud.google.com/logging/docs/agent/ops-agent/third-party)。


在本快速入門導覽課程中，執行以下操作：
1. 建立 Compute Engine VM 執行個體，並安裝[作業套件代理程式](https://cloud.google.com/logging/docs/agent/ops-agent)。
1. 安裝 Apache 網路伺服器。
1. 針對 Apache 網路伺服器設定作業套件代理程式。
1. 在記錄檔探索工具中查看記錄檔。
1. 建立記錄式快訊。
1. 測試快訊。
1. 清除所用資源。

預計時間：
15 分鐘


### 步驟2.  建立 VM 執行個體

![image](https://hackmd.io/_uploads/SyCtcFtSR.png)

1.前往 Google Cloud 控制台的「VM instances」(VM 執行個體) 頁面：

前往「VM instances」(VM 執行個體) 頁面
![image](https://hackmd.io/_uploads/HJneotKHR.png)

如果您是使用搜尋列尋找這個頁面，請選取子標題為「Compute Engine」的結果。

2.點選「Create instance」(建立執行個體) 建立 VM。
![image](https://hackmd.io/_uploads/r13bsYYr0.png)

如要查看位置，請點選下列按鈕：顯示
![image](https://hackmd.io/_uploads/HJgVitFBC.png)

3.在`「Name」(名稱)` 欄位中，輸入描述性名稱。

![image](https://hackmd.io/_uploads/HkwujFtB0.png)

4.在`「Machine type」(機器類型)` 欄位中，選取「e2-small」。
![image](https://hackmd.io/_uploads/B11ssYtS0.png)

![image](https://hackmd.io/_uploads/SkRToFtHR.png)

5.在`「Boot disk」(開機磁碟)` 區段中，保留預設設定「Debian GNU/Linux」。
![image](https://hackmd.io/_uploads/HJtAoKtSA.png)

6.在`「Firewall」(防火牆)` 區段中，選取「Allow HTTP traffic」(允許 HTTP 流量) 和「Allow HTTPS traffic」(允許 HTTPS 流量)。
![image](https://hackmd.io/_uploads/rynehFKHA.png)

![image](https://hackmd.io/_uploads/Byst2tKr0.png)

7.在「Observability - Ops Agent」(觀測能力 - 作業套件代理程式)區段中，選取「Install Ops Agent for Monitoring and Logging」(安裝作業套件代理程式來處理監控和記錄工作)。

![image](https://hackmd.io/_uploads/B18shKFBR.png)

8.按一下「Create」(建立)。
![image](https://hackmd.io/_uploads/Hks32FtBR.png)

![image](https://hackmd.io/_uploads/H1VEpKtHA.png)

### 步驟3.  安裝 Apache 網路伺服器

1.在「VM instances」(VM 執行個體) 頁面上找到新的 VM，前往「Connect」(連線) 欄，然後點選「SSH」。

![image](https://hackmd.io/_uploads/HkdgCttHR.png)

![image](https://hackmd.io/_uploads/SkOWCKKr0.png)

點選授權
![image](https://hackmd.io/_uploads/ByCmAttS0.png)

2.如要更新套件清單，請將下列指令複製到剪貼簿，貼到 SSH 終端機，然後按下 Enter 鍵：

```
sudo apt-get update
```

![image](https://hackmd.io/_uploads/HyBIAFYHA.png)

3.看到「Reading package lists... Done」(正在讀取套件清單... 完成) 訊息後，請在 SSH 終端機中執行下列指令，安裝 Apache2 網路伺服器：

```
sudo apt-get install apache2 php7.0
```

![image](https://hackmd.io/_uploads/r1nuAFYrC.png)

系統詢問是否繼續安裝時，請輸入 Y。如果安裝指令失敗，請使用 sudo apt-get install apache2 php。

4.命令提示字元傳回後，請前往「VM instances」(VM 執行個體) 頁面，然後將 VM 的外部 IP 位址複製到下列網址：

```
http://EXTERNAL_IP
```

![image](https://hackmd.io/_uploads/B1w5O-6HC.png)
>這邊說的 外部IP 就是這個

5.如要連線至 Apache 網路伺服器，請開啟新的瀏覽器分頁，然後輸入上一步中的網址。

網路伺服器安裝成功後，瀏覽器分頁就會顯示 Apache2 Debian 預設頁面。

![image](https://hackmd.io/_uploads/H1NTdZpS0.png)
>http://34.69.206.231/

如要瞭解如何透過作業套件代理程式收集 Apache 記錄檔和指標，請點選「Next」(下一步)。

### 步驟4.  收集 Apache 網路伺服器記錄檔和指標
![image](https://hackmd.io/_uploads/B14OYZaS0.png)

1. 前往 VM 執行個體的 SSH 終端機。如果尚未開啟終端機，請執行下列步驟：

a. 前往 Google Cloud 控制台的「VM instances」(VM 執行個體) 頁面：

前往「VM instances」(VM 執行個體) 頁面
![image](https://hackmd.io/_uploads/Byneqbar0.png)

如果您是使用搜尋列尋找這個頁面，請選取子標題為「Compute Engine」的結果。

b. 找到新的 VM，然後點選「SSH」。

2. 複製下列指令，貼到執行個體的終端機，然後按下 Enter 鍵：
```
# Configures Ops Agent to collect telemetry from the app and restart Ops Agent.

set -e

# Create a back up of the existing file so existing configurations are not lost.
sudo cp /etc/google-cloud-ops-agent/config.yaml /etc/google-cloud-ops-agent/config.yaml.bak

# Configure the Ops Agent.
sudo tee /etc/google-cloud-ops-agent/config.yaml > /dev/null << EOF
metrics:
  receivers:
    apache:
      type: apache
  service:
    pipelines:
      apache:
        receivers:
          - apache
logging:
  receivers:
    apache_access:
      type: apache_access
    apache_error:
      type: apache_error
  service:
    pipelines:
      apache:
        receivers:
          - apache_access
          - apache_error
EOF

sudo service google-cloud-ops-agent restart
sleep 60
```

![image](https://hackmd.io/_uploads/SysGi-aS0.png)


先前的指令會建立設定，收集和擷取 Apache 網路伺服器中的記錄檔和指標。詳情請參閱「[針對 Apache 網路伺服器設定作業套件代理程式](https://cloud.google.com/monitoring/agent/ops-agent/third-party/apache?hl=zh-TW)」一節。

3. 等候命令提示字元顯示，這至少需要 60 秒。

如要瞭解如何查看 Apache 網路伺服器的 syslog 記錄檔，請點選「Next」(下一步)。

### 步驟5. 查看 Apache 網路伺服器記錄檔

![image](https://hackmd.io/_uploads/rk12AbTBA.png)

1. 前往 Google Cloud 控制台的「Logs Explorer」(記錄檔探索工具) 頁面：

前往「Logs Explorer」(記錄檔探索工具)

![image](https://hackmd.io/_uploads/Syh_sZpSC.png)


如果您是使用搜尋列尋找這個頁面，請選取子標題為「Logging」的結果。

「Query results」(查詢結果) 窗格會顯示最近的記錄檔。

2. 確認工具列中的「Show query」(顯示查詢) 已啟用。

![image](https://hackmd.io/_uploads/SJkCs-6SC.png)

3. 如要查看 Apache 網路伺服器記錄檔，請建立並執行查詢：

a. 從「Google Cloud project」(Google Cloud 專案) 選取器展開 Google Cloud 專案清單，然後將 Google Cloud 專案 ID 複製到剪貼簿。

在下列運算式中，將複製的 ID 貼到 PROJECT_ID 欄位中，然後將運算式複製到查詢編輯器中：

```
resource.type="gce_instance"
logName=("projects/PROJECT_ID/logs/apache_access" OR "projects/PROJECT_ID/logs/apache_error")
```

![image](https://hackmd.io/_uploads/BkHNT-6B0.png)

執行先前的查詢時，只會顯示 apache_access 和 apache_error 記錄項目。

c.點選「Run query」(執行查詢)。
![image](https://hackmd.io/_uploads/BJNS0WpSR.png)
「Query results」(查詢結果) 窗格會顯示查詢結果。

![image](https://hackmd.io/_uploads/r1YORWTHC.png)

如要在記錄檔中出現特定模式時收到通知，請建立快訊政策。

如要瞭解如何建立快訊政策要使用的通知管道，請點選「Next」(下一步)。

### 步驟6. 建立電子郵件通知管道
![image](https://hackmd.io/_uploads/Hyt0RbaBA.png)

1. 前往 Google Cloud 控制台的「Alerting」(快訊) 頁面notifications：

前往「Alerting」(快訊)

![image](https://hackmd.io/_uploads/BJFMyMaB0.png)


如果您是使用搜尋列尋找這個頁面，請選取子標題為「Monitoring」的結果。

2. 點選工具列中的「Edit Notification Channels」(編輯通知管道)。


3. 在「Notification channels」(通知管道) 頁面中，捲動至「Email」(電子郵件)，然後點選「Add new」(新增)。


![image](https://hackmd.io/_uploads/BJ_L1zar0.png)

4. 輸入您的電子郵件地址和顯示名稱 (例如 My email)，然後點選「Save」(儲存)。

![image](https://hackmd.io/_uploads/rJsOeM6rC.png)


如要瞭解如何在記錄檔中出現特定模式時收到通知，請點選「Next」(下一步)。

### 步驟7. 建立記錄式快訊
![image](https://hackmd.io/_uploads/BJscxzaBA.png)

1. 前往 Google Cloud 控制台的「Logs Explorer」(記錄檔探索工具) 頁面：

前往「Logs Explorer」(記錄檔探索工具)

如果您是使用搜尋列尋找這個頁面，請選取子標題為「Logging」的結果。

![image](https://hackmd.io/_uploads/Syn1ZMTrA.png)

2. 在「Query results」(查詢結果) 工具列中，點選「Create alert」(建立快訊) add_alert。記錄檔快訊政策窗格會隨即開啟。

![image](https://hackmd.io/_uploads/ByJ4-GpBR.png)


3. 在「Alert details」(快訊詳細資料) 的「Alert Policy Name」(快訊政策名稱) 欄位中，輸入 404 Not Found。

![image](https://hackmd.io/_uploads/rJTL-zTHC.png)

4. 在「Choose logs to include in this alert」(選擇要包含在這則快訊中的記錄檔)中，執行下列操作：

a. 移除記錄檔篩選器文字方塊中的任何內容。
b. 複製下列查詢並貼到記錄檔篩選器文字方塊中：
```
severity>=DEFAULT /help httpRequest.status=404
```
先前的記錄檔篩選器會搜尋 severity 等級至少為 DEFAULT 的記錄項目，包含 /help 文字且 httpRequest 狀態為 404。

![image](https://hackmd.io/_uploads/BJ20ffTSR.png)

5. 在「Set notification frequency and autoclose duration」(設定通知頻率和自動關閉期限) 區段中，執行下列操作：

a. 將「Time between notifications」(通知傳送間隔時間) 欄位設為「5 min」(5 分鐘)。

b. 將「Incident autoclose duration」(事件自動關閉期限) 欄位設為「30 min」(30 分鐘)。

![image](https://hackmd.io/_uploads/BJecQMaH0.png)

6. 在「Who should be notified?」(應該通知誰？) 中，從「Notification Channels」(通知管道) 選單中選取您的電子郵件，然後點選「Save」(儲存)。

![image](https://hackmd.io/_uploads/HkfAmG6HA.png)

![image](https://hackmd.io/_uploads/HkEk4fTHR.png)

![image](https://hackmd.io/_uploads/rJHxNMprC.png)

如要瞭解如何測試快訊政策，請按「Next」(下一步)。

### 步驟8. 測試快訊政策

![image](https://hackmd.io/_uploads/BJh_EMarR.png)

1. 前往 VM 執行個體的 SSH 終端機。如果尚未開啟終端機，請執行下列步驟：

a. 前往 Google Cloud 控制台的「VM instances」(VM 執行個體) 頁面：

![image](https://hackmd.io/_uploads/Sk5REfaB0.png)


如果您是使用搜尋列尋找這個頁面，請選取子標題為「Compute Engine」的結果。

b. 找到新的 VM，然後點選「SSH」。

2. 如要在伺服器上搜尋虛構頁面 `localhost/help`，請執行下列指令：

```
curl localhost/help
```

終端機顯示「404 Not Found」訊息後，系統會傳送電子郵件通知。這項程序會在幾分鐘內完成。

![image](https://hackmd.io/_uploads/r12QLz6H0.png)

3. 如要查看新的記錄項目，請執行下列操作：
a. 前往 Google Cloud 控制台的「Logs Explorer」(記錄檔探索工具) 頁面：

前往「Logs Explorer」(記錄檔探索工具)

如果您是使用搜尋列尋找這個頁面，請選取子標題為「Logging」的結果。

![image](https://hackmd.io/_uploads/BJBxPfpHR.png)

b. 點選工具列中的「Jump to now」(跳到現在時間)。
![image](https://hackmd.io/_uploads/BkSSDGTB0.png)

如要查看後續步驟並避免系統向帳戶收費，請點選「Next」(下一步)。

### 步驟9. 避免系統向帳戶收費
![image](https://hackmd.io/_uploads/SylMnPGaHC.png)

保留已建立的資源並運用 Monitoring 執行更多工作，或是清除所用資源來避免產生帳單費用。

運用 Monitoring 執行更多工作

#### 教學課程: 透過作業套件代理程式收集 Apache 指標
瞭解如何透過作業套件代理程式，收集 Apache 網路伺服器指標。

![image](https://hackmd.io/_uploads/Byhx_zTr0.png)


#### 說明文件: 使用記錄檔探索工具查看記錄檔

進一步瞭解 Cloud Monitoring。
![image](https://hackmd.io/_uploads/ByJv_G6BC.png)

>https://cloud.google.com/logging/docs/view/logs-explorer-interface

#### 說明文件: 透過記錄檔探索工具建構查詢

進一步瞭解 Cloud Monitoring。

![image](https://hackmd.io/_uploads/HJOoOM6HA.png)
>https://cloud.google.com/logging/docs/view/building-queries

#### 清除所用資源
此逐步操作說明需使用資源，如要避免系統向您的 Google Cloud 帳戶收取相關費用，請按照下列步驟操作。

1. 如果您已建立 VM，請刪除該 VM：

a. 前往 Google Cloud 控制台的「VM instances」(VM 執行個體) 頁面：

前往「VM instances」(VM 執行個體) 頁面

![image](https://hackmd.io/_uploads/HkXqtzTrR.png)

如果您是使用搜尋列尋找這個頁面，請選取子標題為「Compute Engine」的結果。

b. 針對您建立的 VM，點選 
「Actions」(動作)，然後選取「Delete」(刪除)。
![image](https://hackmd.io/_uploads/BklTYMprC.png)

![image](https://hackmd.io/_uploads/HyKpYMTrC.png)

2. 刪除您建立的快訊政策：

a. 前往 Google Cloud 控制台的「Alerting」(快訊) 頁面notifications：

前往「Alerting」(快訊)

如果您是使用搜尋列尋找這個頁面，請選取子標題為「Monitoring」的結果。

b. 選取您建立的快訊政策，然後點選「Delete」(刪除)。
![image](https://hackmd.io/_uploads/SyIm9zTB0.png)

# 結尾
以上就是設定Google Cloud Platform (GCP) 的 Moniter介面官方教學課程操作的步驟紀錄，官方的教學介紹課程內容蠻多的，希望能幫助到你，如果有任何問題或需要進一步的幫助，歡迎在留言區提出。