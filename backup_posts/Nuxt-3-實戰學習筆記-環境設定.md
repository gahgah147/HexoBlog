---
title: Nuxt 3 實戰學習筆記 - 環境設定
date: 2023-12-14 15:47:20
tags:
  - 前端框架
  - Vue
  - Nuxt 3
  - 2023 iTHome 鐵人賽
---

# 前言

這篇文章是我在 2023 iTHome 鐵人賽看到 Ryan 大大 寫的 [Nuxt 3 實戰筆記 系列](https://ithelp.ithome.com.tw/users/20152617/ironman/6959) 文章做的一個紀錄，我之前也都有看到發表Nuxt 相關的文章，寫得都很用心仔細很值得跟著練習，我覺得最特別的是 Nuxt 新的 DevTools功能 

# Nuxt CLI 指令

nuxi 全名為 (Nuxt CLI, Nuxt Command Line Interface)，是由 Nuxt 提供開發的標準工具，Nuxt CLI 就像是 Vue CLI 可以建立 Vue 專案，我們當然也就可以使用 Nuxt CLI 來建立 Nuxt 的專案。

# 環境準備

環境準備流程如下，通常主要會用到的nuxi 指令也是這幾個

清除 npx 快取
建立 Nuxt 專案
檢查專案相關資訊
升級 Nuxt 3 版本 
啟動開發伺服器
清除自動產生的 Nuxt 檔案和快取
產生靜態網站使用的預渲染
打包專案建構生產環境需要的程式包
預覽網站
開發工具 Nuxt DevTools


更多完整的指令與用法可以參考[官方文件](https://nuxt.com/docs/api/commands/init)。
 
## 清除 npx 快取 - clear-npx-cache

```
npx clear-npx-cache
```
![image](https://hackmd.io/_uploads/Syy08m_8T.png)


當一切準備就緒後，你可以執行下列指令，它將會安裝最新版本的 Nuxt CLI 並執行 --help 來看相關說明。

```
npx nuxi@latest --help
```

如果你有看到如下圖的相關指令說明，就代表你安裝成功囉！
![image](https://hackmd.io/_uploads/HJsbvQ_UT.png)

## 使用 nuxi 建立 Nuxt 專案與啟動開發伺服器
如果你第一次使用 Nuxt 3，依據官網的範例，你可以在終端機執行下列指令，就能開始建立 Nuxt 的專案：
```
npx nuxi@latest init nuxt-app
```

![image](https://hackmd.io/_uploads/B1bpPX_U6.png)
> 建立的過程

這邊首先會問  Which package manager would you like to use?
選擇 npm

Are you interested in participating?

操作完成之後會告訴你接下來如何開啟專案
✨ Nuxt project has been created with the v3 template. Next steps:
 › cd nuxt-app
 › Start development server with npm run dev
 
當你在開發時，可以在專案資料夾內執行下列指令來啟動開發伺服器：
```
npm run dev
```

上述指令，實際上是執行 package.json 中的 scripts 所定義的 dev 對應腳本指令如下：
```
nuxt dev
```

其實也等同於你在專案目錄下執行：
```
npx nuxi dev
```

nuxi 不僅在啟動開發伺服器與部署編譯上需要使用，開發的過程中，也還有許多不同的指令與參數可以操作使用，以幫助我們開發 Nuxt 專案上的使用。

## 檢查 Nuxt 專案相關資訊 -info
```
npx nuxi info
```
![image](https://hackmd.io/_uploads/HydWK7OIp.png)

## 升級 Nuxt 3 版本  -upgrade

```
npx nuxi upgrade
```

這個指令可以用來將目前專案的 Nuxt 3 升級至最新的版本，如果有一些可能行為調整或不相容的情況，可以再依據實際情境搭配 -f, --force 參數來強制更新。

![image](https://hackmd.io/_uploads/By8Qh7OLp.png)


## 啟動開發伺服器 - run dev

一個新建立的 Nuxt 專案，當你要啟動開發伺服器，你可以使用下面的指令：
```
npm run dev
# 或
npx nuxi dev
```

Nuxt 的 Nitro 就會幫我們啟動開發伺服器，並監聽 Port: 3000。
![image](https://hackmd.io/_uploads/BJSPKmdI6.png)

### --port, -p 設定監聽Port
預設監聽 Port: 3000，若因為衝突或有需要做調整可以使用這個參數
```
npm run dev -- -p 5173
# 等價
npx nuxi dev -p 5173

```
>使用 npm 執行 scripts，可以加上兩個減號 -- 以添加腳本指令後的參數。


### --host, -h 設定 伺服器主機名稱

預設伺服器主機名稱為 localhost，若因為一些跨域或驗證等開發需求，也可以調整

### --open, -o 設定 開啟瀏覽器

當開發伺服器啟動時，開啟瀏覽器並導向到開發的網址。

### --https 設定 啟用https
在開發時若有一些驗證或請求需要 HTTPS，也可以使用這個參數來啟用 HTTPS，預設情況也含有自簽名的 SSL 證書。

![image](https://hackmd.io/_uploads/rJkfi7dIa.png)

## 清除自動產生的 Nuxt 檔案和快取 -cleanup

```
npx nuxi cleanup
```

Nuxt 3 在啟動開發伺服器後，會自動建立 .nuxt 目錄與產生相關的檔案或 TypeScript 使用的類型，建構專案或產生靜態網站時也會建立 .output 或 dist 目錄等，我們可以使用指令來清除這些自動產生的檔案和快取。

### 刪除的目錄包含如下：

* .nuxt
* .output
* dist
* node_modules/.vite
* node_modules/.cache


## 產生靜態網站使用的預渲染  -generate

```
npx nuxi generate
```

我們可以使用以下指令來預渲染專案中的每個路由路徑，並將其結果儲存在純 HTML 當中，其產生的檔案會建立在 .output/public 與 dist 目錄，兩個目錄的檔案內容是一樣的，你可以選擇使用 .output/public 作為靜態網站的部署。

![image](https://hackmd.io/_uploads/BJ9vh7_UT.png)

## 打包專案建構生產環境需要的程式包  -build

```
npx nuxi build
```

當專案開發到一個階段要準備部署時，你會需要打包並建構生產環境所需要的程式，你可以使用以下指令來編譯建構。

![image](https://hackmd.io/_uploads/r10chQOLa.png)

這個指令會建立一個 .output 目錄，其中包含所有應用程式、伺服器與依賴配置，你可以將此目錄作為生產環境使用的目錄進行服務部署。

## 預覽網站 -preview

當使用 nuxi build 專案打包建構完成後，你可以使用下 preview 指令來啟動伺服器，預覽你的 Nuxt 網站。

```
npx nuxi preview
```

![image](https://hackmd.io/_uploads/BkT9pQd86.png)


## 開發工具 Nuxt DevTools 

```
npx nuxi devtools enable
```

透過最新版本 Nuxt CLI 建置的 Nuxt 3 專案已經將 Nuxt DevTools 預置在 Nuxt 專案中並預設為啟用，如果你的專案的 Nuxt 3 版本還比較舊，可以手動安裝 Nuxt DevTools，或使用以下指令來配置。

![image](https://hackmd.io/_uploads/ByJT67uUT.png)

### 關閉 Nuxt DevTools

```
npx nuxi devtools disable
```
如果你想要關閉 Nuxt DevTools，可以使用以下指令來關閉，它會提示您是否要將 ./nuxt.config.ts 檔案內的 devtools.enabled 設定為 false 來關閉 DevTools。


# 參考來源:

https://ithelp.ithome.com.tw/users/20152617/ironman/6959
https://nuxt.com/docs/api/commands/init
