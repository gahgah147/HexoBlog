---
title: Auth.js 功能介紹與安裝流程
date: 2024-12-12 09:32:21
tags:
    - Next.js 
    - Auth.js
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/H1F7KnPVke.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---


日常工作上有遇到一個需求: 開發登入驗證功能，這邊在討論的時候發現到需求是要可以SSO登入多個平台，加上目前公司主要前端使用的是Next.js ，所以我在網路上找到了 Auth.js 這個工具。

![image](https://hackmd.io/_uploads/H1F7KnPVke.png)
>https://authjs.dev/

接下來我們點擊 Getting Started 開始進入Auth.js 的Introduction 介紹頁面

# 什麼是 Auth.js？

Auth.js 是一個與執行環境無關的函式庫(runtime agnostic library)，基於標準的 Web API 開發，與多種現代 JavaScript 框架深度整合。

提供的身份驗證體驗具有以下特點：

1. 簡單開始：對於初學者來說，設置和使用非常直觀。
2. 易於擴展：可根據需求自定義和擴充功能。
3. 隱私與安全：高度注重用戶數據的隱私和安全性。

![image](https://hackmd.io/_uploads/HkS4Y2D4Jl.png)
>https://authjs.dev/getting-started

目前可以看到 Auth.js 支援多個前端框架像是Next.js、Qwik、SvelteKit、Express，我目前主要是以Next.js 的功能為主，目標是開發一個SSO的認證功能。

## Auth.js 支援的身份驗證方式

Auth.js 支援四種身份驗證方法，滿足不同的應用場景：

1. OAuth：方便用戶快速登錄。
2. Magic Links：用戶僅需使用電子郵件即可登錄，無需記憶密碼。
3. Credentials：適合傳統系統和定制化驗證邏輯。
4. WebAuthn：提供最現代化的無密碼驗證，增強安全性與便利性。

![image](https://hackmd.io/_uploads/BJFBYnPE1g.png)
>https://authjs.dev/getting-started

## Auth.js 支援的資料庫

* Auth.js 支援與資料庫整合，但這是可選的功能。
* 通過 Database adapters，您可以輕鬆對接資料庫來存儲用戶數據。
* 這對於需要完整用戶管理或數據存儲功能的應用尤為重要。

![image](https://hackmd.io/_uploads/SkOUt2wEyx.png)
>https://authjs.dev/getting-started 

這邊可以看到支援的資料庫有這些

如果您需要用戶數據的長期存儲，建議選擇一個支援的資料庫並利用適配器進行整合。例如，使用 MongoDB 或 PostgreSQL 存儲用戶賬號和登入歷史資訊。

像是我這次想要用的是 MongoDB

# 如何升版? Migrate to NextAuth.js v5
接下來我們會看到Upgrade Guide (NextAuth.js v5)
![image](https://hackmd.io/_uploads/rJA_K3D41e.png)
>https://authjs.dev/getting-started/migrating-to-v5

從這邊的說明可以看到Auth.js 之前叫做NextAuth.js，NextAuth.js 版本 5 是 next-auth 套件的一次重大重寫

![image](https://hackmd.io/_uploads/ByRFK3vVkx.png)
>https://next-auth.js.org/

這邊的NextAuth.js也是我第一次在網路上搜尋 Next.js 的登入驗證套件找到的文件。

在最上方可以看到 NextAuth.js is becoming Auth.js! 🎉

所以如果你專案之前是第一次使用Auth.js那可以跳過這一段的說明。

## 新功能（New Features）
   - App Router-first
     支援 App Router 架構，但仍然兼容傳統的 `pages/` 目錄。
   - OAuth 支援預覽部署 
     在預覽環境中也可以支援 OAuth 身份驗證（[詳細說明](https://authjs.dev/getting-started/deployment#securing-a-preview-deployment)）。
   - 簡化設定
     使用共享配置與推斷環境變數[env variables](https://authjs.dev/guides/environment-variables#environment-variable-inference)，減少手動配置工作。
   - 新功能 `account()` 回調
     在提供者上新增 `account()` 回調功能，可用於自定義帳號邏輯（[`account()` docs](https://authjs.dev/reference/core/providers#account)）。
     
   - Edge-compatible
     提供與 Edge 環境相容的身份驗證支持。
   - 統一的 `auth()` 方法
     - 一個統一的方法來處理身份驗證，不再需要單獨使用 `getServerSession`、`getSession`、`withAuth`、`getToken` 或 `useSession`。
     - 簡化開發者的身份驗證流程（[詳細說明](https://authjs.dev/getting-started/migrating-to-v5#authenticating-server-side)）。

---

## 重大變更（Breaking Changes）
 - **使用更嚴格的 OAuth/OIDC 規範**
   - Auth.js 現在基於 `@auth/core`，並且符合更嚴格的 OAuth/OIDC 規範。
   - 一些現有的 OAuth 提供者可能會因此出現不兼容的問題，可參考 [[GitHub 問題追蹤]](https://github.com/nextauthjs/next-auth/issues?q=is%3Aopen+is%3Aissue+label%3Aproviders)。
   
 - **OAuth 1.0 停止支持**
   - 不再支持 OAuth 1.0，建議開發者轉向 OAuth 2.0 或更新的身份驗證協議。

 - **最低 Next.js 版本要求**
   - 現在 Auth.js 需要 **Next.js 14.0 或更高版本**，請檢查並升級應用程序。

 - **匯入路徑的變更**
   - `next-auth/next` 和 `next-auth/middleware` 的匯入方式已更改：
     - 舊版的匯入方式已被替換，詳細請參考 [Authenticating server-side](https://authjs.dev/getting-started/migrating-to-v5#authenticating-server-side) 文檔。

 - **`idToken: false` 行為調整**
   - 當 `idToken: false` 時，不再完全停用 ID token。
   - 現在會額外訪問 `userinfo_endpoint` 來獲取用戶的最終數據。
   - 舊版則完全跳過 ID token 的檢查。

## Migration 版本遷移步驟

如果說是使用舊版本的`NextAuth.js`的話，這邊詳細的版本遷移步驟可以參考官方文件說明一步一步操作。
![image](https://hackmd.io/_uploads/rJJstnwNke.png)
>https://authjs.dev/getting-started/migrating-to-v5

## Cookie 命名變更

過去版本中，與 Cookie 相關的內容是以 next-auth 為前綴命名的。
在新版 Auth.js 中，這些 Cookie 的前綴名稱已經改為 authjs。

# Installation - 安裝 Auth.js 操作步驟


要在 Next.js 專案中安裝 Auth.js，可以按照以下步驟進行設定：  

---

## **步驟 1：建立或進入 Next.js 專案**
1. 如果尚未建立專案，請運行以下指令來創建一個新的 Next.js 專案，假設專案名稱是`next-auth-app`：
   ```bash
   npx create-next-app@latest next-auth-app
   cd next-auth-app
   ```
2. 如果已經有一個 Next.js 專案，直接進入該專案目錄：
   ```bash
   cd next-auth-app
   ```

![image](https://hackmd.io/_uploads/Hk4nt2PV1e.png)
> 實際運行畫面

成功安裝後會顯示Success! Created next-auth-app at `你設定的路徑`

![image](https://hackmd.io/_uploads/rJXaY3D4yl.png)

---

## **步驟 2：安裝 Auth.js**
運行以下指令安裝 Auth.js 的 beta 版本：
```bash
npm install next-auth@beta
```
這個版本的 Auth.js 適用於最新功能和更新。

## **步驟 3：生成 `AUTH_SECRET`**

在這一步中，您需要設置一個 `AUTH_SECRET` 環境變數，它用於加密 token 和電子郵件驗證的哈希。這是 Auth.js 中必須配置的環境變數。

您可以使用官方的 Auth.js CLI 工具來生成這個隨機的 `AUTH_SECRET` 字串。

1. 在終端機中運行以下指令來生成 `AUTH_SECRET`：
   ```bash
   npx auth secret
   ```

2. 這會自動生成一個隨機的密鑰並將它添加到您的 `.env.local` 檔案中（對於 Next.js 專案）。

![image](https://hackmd.io/_uploads/BJX0K2PN1x.png)
>實際執行畫面

![image](https://hackmd.io/_uploads/By3RK2vNkg.png)
>可以看到多出一個 .env.local 檔案


---

## **步驟 4：設置 Configure**
這一段說明了如何配置 Auth.js 並設置身份驗證邏輯，以下是逐步解釋：

### **1. 創建 `auth.ts` 配置文件**

首先，您需要在專案的根目錄中創建一個 `auth.ts` 檔案，內容如下:

```ts
import NextAuth from "next-auth"
 
export const { handlers, signIn, signOut, auth } = NextAuth({
  providers: [],
})
```
這個檔案用來配置 Auth.js，並在其中使用 `NextAuth` 來配置設定。您可以在這個文件中設置身份驗證提供者、調整認證邏輯等。

- `providers` 是將用來認證用戶的身份驗證提供者（如 Google、GitHub 等）列表，目前是空的，需要在後續步驟中填寫。

### **2. 新增 Route Handler**

在 `app/api/auth/[...nextauth]/route.ts` 中設定一個 Route Handler，內容如下:


```ts
import { handlers } from "@/auth" // 引用我們剛才創建的 auth.ts
export const { GET, POST } = handlers
```

:::warning
這個路由必須是 App Router 的路由處理程序，不過你可以選擇其他頁面結構（如使用 `page/` 目錄）來維持應用程式的其餘結構。
:::

### **3. 添加 Middleware 設定（可選）**

創建 `middleware.ts` 文件並加入以下程式碼：

```ts
export { auth as middleware } from "@/auth"
```

為了確保用戶會話的持續有效，您可以在應用中添加一個 Middleware。這個 Middleware 每次被調用時，都會更新會話的過期時間，保持會話活躍。

這會把 `auth.ts` 中的 `auth` 方法當作 middleware 引入，確保會話不會過期。


## **步驟 5：設置身份驗證方法**

到這一步，您的基礎設置已經完成，接下來可以開始配置具體的身份驗證方法（如 Google、GitHub 等）並填充 `providers` 陣列。


完成這些步驟後，Auth.js 已成功整合進入你的 Next.js 專案！ 🎉


# 總結

Auth.js 是一個強大且靈活的身份驗證函式庫，它與多種現代 JavaScript 框架深度整合，提供簡單易用的設置和高度的擴展性，並且非常注重用戶數據的隱私和安全性。

在本文中，我們詳細介紹了 Auth.js 的功能特點、支援的身份驗證方式和資料庫整合，並提供了從安裝到配置的完整步驟。無論是初學者還是有經驗的開發者，都能輕鬆上手並快速實現身份驗證功能。

如果你正在尋找一個可靠且功能豐富的身份驗證解決方案，Auth.js 絕對是值得考慮的選擇。希望這篇教學對你有所幫助，讓你的 Next.js 專案更安全、更高效。如果在設定過程中遇到問題，歡迎留言討論 😊