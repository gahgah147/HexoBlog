---
title: 'Velero: Kubernetes 中的帆船備份與災難復原工具'
date: 2024-08-23 10:30:09
tags:
    - Velero 
    - Kubernetes
    - 備份
    - 災難還原
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/rJS0m_SoC.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

![image](https://hackmd.io/_uploads/rJS0m_SoC.png)

隨著 Kubernetes (K8s) 在全球企業中的接受度不斷上升，越來越多的企業選擇使用 K8s 來部署服務。K8s 的靈活性和可擴展性使得它成為現代企業基礎設施的重要組成部分。然而，隨著應用程式的日益複雜，備份與災難復原成為了運營過程中不可忽視的課題。這篇文章將介紹 Velero，一款強大的開源工具，專為 Kubernetes 集群的備份、還原、災難復原以及資料遷移設計。

## 為什麼需要備份？

在生產環境中，難免會遇到一些不可控的因素或意外操作，甚至是程式錯誤，這些都可能導致服務停擺。如果集群龐大或部署的服務繁多，快速找出問題來源並不容易。在某些情況下，集群設定可能已被改動，而我們也記不得原本的配置。此時，如果有備份，便能夠迅速將集群恢復至正常狀態。

## 需要備份的內容

K8s 使用 Controller pattern 來管理集群狀態，透過與 API Server 的協作，確保集群達到預期狀態。因此，我們需要備份的是儲存對象狀態的資料。

最少需要備份以下兩個部分：
1. **etcd**：etcd 是 K8s 中非常重要的元件，用於儲存集群的網路配置以及對象的狀態訊息。還原 etcd 等同於還原 K8s 集群狀態。
2. **Persistent Volume (PV)**：雖然 etcd 還原了 K8s 集群狀態，但 PV 的內容不屬於 K8s 集群狀態的一部分，如資料庫中的資料。因此，除了 etcd 外，還需要備份 PV 的內容。

## Velero 的功能介紹

Velero 是一款開源工具，專為安全地備份與還原 Kubernetes 集群資源和持久性卷（Persistent Volumes）而設計。它的三大主要功能包括：
1. **災難復原**：當 K8s 集群發生問題時，能夠快速恢復。
2. **資料遷移**：在不同的 K8s 集群之間遷移應用程式。
3. **資料保護**：對 Persistent Volume 進行備份，確保資料的完整性。

## Velero 的架構

Velero 通過實作 Custom Resource Definition (CRD)，並由 Velero Controller 執行備份與還原操作。備份過程大致如下：
1. 使用者透過 velero CLI 建立 Backup object。
2. BackupController 監聽並驗證此事件。
3. BackupController 查詢 API Server，並備份目標資源。
4. 最後，BackupController 將備份的資源上傳至指定的 Object Storage Service。

## 備份過程中的注意事項

Velero 支援兩種主要的 PV 備份方式：
1. **Volume Snapshot**：利用 storage provider 的 snapshot 功能對資料進行快照。適合需要確保資料一致性的場景，如公有雲提供的 block storage（如 EBS、Google Compute Engine Disks、Azure Managed Disks）。
2. **Restic**：一個支援多系統的備份還原工具，適用於沒有 snapshot 支援的場景。Restic 可以透過 Velero 備份 PV 的資料，但對於有資料一致性要求的應用，建議在備份前凍結資料。

## 還原操作

在還原過程中，Velero 支援一些特殊操作，如：
- 復原到指定的 namespace。
- 保存 service 的 NodePort。
- 改變 PV/PVC 的 StorageClass。

此外，Velero 也支援多種 hooks 來控制還原行為。

## 使用範例

假設我們部署了一個 nginx server 並使用 PV 儲存 log 檔案。透過 Velero，我們可以輕鬆地將整個 K8s 集群進行備份，然後在需要時進行還原。具體操作步驟如下：
1. 安裝 CSI Driver，並配置 hostpath storage class。
2. 部署 nginx server 並掛載 PV。
3. 使用 Velero 進行備份。
4. 刪除 nginx 部署，模擬災難場景。
5. 使用 Velero 還原 nginx server，並檢查資料恢復情況。

## 心得

Velero 操作簡單，且輕量化的設計使其能夠支援多種平台。雖然本文演示了如何進行備份與還原，但 Velero 也支援跨集群遷移，只需在新 K8s 集群上安裝 Velero，便可輕鬆進行還原操作。然而，使用 Velero 前需仔細閱讀官方文件，了解其功能與限制，以確保能滿足自身需求。

