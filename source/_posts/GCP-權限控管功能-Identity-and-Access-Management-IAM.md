---
title: GCP - 權限控管功能 Identity and Access Management (IAM)
date: 2024-09-19 15:55:54
tags:
    - GCP
    - 雲端服務
    - IAM
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/HJ98YIYaR.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

在 Google Cloud Platform（GCP）中，**Identity and Access Management (IAM)** 是一個核心的安全性功能，它用來控制誰可以訪問什麼資源。IAM 提供精細的權限控制，允許組織為每個資源設置適當的存取權限，並確保數據安全。

![image](https://hackmd.io/_uploads/rkH-_IF6A.png)
＞https://cloud.google.com/security/products/iam?hl=zh-tw


# 什麼是 IAM？

![image](https://hackmd.io/_uploads/SycNdIYpR.png)
＞https://cloud.google.com/security/products/iam?hl=zh-tw

GCP IAM 是一種基於角色的訪問控制系統，通過定義特定的角色和權限，讓使用者、群組或應用程式擁有恰當的資源存取權限。它透過以下三個基本元素來實現訪問控制：
- **身份 (Identity)**：可以是使用者、群組、服務帳號等。
- **角色 (Role)**：權限的集合，用來授予身份訪問特定 GCP 資源的權限。
- **資源 (Resource)**：GCP 上的任何可管理物件，如 Compute Engine VM、Cloud Storage bucket、BigQuery 資料集等。

#  IAM 的主要特點
![image](https://hackmd.io/_uploads/HkM8OIFpR.png)

- **精細化控制**：IAM 允許您為每個資源設置非常細緻的存取控制。可以為單一用戶或群組分配不同層級的權限，從而避免過度的存取權限。

- **基於角色的存取控制 (RBAC)**：IAM 使用角色來管理權限，每個角色包含不同的操作權限。例如，"查看者"角色只能查看資源，而"編輯者"角色則能修改資源。
![image](https://hackmd.io/_uploads/rJODdUFpA.png)

- **預定義角色 (Predefined Roles)**：GCP 提供了多種預定義的角色，這些角色是針對特定的 GCP 服務設計的。例如，`storage.admin` 角色允許管理 Cloud Storage 資源，而 `compute.viewer` 角色允許查看 Compute Engine 資源。
![image](https://hackmd.io/_uploads/By9F_IFT0.png)

- **自定義角色 (Custom Roles)**：除了預定義的角色，您還可以創建自定義角色來滿足特定需求。自定義角色允許您選擇並組合不同的權限來完全控制訪問。

# IAM 的核心概念
![image](https://hackmd.io/_uploads/HJjquItp0.png)

- **身份 (Identities)**：可以是 GCP 中的使用者帳號、群組、服務帳號或 Google 帳號。這些身份是授予角色的主體。

- **角色 (Roles)**：角色是權限的集合，每個角色都可以包含多個權限。GCP 提供了三種類型的角色：
  - **基本角色 (Basic Roles)**：如 `Viewer`、`Editor`、`Owner`。這些是傳統角色，適用於所有 GCP 服務。
  - **預定義角色 (Predefined Roles)**：針對特定 GCP 服務的角色，提供精細化的權限控制。
  - **自定義角色 (Custom Roles)**：您可以根據需求創建自定義角色，包含您選擇的權限。

- **權限 (Permissions)**：權限定義了身份能夠執行哪些操作。例如，`storage.buckets.create` 是一個允許創建 Cloud Storage bucket 的權限。

# 如何管理 IAM 角色與權限？

最簡單的說法就是:誰可以做什麼，在哪些資源上?

![image](https://hackmd.io/_uploads/HJ98YIYaR.png)

管理 IAM 主要是通過為身份授予適當的角色。可以通過 GCP 控制台、命令列工具 (`gcloud`)、或 API 來設置角色。

以下是基本的操作流程：
1. **選擇要管理的資源**：選擇您想要管理存取權限的資源，如特定的 Compute Engine、Cloud Storage bucket 或 BigQuery 資料集。
  
2. **為身份分配角色**：選擇身份（如使用者、群組或服務帳號），並為其分配適當的角色。

3. **檢查和修改權限**：根據需求，檢查現有權限是否符合安全性要求，並調整角色或權限。

# 最佳實踐
![image](https://hackmd.io/_uploads/SkkK_LKTA.png)
  
- **最小權限原則**：只授予身份最低限度的權限，以減少風險。例如，對於需要查看數據的使用者，僅分配 `Viewer` 角色，而非 `Editor` 角色。

- **定期審查權限**：定期檢查和更新 IAM 角色和權限，確保使用者或服務帳號的權限符合當前業務需求。

- **使用自定義角色**：當預定義角色無法滿足需求時，考慮創建自定義角色來精細化控制權限。

# 結論

![image](https://hackmd.io/_uploads/Hyz5dIYp0.png)
IAM 是一個強大的存取控制工具，通過角色和權限的組合，讓組織能夠靈活管理資源的訪問權限。正確地設置和管理 IAM 角色是保障 GCP 資源安全的關鍵。通過遵循最小權限原則和定期審查權限，您可以確保系統的安全性和合規性。
