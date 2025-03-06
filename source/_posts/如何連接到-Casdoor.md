---
title: 如何連接到 Casdoor
date: 2025-03-06 17:20:52
tags:
    - SSO
    - Casdoor
    - IdP
    - SP
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

# 如何連接到 Casdoor

我們在完成架設 Casdoor server 之後會，接下來要介紹如何連上 Casdoor server，以下是官方的說明文件

![image](https://hackmd.io/_uploads/S1C1k1DoJx.png)
>https://casdoor.org/docs/how-to-connect/overview/

---

## **概述 (Overview)**  
本篇文章將介紹如何將你的應用程式與 **Casdoor** 進行整合，以實現單一登入 (SSO) 和身份驗證功能。  

而 Casdoor 可以同時支援 SP 與 IdP 服務

### **Casdoor 作為 SP 支援的身份驗證協議：**  
- **OAuth 2.0 (OIDC)**  
- **SAML**  

### **Casdoor 作為 IdP 支援的身份驗證協議：**  
- **OAuth 2.0**  
- **OIDC**  
- **SAML**  
- **CAS 1.0、2.0、3.0**  

### 什麼是 SP 與 IdP ?
在身份驗證架構中，有兩個重要的角色：  
- **身份提供者 (IdP, Identity Provider)**：負責管理使用者的身份與憑證，例如 Google、Facebook 或 Casdoor。  
- **服務提供者 (SP, Service Provider)**：需要使用者身份資訊的應用程式，例如例如其他第三方網站（例如 Medium、Trello、Notion），或是你的網站或後台管理系統。  

當使用者登入時，**SP 會向 IdP 請求身份驗證**，並獲取授權後，允許使用者訪問應用程式。  

### SP（服務提供者）與 IdP（身份提供者）簡單範例  

假設你要使用 **Google 帳號登入 Notion**，整個身份驗證流程中：  
- **Google 是身份提供者 (IdP)**：它負責存儲與管理使用者帳號，並提供驗證服務。  
- **Notion 是服務提供者 (SP)**：它需要確認使用者的身份，並請求 Google 來驗證登入。  

### 流程簡述  
1. 使用者在 Notion 點擊「用 Google 帳號登入」。  
2. Notion（SP）將使用者導向 Google（IdP）進行身份驗證。  
3. Google 確認身份後，返回授權資訊給 Notion。  
4. Notion 根據 Google 的驗證結果，允許使用者登入。  

這種機制使得使用者可以**在多個不同的網站上，使用同一組帳號（例如 Google）進行安全登入**，而不需要為每個網站建立新帳號。  

---

## OAuth 2.0 (OIDC) 身份驗證  
### 什麼是 OAuth 2.0？  
OAuth 2.0 是一個授權框架，允許應用程式（如 Facebook、GitHub、Casdoor）透過 HTTP 服務存取使用者帳戶，並委託身份驗證給提供帳戶的服務，從而允許第三方應用程式獲取用戶授權。  

Casdoor 的授權機制基於 **OAuth 2.0**，推薦使用這個協議的原因包括：  
✅ **簡單易實作，可適用多種場景**  
✅ **技術成熟，擁有廣泛的社群支持**  

**因此，應用程式將透過 OAuth 2.0 (OIDC) 與 Casdoor 進行身份驗證。**  

### 如何連接到 Casdoor？  
有三種方式可以將你的應用程式與 Casdoor 整合：  

#### 1️⃣ 使用標準 OIDC 客戶端  
- 使用現有的 **OIDC 客戶端**，適用於大部分程式語言與框架  
- 如果你的應用程式已支援 OIDC，這種方式最簡單  

---

## OpenID Connect (OIDC) 是什麼？  
**OIDC** 是建立在 **OAuth 2.0** 之上的開放身份驗證協議，允許使用者透過 **OpenID 提供者 (OP)** 進行身份驗證，然後訪問不同的應用程式。  

Casdoor **完全支援 OIDC 協議**，如果你的應用程式已經使用 **其他 OIDC 身份提供者**，透過 **OIDC Discovery** 可以輕鬆切換到 Casdoor。  

---

## Casdoor SDKs
如果你想要更多功能（如**用戶管理**、**資源上傳**），可以使用 **[Casdoor SDK](https://casdoor.org/docs/how-to-connect/sdk/)**。  

相比標準 **OIDC**，使用 **Casdoor SDK** 可以提供更強大的 API，如：  
✅ **使用者管理**  
✅ **資源上傳**  
✅ **更靈活的身份驗證功能**  

但使用 SDK 需要更多開發時間，適合希望有 **更高擴展性** 的開發者。  

![image](https://hackmd.io/_uploads/rJGzIyvjJe.png)
>https://casdoor.org/docs/how-to-connect/sdk/

---

## Casdoor 插件 (Plugins) 
如果你的應用程式已經建立在 **Spring Boot、WordPress** 等平台上，Casdoor（或第三方）可能已經提供了 **插件 (Plugin) 或中介軟體 (Middleware)**，可以直接使用，無需額外開發！  

### 目前支援的插件與中介軟體  
✅ **插件 (Plugins)：**  
- **Jenkins Plugin**  
- **APISIX Plugin**  

✅ **中介軟體 (Middleware)：**  
- **Spring Boot Plugin**  
- **Django Plugin**  

使用插件的方式比直接調用 SDK **更簡單**，適合不希望修改應用程式核心架構的開發者。  

![image](https://hackmd.io/_uploads/r1FHUyDi1l.png)
>https://casdoor.org/docs/how-to-connect/plugin/
---

## SAML 身份驗證  
### 什麼是 SAML？ 
SAML (**Security Assertion Markup Language**) 是一種開放標準，允許 **身份提供者 (IdP)** 向 **服務提供者 (SP)** 傳遞授權憑證，使用戶可以用單一憑證登入多個網站。  

SAML 主要適用於 **企業內部系統**，如：  
✅ **Google Workspace**  
✅ **Microsoft Active Directory (AD)**  

Casdoor 可作為 **SAML IdP**，目前支援 **SAML 2.0** 的主要功能。  

但需要注意的是：  
⚠️ **SAML 技術較為複雜，不建議用於新開發的應用程式**  

**範例：** Casdoor 可作為 **Keycloak** 的 SAML IdP。  

![image](https://hackmd.io/_uploads/B1J1DyDo1g.png)
>https://casdoor.org/docs/how-to-connect/saml/overview/

---

## CAS 身份驗證
### 什麼是 CAS？
CAS (**Central Authentication Service**) 是一種 **輕量級 SSO 協議**，用於網頁應用程式，讓使用者 **一次登入即可訪問多個應用**。  

Casdoor 已實作 **CAS 1.0、2.0、3.0**，但該協議的安全性較低，適用於 **內部系統** 或 **學術機構**。  

**使用 CAS 時的注意事項：**  
⚠️ **協議較為簡單，只適用於特定場景**  
⚠️ **CAS Client 與 CAS Server 之間沒有額外的加密與簽名機制**  

由於 **CAS 協議相比 OIDC 和 SAML 沒有明顯優勢**，建議僅在特殊需求時使用。  

![image](https://hackmd.io/_uploads/ByYUvkvi1l.png)
>https://casdoor.org/docs/how-to-connect/cas

---

## **🎯 結論：選擇最適合你的 Casdoor 整合方式！**  

| **整合方式** | **適用場景** | **優勢** |  
|-------------|-------------|---------|  
| **OIDC 標準客戶端** | **已有 OIDC 登入機制的應用** | ✅ **最簡單，適合快速對接** |  
| **Casdoor SDK** | **需要用戶管理、資源上傳** | ✅ **更靈活，功能更強大** |  
| **Casdoor 插件** | **使用 Spring Boot、Jenkins、Django** | ✅ **無需修改應用程式，最省事** |  
| **SAML** | **企業內部系統，如 Google Workspace** | ⚠️ **技術較複雜，適合大企業** |  
| **CAS** | **學術機構、內部系統** | ⚠️ **輕量但安全性較低** |  

👉 **最佳選擇：**  
💡 如果你想要**快速整合 SSO**，推薦使用 **OIDC (OpenID Connect)**！  
