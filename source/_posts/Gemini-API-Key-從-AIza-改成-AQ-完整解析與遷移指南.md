---
title: Gemini API Key 大改版！為什麼 API Key 不再是 AIza，而是 AQ？完整解析與遷移指南
date: 2026-07-20 12:00:00
tags:
  - Gemini API
  - Google AI Studio
  - API Key
  - Google Cloud
categories:
  - AI 開發
keywords:
  - Gemini API Key
  - Gemini AQ Key
  - AIza API Key
  - Authorization Key
  - Google AI Studio
description: Google AI Studio 新建立的 Gemini API Key 為什麼從 AIza 變成 AQ？本文解析 Authorization Key、Service Account、IAM、安全性、第三方工具相容性與 2026 遷移時程。
top_img: /images/gemini-api-key-aiza-to-aq-migration-guide.png
comments:
cover: /images/gemini-api-key-aiza-to-aq-migration-guide.png
toc: true
toc_number: true
copyright:
mathjax:
katex:
hide:
---

# Gemini API Key 大改版！為什麼 API Key 不再是 AIza，而是 AQ？完整解析與遷移指南

> 最近不少開發者在 Google AI Studio 建立 Gemini API Key 時，發現金鑰的開頭和以前不一樣了。

![Gemini API Key 從 AIza 遷移至 AQ 的架構、差異與行動指南](/images/gemini-api-key-aiza-to-aq-migration-guide.png)

過去常見的 Gemini API Key 長這樣：

```text
AIzaSy...
```

現在於 Google AI Studio 建立的新金鑰，則可能變成：

```text
AQ.AbCdEf...
```

看到新的格式時，很多人的第一反應是：

- 我的帳號壞了嗎？
- Google AI Studio 出現 Bug？
- 免費方案不能使用了？
- API Key 建立錯誤？

其實都不是。

Google 正在將 Gemini API 的驗證方式，從傳統的 **Standard API Key（標準 API 金鑰）** 遷移至新的 **Authorization Key（授權金鑰）**。這是官方規劃的安全性升級，而不是帳號異常。

