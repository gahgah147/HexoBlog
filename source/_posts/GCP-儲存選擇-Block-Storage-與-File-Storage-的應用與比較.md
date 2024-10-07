---
title: GCP - 儲存選擇 Block Storage 與 File Storage 的應用與比較
date: 2024-10-07 17:19:15
tags:
    - GCP
    - Block Storage
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/rkooImZJkx.jpg
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---
![未命名設計](https://hackmd.io/_uploads/rkooImZJkx.jpg)
在 Google Cloud Platform (GCP) 上，雲端儲存解決方案分為多種類型，以滿足不同的工作負載需求。其中，**Block Storage** 和 **File Storage** 是兩種非常常見的儲存類型，分別適用於不同的應用場景。本文將簡單介紹它們的特點、適用場景，以及在 GCP 中的具體服務。

以下是Google Cloud Storage Options 官方指南
![image](https://hackmd.io/_uploads/SkP1RWbJ1l.png)
>https://cloud.google.com/products/storage/?hl=zh-TW

## 什麼是 Block Storage？

以下是Google cloud 區塊儲存空間官方說明文件
![image](https://hackmd.io/_uploads/SJLgxzZkkx.png)
>https://cloud.google.com/products/block-storage?hl=zh-TW

**Block Storage（區塊存儲）** 是將數據分割成固定大小的區塊，並將每個區塊單獨儲存和管理的一種存儲方式。這種存儲方法類似於傳統的硬碟驅動器，因為每個區塊都可以被單獨存取，並且不需要依賴整個文件結構來讀取數據。這使得 Block Storage 特別適合對於高性能和低延遲有較高需求的應用程序，如數據庫和虛擬機。

### GCP 上的 Block Storage 服務：Persistent Disk

以下是 Google Cloud Persistent Disk 官方文件
![image](https://hackmd.io/_uploads/rJZrp--Jke.png)
>https://cloud.google.com/persistent-disk?hl=zh-TW

在 GCP 中，**Persistent Disk** (PD) 是最主要的 Block Storage 服務。Persistent Disk 提供持久性、高可靠性及可擴展的區塊存儲，且能與虛擬機（VM）無縫整合。

- **特點**：
  - **持久性**：數據存儲在多個物理位置，確保在硬體故障時仍可恢復數據。
  - **高效能**：PD 提供高 IOPS（每秒輸入輸出操作次數）與低延遲，適合高性能的工作負載。
  - **彈性擴展**：PD 可以隨時動態調整大小，無需中斷服務。
  
- **適用場景**：
  - 數據庫應用程式，如 MySQL、PostgreSQL。
  - 高性能虛擬機的存儲需求。
  - 需要頻繁讀寫操作的工作負載。

### Persistent Disk 的類型
在 GCP 上，Persistent Disk 提供了多種選擇，以滿足不同需求：
- **Standard Persistent Disk**：適合標準工作負載的成本效益型選擇。
- **SSD Persistent Disk**：提供更高的讀寫速度，適合需要快速存取的應用。
- **Balanced Persistent Disk**：在性能和成本之間提供平衡，適合大多數應用程式。

## 什麼是 File Storage？
以下是 Google Cloud Filestore 官方文件
![image](https://hackmd.io/_uploads/HkJqab-ykg.png)
>https://cloud.google.com/filestore?hl=zh-TW

**File Storage（文件存儲）** 是基於文件和文件夾的存儲系統，允許用戶通過標準的檔案存取協議（如 NFS）來存取數據。這種存儲方式類似於傳統的文件伺服器，適合需要共享文件的應用程序，例如內容管理系統和媒體處理工作負載。

### GCP 上的 File Storage 服務：**Filestore**
在 GCP 中，**Filestore** 是主要的 File Storage 服務。它是一個完全託管的 NFS 文件系統，專為與虛擬機或容器環境中的應用程式整合而設計。

**特點**：
  - **簡單易用**：提供類似於傳統文件伺服器的操作體驗，支持標準 NFS 協議。
  - **高性能**：適合高吞吐量工作負載，例如視頻處理、軟體開發工作流。
  - **彈性配置**：Filestore 提供多種性能層級，從標準到高性能檔案存儲，以滿足不同的需求。

**適用場景**：
  - 共享文件系統，例如企業內部文件存取與共享。
  - 多個 VM 之間的協同工作，特別是需要頻繁存取大文件的應用。
  - 容器化環境中的數據共享，例如 GKE 中的工作負載。

### Filestore 的類型
Filestore 提供了多種配置選項：
- **Filestore Basic**：適合一般用途的文件存取需求。
- **Filestore High Scale**：提供更高的性能和容量，適合需要高吞吐量的應用程式。

## Block Storage 和 File Storage 的選擇

在選擇 Block Storage 和 File Storage 時，應根據具體需求來決定：
- **Block Storage（Persistent Disk）** 更適合需要低延遲、高性能的應用，如數據庫和需要大量隨機存取的工作負載。
- **File Storage（Filestore）** 則更適合需要文件共享或多個應用程式協同工作的情境，例如軟件開發、內容管理系統或多媒體處理。

## 結論

GCP 提供了多樣化的存儲解決方案，包括 Block Storage（Persistent Disk）和 File Storage（Filestore）。這兩種存儲類型各有優勢，能夠滿足不同的應用需求。選擇合適的存儲方案，不僅可以提升應用程式的性能，還能降低成本並提高系統的靈活性。
