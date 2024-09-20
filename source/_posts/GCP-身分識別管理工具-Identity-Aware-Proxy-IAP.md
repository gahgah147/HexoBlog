---
title: GCP - 身分識別管理工具 Identity-Aware Proxy (IAP)
date: 2024-09-12 09:59:00
tags:
    - GCP
    - 雲端服務
    - IAP
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/B1N4W6k6A.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

隨著雲端應用的普及，安全性成為各企業不可忽視的重要議題。Google Cloud Platform（GCP）提供了眾多安全性工具，而其中一個強大的功能就是 **Identity-Aware Proxy（IAP）**。IAP 透過基於身份的存取控制來保護應用程式，確保只有授權用戶可以存取特定的應用或服務。

以下是GCP  Identity-Aware Proxy（IAP）的官方介紹文件 
![image](https://hackmd.io/_uploads/B1N4W6k6A.png)
>https://cloud.google.com/security/products/iap?hl=en

# 什麼是 Identity-Aware Proxy？

Identity-Aware Proxy 是 GCP 提供的一項服務，允許您基於使用者身份來控制應用或虛擬機器的存取權限。IAP 讓傳統的防火牆概念更進一步，將網路安全保護由 IP 位址轉移到使用者身份層級，這有助於確保您的資源能夠被正確的使用者存取，而不需要暴露在網路中。

# 核心功能

## 基於身份的存取控制
   IAP 使用 Google Account 驗證使用者身份，並基於特定角色或權限來允許或拒絕使用者的存取請求，確保敏感資料不會被未經授權的個人看到。

## 無需暴露公眾 IP
   傳統的網路安全措施常常依賴防火牆規則，允許特定 IP 位址存取應用程式。但透過 IAP，您可以將應用程式或服務完全保護在內部網路中，僅允許具備正確身份驗證的使用者進行訪問。

## 與其他 GCP 服務整合
   IAP 能與 GCP 的其他安全性服務整合，如 **Cloud Identity** 和 **Google OAuth 2.0**，為 GCP 應用和 VM 提供全面的安全保護。

## 支持多種應用架構 
   不論您使用的是 GCP 上的 Compute Engine、Kubernetes Engine 還是 App Engine，都可以透過 IAP 進行身份驗證和存取控制，保護不同類型的應用和服務。

### App Engine
![image](https://hackmd.io/_uploads/HJJUMa1TC.png)
>https://cloud.google.com/iap/docs/concepts-overview

### Cloud Run
![image](https://hackmd.io/_uploads/H1iY7ay6R.png)
>https://cloud.google.com/iap/docs/concepts-overview

### Compute Engine
![image](https://hackmd.io/_uploads/HyHo7pkTR.png)
>https://cloud.google.com/iap/docs/concepts-overview

### GKE
![image](https://hackmd.io/_uploads/HyzAQTJpC.png)
>https://cloud.google.com/iap/docs/concepts-overview

### On-premises
![image](https://hackmd.io/_uploads/B1LeNpyaA.png)
>https://cloud.google.com/iap/docs/concepts-overview

# 運作流程

1. **使用者驗證**
   當使用者試圖存取受 IAP 保護的應用或資源時，IAP 會首先確認使用者是否已經登入 Google 帳戶，並進行身份驗證。

2. **權限檢查**
   IAP 會根據 IAM（Identity and Access Management）中的角色與權限設定來決定使用者是否可以存取特定應用或服務。

3. **應用授權**
   一旦身份和權限驗證通過，IAP 會允許該使用者存取應用程式，並將流量轉送到後端服務。



## 主要優勢

1. **強化安全性**：避免將應用程式暴露在公網中，僅允許經身份驗證的用戶存取。
2. **簡化存取管理**：整合 Google 帳戶系統，不需要手動管理 IP 白名單。
3. **彈性部署**：支持多種雲端應用程式架構，適用於不同規模的企業。

## 如何配置 GCP Identity-Aware Proxy？

1. **啟用 IAP**
   在 GCP Console 中，導航至 **IAP 設定頁面**，選擇需要保護的資源並啟用 IAP 功能。

2. **設置 IAM 角色與權限**
   為使用者賦予適當的 IAM 角色，例如 IAP-secured Web App User 或 Viewer，來決定哪些使用者可以存取受保護的應用。

3. **測試與驗證**
   配置完成後，測試使用者存取，確認身份驗證與存取控制是否如預期運作。

## 結論

GCP 的 Identity-Aware Proxy 是一個強大的工具，讓企業能夠基於身份來控制應用和資源的存取，進一步強化雲端安全性。透過簡單的配置，您可以確保敏感應用僅能被授權的使用者存取，降低外部攻擊的風險。