> 本文依據 Google 官方文件整理，資訊更新日期為 2026 年 7 月 20 日。遷移政策仍可能調整，實作前請再次查看[官方 API 金鑰文件](https://ai.google.dev/gemini-api/docs/api-key?hl=zh-tw)。

---

## 先說結論

如果你今天在 Google AI Studio 建立新的 Gemini API Key，看到類似以下格式：

```text
AQ.Abxxxx...
```

**這是正常的。**

Google AI Studio 新建立的 Gemini API Key，現在預設採用授權金鑰。Google 也已宣布，Gemini API 預計在 **2026 年 9 月**停止接受標準 API 金鑰的請求。

因此，與其想辦法取得舊的 `AIza` 金鑰，更實際的做法是更新 SDK、第三方工具與部署環境，確認它們可以正常使用新的 `AQ` 金鑰。

---

## AIza 與 AQ 有什麼差別？

過去 Gemini API 常用的金鑰格式是：

```text
AIza...
```

Google 將其稱為 **Standard API Key**。標準金鑰會將 API 請求與 Google Cloud 專案關聯，主要用於帳單與配額管理，但不會識別實際呼叫者，因此能套用的權限與存取控制較有限。

新的金鑰格式則是：

```text
AQ.Ab...
```

Google 將其稱為 **Authorization Key**，官方中文文件譯為「授權金鑰」或「驗證金鑰」。授權金鑰會直接綁定 Google Cloud Service Account，系統會以該服務帳戶的身分處理請求。

概念上可以這樣理解：

```text
傳統 Standard Key

Request
   ↓
AIza API Key
   ↓
Google Cloud Project
```

```text
新的 Authorization Key

Request
   ↓
AQ Auth Key
   ↓
Service Account
   ↓
Google Cloud Project
```

新的架構讓 Google 能夠：

- 識別由哪個 Service Account 發出請求
- 套用更細緻的 IAM 權限控制
- 將金鑰用途限制在 Gemini API
- 在偵測到金鑰外洩時快速停用

詳細差異可參考 [Google AI for Developers：使用 Gemini API 金鑰](https://ai.google.dev/gemini-api/docs/api-key?hl=zh-tw)。

---

## Google 為什麼要改？

最主要的原因是降低 API Key 外洩與遭濫用的風險。

傳統 API Key 如果被放進 GitHub、公開網站、前端 JavaScript Bundle 或其他可公開讀取的位置，就可能被第三方取得並拿去呼叫 API。這不只會消耗配額，也可能產生非預期費用。

Google 官方一直強調：API Key 應視為密碼，不應提交到版本控制，也不應直接放在正式環境的前端或行動應用程式中。正式環境建議透過後端服務呼叫 API，並使用環境變數或 Secret Manager 管理金鑰。

延伸閱讀：[Google Cloud Blog：Securing Your Gemini and Google API Keys](https://cloud.google.com/blog/topics/developers-practitioners/api-keys-are-open-secrets)

---

## AQ 授權金鑰有哪些好處？

### 1. 更細緻的 IAM 控制

AQ 金鑰直接與 Service Account 綁定，系統可以使用服務帳戶身分處理請求，讓專案管理者進行更細緻的存取控制。

### 2. 更快阻止外洩金鑰

官方文件指出，授權金鑰在系統偵測到外洩後可以立即停止使用，縮短外洩金鑰遭濫用的時間。

### 3. 預設限用於 Gemini API

授權金鑰預設只能用於 **Generative Language API（Gemini API）**，用途比可能同時存取多個 Google API 的傳統金鑰更單純。

### 4. 呼叫者身分更明確

標準 API Key 主要識別專案，授權金鑰則能將請求連結至服務帳戶，讓權限模型更接近 Google Cloud 原本的 IAM 架構。

> 注意：官方文件目前也註明，以授權金鑰驗證的請求，不會記錄在 Google Cloud 的服務帳戶用量指標中。

---

## 為什麼有些工具不能使用 AQ Key？

Gemini API 本身接受授權金鑰，不代表所有第三方工具都已完成相容更新。

部分舊版 SDK、外掛或自動化工具可能：

- 用 `^AIza` 之類的規則檢查金鑰格式
- 假設所有 Google API Key 都是固定長度
- 使用尚未支援授權金鑰的舊版 SDK
- 在真正送出 API 請求前，就先把 `AQ` 判定為格式錯誤

因此，看到以下錯誤時：

```text
Invalid API Key
```

或：

```text
401 Unauthorized
```

不一定代表金鑰本身有問題，也可能是用戶端工具仍對金鑰格式做了過時的限制。

建議依序檢查：

1. 將 SDK、套件或第三方工具更新到最新版。
2. 查看該工具的 Release Notes 或 Issue，確認是否提到 AQ、Authorization Key 或 Auth Key。
3. 確認環境變數沒有多餘空白、換行或引號。
4. 使用 Google 官方 SDK 或 REST API 做最小化測試。
5. 如果官方方式正常、第三方工具失敗，再向該工具回報相容性問題。

社群上也已有開發者討論新舊金鑰格式，可參考 [Google AI Developers Forum 的相關討論](https://discuss.ai.google.dev/t/api-key-to-start-with-aiza/169453)，但實際政策仍應以官方文件為準。

---

## OpenAI Compatible Endpoint 特別要注意

部分開發者會透過 Gemini 的 OpenAI 相容端點搭配 OpenAI SDK：

```text
https://generativelanguage.googleapis.com/v1beta/openai/
```

如果使用 AQ 金鑰時遇到錯誤，先確認問題發生在哪一層：

- Gemini API 是否接受這把金鑰
- OpenAI SDK 是否正確傳送金鑰
- 第三方框架是否自行驗證金鑰前綴
- Base URL 是否設定正確
- 使用的模型名稱是否仍有效

最簡單的排查方式，是先以官方 Gemini SDK 或 REST API 驗證金鑰，再回頭檢查 OpenAI 相容層。若原生呼叫成功，相容端點或第三方工具失敗，問題通常在用戶端設定或工具版本，而不是 `AQ` 前綴本身。

---

## Google 公布的遷移時程

### 2026 年 5 月 7 日起

Gemini API 開始封鎖**長期閒置且未設限**的標準 API 金鑰。被封鎖的金鑰會在 Google AI Studio 顯示「已封鎖」標記。

如果仍需要使用 Gemini API，應建立新的授權金鑰，或改用現有且已設定限制的標準金鑰作為過渡方案。

### 現階段

Gemini API 會拒絕未設限標準金鑰的請求；已明確套用限制的標準金鑰暫時仍可運作。Google AI Studio 建立的新金鑰則預設為授權金鑰。

### 2026 年 9 月

Gemini API 預計全面拒絕標準 API 金鑰的請求，包括 `AIza` 格式的 Standard Key。

換句話說，即使目前受限的 AIza 金鑰仍能使用，也不適合繼續當作長期方案。

---

## 如果現在還在使用 AIza，需要做什麼？

Google 官方建議的遷移流程如下：

1. 前往 Google AI Studio 的 API 金鑰頁面。
2. 找出金鑰類型為「標準」的舊金鑰。
3. 建立新的 AQ 授權金鑰。
4. 更新本機環境變數、部署設定與 Secret Manager。
5. 在測試或預備環境驗證新金鑰。
6. 確認正式環境運作正常。
7. 最後再撤銷或刪除舊的 AIza 金鑰。

不要先刪除舊金鑰再測試新金鑰，否則可能造成服務中斷。

---

## 台灣開發者需要注意哪些事情？

如果平常使用 Cursor、VS Code 擴充套件、自動化平台、WordPress 外掛、Open WebUI、LibreChat 或 AnythingLLM 等第三方工具，建議先確認：

- 工具目前的版本是否支援 AQ 授權金鑰
- 使用的 Gemini SDK 是否為最新版
- 金鑰欄位是否寫死只接受 `AIza` 開頭
- 是否支援 Gemini 的原生 API 或 OpenAI 相容端點
- 團隊的 CI/CD、Secret Manager 與環境變數是否已同步更新

如果工具介面明確要求 `AIza` 開頭，通常表示該工具仍使用舊的格式檢查。這時不建議為了配合舊工具而繼續依賴 Standard Key，應優先更新工具或向維護者確認遷移計畫。

另外，無論使用哪一種金鑰，都不要：

- 把真實金鑰貼到 Issue、論壇或聊天群組
- 將金鑰提交至 GitHub
- 在前端程式碼中硬編碼金鑰
- 用完整金鑰截圖示範錯誤

需要回報問題時，只顯示前幾個字元，例如 `AQ.Ab...` 即可。

---

## 結語

Google 將 Gemini API Key 從 `AIza` 遷移至 `AQ`，並不只是更換金鑰字首，而是整體驗證與權限架構的安全性升級。

對開發者而言，短期內可能遇到舊版 SDK 或第三方工具的相容性問題；長期來看，授權金鑰能帶來更清楚的服務帳戶身分、更細緻的權限管理，以及更快的外洩金鑰處理能力。

如果今天建立 Gemini API Key，看到的是：

```text
AQ.Abxxxxxxxx
```

不用擔心，這代表你取得的是 Google 新一代的 Authorization Key。

比起想辦法找回 `AIza`，更建議現在就盤點 SDK、第三方工具、部署設定與 Secret 管理流程，並在 **2026 年 9 月以前**完成遷移。

---

## 參考資料

- [Google AI for Developers：使用 Gemini API 金鑰](https://ai.google.dev/gemini-api/docs/api-key?hl=zh-tw)
- [Google AI for Developers：OpenAI compatibility](https://ai.google.dev/gemini-api/docs/openai)
- [Google Cloud Blog：Securing Your Gemini and Google API Keys](https://cloud.google.com/blog/topics/developers-practitioners/api-keys-are-open-secrets)
- [Google AI Developers Forum：API key to start with AIza](https://discuss.ai.google.dev/t/api-key-to-start-with-aiza/169453)
