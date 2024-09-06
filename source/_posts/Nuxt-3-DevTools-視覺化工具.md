---
title: Nuxt 3 DevTools 視覺化工具
date: 2024-01-03 15:33:31
tags:
  - Nuxt 3
  - 2023 iTHome 鐵人賽
  - DevTools
  - Vue
  - 前端框架
---

# 前言

這篇文章是我在 2023 iTHome 鐵人賽看到 Ryan 大大 寫的 [Nuxt 3 實戰筆記 系列](https://ithelp.ithome.com.tw/users/20152617/ironman/6959) 文章做的一個紀錄，我之前也都有看到發表Nuxt 相關的文章，寫得都很用心仔細很值得跟著練習，我覺得最特別的是 Nuxt 新的 DevTools功能 

# 安裝與啟用 Nuxt DevTools

目前最新版的 Nuxt CLI 在建立專案時，預設已經預置並啟用了 Nuxt DevTools，你無需再另外設置，你可以透過專案下的 ./nuxt.config.ts 檔案確定，devtools.enabled 屬性是否設定為 true。

```
export default defineNuxtConfig({
  devtools: {
    enabled: true,
  }
})
```
如果你的專案尚未啟用 Nuxt DevTools，你可以使用下列指令來為專案加入，需要注意的是 Nuxt DevTools 需要 Nuxt v3.1.0 或更高版本。
```
npx nuxi@latest devtools enable
```

當你使用指令啟用 devtools，等同於下列步驟安裝與配置 @nuxt/devtools 模組。

```
npm install -D @nuxt/devtools
```

```
// nuxt.config.ts
export default defineNuxtConfig({
  modules: [
    '@nuxt/devtools',
  ]
})
```
同樣的你也可以透過設定 devtools.enabled 屬性為 **false，**或使用下列指令來禁用 Nuxt Devtools。
```
npx nuxi@latest devtools disable
```

接下來我們以 Nuxt 3 的演示專案 Nuxt Movies 來展示 DevTools 的功能，你也可以直接套用在你的專案搭配著本篇介紹一步一步來嘗試使用 Nuxt DevTools。

接下來我們以 Nuxt 3 的演示專案 [Nuxt Movies](https://github.com/nuxt/movies) 來展示 DevTools 的功能，你也可以直接套用在你的專案搭配著本篇介紹一步一步來嘗試使用 Nuxt DevTools。

fork 練習 專案 https://github.com/nalson0219/movies

# 開啟 Nuxt Devtools 面板

安裝並啟用 Nuxt DevTools 後，在你啟動開發伺服器後，使用瀏覽器瀏覽網站頁面上會出現一個 Nuxt Logo 的圖示，如下圖紅色框起處，通常預設會是吸附在頁面底部。
![image](https://hackmd.io/_uploads/r1_bhFtL6.png)
> npm run dev 開啟專案

當你把滑鼠滑入圖示時，就會展開工具，如果它遮擋著你的頁面，你也可以拖曳它來移動畫面中貼附的位置。

![image](https://hackmd.io/_uploads/B1K2pttIp.png)
展開的工具共有三欄，分別為
1.Nuxt 圖示點擊後可以開啟 Nuxt Devtools 面板
2.導航至頁面載入時間
3.檢查器（Inspector）


如下圖，當我們需要開啟 Nuxt DevTools 面板，點擊頁面懸浮迷你面板最左方的 Nuxt 圖示便會開啟，當然你也可以透過快捷鍵，例如 Mac 使用 Shift + Option + D 來開啟，開啟後的面板你也可以根據需求來調整大小。

![image](https://hackmd.io/_uploads/ryFw0YFUa.png)

當我們點擊顯示 DevTools 面板，會出現如下圖的概覽，包含了 Nuxt 與 Vue 的版本，甚至提示你版本落後可以進行更新，蓋懶得資料也包含了整個 Nuxt 專案的資訊頁面、元件、載入、模組與插件的數量等，可以很快速的讓你了解專案概況。

![image](https://hackmd.io/_uploads/HJbqRKYIa.png)

# 使用 Nuxt DevTools 檢查器（Inspector）

當你的專案是接手維護或規模比較大的團隊協作時，Nuxt DevTools 整合了 [vite-plugin-vue-inspector](https://github.com/webfansplz/vite-plugin-vue-inspector) 插件，
這項功能使元件的調整更加的容易，你也可以不必深入完整了解專案結構，就能快速定位渲染的程式。


![image](https://hackmd.io/_uploads/B1Drz9KUa.png)
>點擊檢查器後，當滑鼠滑入畫面的元素便會提示元件檔案位置與行數，點擊後能前往該檔案。

{% note warning simple %}
這功能我目前測試有問題，點開是不會跳到那邊
{% endnote %}

# Nuxt DevTools 工具面板介面功能
![image](https://hackmd.io/_uploads/SJp9QcYI6.png)

如果你是第一次使用或想要調整工具面板的設定，可以點選左下角的圖示，如下圖紅色框起處，就會切換至設定的分頁，在這裡你可以決定左側選單的項目顯示或隱藏，這將有助於關閉一些對你來說不重要的分頁圖示，你也可以在這裡修改深色模式、懸浮迷你面板的縮小間隔時間與 UI 縮放等設置。

![image](https://hackmd.io/_uploads/H1TzEcYIp.png)

基本上 Nuxt DevTools 面板上可以使用功能，多數只要切換至該功能分頁，你就能理解它將帶給你的資訊與協助。

# 小結
目前 Nuxt DevTools 雖然還處於預覽階段，但已經有許多強大的功能，未來 Nuxt DevTools 計畫提供更直觀、更有趣的方式來呈現數據，除了輕鬆管理與建立 Nuxt 的專案外，在開發工具上也提高框架約定的透明度來改善開發體驗，如果你有興趣也可以關注 Nuxt DevTools 的專案並分享想法與建議甚至做出貢獻，更多資訊與功能也可以查看[官方文件](https://github.com/nuxt/devtools)。


# Pages 
在開啟 Nuxt Tools 工具面板後，我們切換到 Pages 分頁。
![image](https://hackmd.io/_uploads/S1EMrcF86.png)

Pages 分頁展示了目前專案所有註冊的頁面路由 (Rotes) 與路由中間件 (Middleware)。

##  所有註冊的頁面路由 -  All Routes 

![image](https://hackmd.io/_uploads/HylgUqYI6.png)


如果你不熟悉頁面檔案所產生的路由名稱，在下圖的紅色框起處的路由名稱，可以幫助你在使用程式化導航時，以具名的方式來前往路由，如 router.push({ name: 'search' })。

你可以點擊路由的路徑網址就可以同步網頁進行路由導航，點擊就會跳轉至 /search 搜尋頁面，當然你也可以透過面板上方的輸入框來編輯導航路徑。


## Middleware
你也可以看到屬於全域、匿名或僅適用於客戶端或伺服器的路由中間件，點擊就能開啟編輯器跳轉至實作的特定行數。

# Components
Components 分頁展示了目前專案所有的元件 (Components)，可以在這邊使用搜尋框搜尋元件的名稱，也可以依據使用與非使用中的元件來進行過濾。

![image](https://hackmd.io/_uploads/BJ4i1jFLa.png)

元件以四種分類的方式於面板上呈現，分別如下：

| 元件類型 | 說明 | 
| -------- | -------- | 
| User components     | 使用者自行建立的元件，通常是放置在專案 ./components 目錄下的元件。 | 
| Runtime components |  在執行時期使用的元件，通常有使用才打包進來。| 
| Built-in components    | Nuxt 的內建元件。 | 
| Components from libraries   |  由外部模組或套件所提供的元件。 | 

![image](https://hackmd.io/_uploads/rkgUxjKUp.png)

![image](https://hackmd.io/_uploads/HJHjgstI6.png)

你可以點擊如下圖示按鈕，元件將會以圖 (Graph) 的視覺化效果來呈現，專案中使用的元件彼此之間的關聯。
![image](https://hackmd.io/_uploads/H18cSoFU6.png)


![image](https://hackmd.io/_uploads/Skq_SoKUa.png)

如果透過元件名稱或圖的表示的元件關聯，不能夠滿足你搜尋畫面中所呈現的元件，你可以嘗試使用檢查器 (Inspector)，如下圖紅色框起處的圖示，它的執行方式類似於瀏覽器的除錯工具「檢查元素」。


# 組合式函式 - Imports
Imports 分頁展示了目前專案所有的組合式函式 (Imports)，你可以在這邊使用搜尋框搜尋組合式函式的名稱，也可以依據使用與非使用到的組合式函式來進行過濾。


![image](https://hackmd.io/_uploads/H1J4IjFIT.png)

元件以四種分類的方式於面板上呈現，分別如下：

|  Imports 類型 | 說明 |
| -------- | -------- | 
| User composables    | 使用者自行建立的組合式函式，通常是放置在專案 ./composables 目錄下的式。| 
| Built-in composables    | 內建元件，例如 Nuxt 提供的 navigateTo 和 Vue 的 computed 等。 | 
| Components from libraries    | 由外部模組或套件所提供的組合式函式。 | 

![image](https://hackmd.io/_uploads/r1ebDiYIp.png)

你可以在這個分頁搜尋與篩選組合式函式，在使用的函式名稱上也會標示綠色 x1, x2 表示使用的次數，當你點擊組合式函式，除了可以複製與跳轉至原始碼的實作，部分組合式函式有提供文件，也可以透過按鈕快速地前往官方文件查看使用說明。

# Modules

Modules 分頁展示了，Nuxt 專案內所使用的模組，也會顯示模組版本、官方網站與 GitHub 專案等資訊。

![image](https://hackmd.io/_uploads/HkQG_sYIa.png)

可以點選右下角的 Install New Module 來搜尋並安裝新的 Nuxt 模組
![image](https://hackmd.io/_uploads/rywNdiF8T.png)

如果專案中使用的模組版本落後，在面板上也會顯示最新的版本號，如下圖紅色框起處，點擊後也會提示升級的指令，或透過介面一鍵升級。

# 靜態資源 - Assets 

如下圖 Modules 分頁展示專案內的靜態資源讓你可以在這邊快速瀏覽與搜尋，不過目前僅支援專案下的 public 目錄的檔案。
![image](https://hackmd.io/_uploads/r1UcOiY8p.png)

![image](https://hackmd.io/_uploads/r1RPFiF8T.png)
> 需要填入啟動開發伺服器的終端機上提示的 Token 或點擊連結來授權，就可以開始使用。

![image](https://hackmd.io/_uploads/HkJTYsYUa.png)
> 圖片可以直接拖曳上傳

# 專案內部 Server - Server Routes

Server Routes 分頁展示了目前專案內部 Server API，它可以方便你針對 ./server 目錄下建置的內部 API 來發送與測試 HTTP 請求，有點類似輕便版的 Postman，專為開發者提供的 API 測試工具。

![image](https://hackmd.io/_uploads/r1Km9otUa.png)

# 使用儲存層的資料 - Storage
Storage 分頁展示了網站伺服器使用到儲存層 (Storage Layer) 時的資料，這項功能對於有使用 Nuxt 建立內部伺服器 API 與搭配使用 Nitro 提供內建儲存層來抽象檔案系統或資料庫做快取操作等。

![image](https://hackmd.io/_uploads/H1HJojtLa.png)

# VS Code
Nuxt DevTools 整合了 VS Code Server，讓完整的 VS Code 編輯器可以整合至開發工具內，也可以安裝 VS Code 的插件及導入你個人化的設定。

接下來，我們切換到下圖紅色框起處的 VS Code 分頁。
![image](https://hackmd.io/_uploads/rJDXsst8T.png)

![image](https://hackmd.io/_uploads/S10KcLf_6.png)

{% note info simple %}
這邊要指定 code server port 3080
{% endnote %}

```
code-server --port 3080
```



![image](https://hackmd.io/_uploads/BkzKL_zda.png)
>成功啟用 code server

# Hooks

![image](https://hackmd.io/_uploads/HyzguOzO6.png)

Hooks 分頁展示了網站客戶端與伺服器端使用的 Hooks，分頁上條列各個 Hook 名稱、監聽事件數量、執行數與花費時間，對於模組的作者或更進階的使用，它可以幫助你檢查問題與瓶頸進而調整網站的效能。

![image](https://hackmd.io/_uploads/BkkS_dfdT.png)

# Virtual Files

![image](https://hackmd.io/_uploads/S1yvOuGu6.png)

Virtual Files 分頁展示了 Nuxt 產生的虛擬文件，虛擬文件是動態產生的，某些情況你可能會使用到這些檔案，但這些產生的檔案主要是為了支援框架的約定，也屬於適合模組或比較進階的開發者，並更提供更好的開發者體驗。

![image](https://hackmd.io/_uploads/BklSFdOG_T.png)

# Inspect
![image](https://hackmd.io/_uploads/HkX3ddMdT.png)

Inspect 分頁整合了 antfu/vite-plugin-inspect 插件，如下圖，你可以切換不同的呈現方式，或者觀看 Vite 插件的執行時間等。


![image](https://hackmd.io/_uploads/HkxeKOfup.png)

![image](https://hackmd.io/_uploads/HJClFOMOp.png)

# Module Contributed View

考量了 Nuxt 的生態系統，Nuxt DevTools 的開發與設計上非常的靈活也具擴展性，不管是官方、社群或個人的模組，都可以像 DevTools 貢獻自己的分頁，使模組也能整合進 Nuxt DevTools 中並提供使用者進行交互。

舉例來說，專案上使用到了 VueUse 與 Viteest 這兩個模組，而且這兩個模組都有整合至 Nuxt DevTools 的分頁中，如下圖在 DevTools 的面板左側就能看到 VueUse 與 Vitest 兩個圖示分頁。

在 VueUse 模組分頁上提供了可使用的組合式函式的搜尋頁面與文件說明。

![image](https://hackmd.io/_uploads/rymwsdf_a.png)

#  Nuxt Vitest 

![image](https://hackmd.io/_uploads/BJtmnOzuT.png)
>import Vitest  模組

![image](https://hackmd.io/_uploads/Sk_G2OfOa.png)

![image](https://hackmd.io/_uploads/HJJgndMu6.png)

# Runtime Configs
![image](https://hackmd.io/_uploads/rJAEStzOp.png)

Runtime Configs 分頁展示了目前專案 App Config 及公開與私有的 Runtime Configs，這邊也有個小細節，如果是私有的設定 Private Runtime Config，預設是不會展開的。

![image](https://hackmd.io/_uploads/rJ2ISYMda.png)

在每個分類的設定中，都可以使用 JSON Editor 來進行新增編輯與驗證等操作，例如新增一個 primaryColor，如果你編輯數值也會同步響應至變數。

![image](https://hackmd.io/_uploads/r1e9rYfOT.png)

# Payload

![image](https://hackmd.io/_uploads/rkPirKfua.png)

Payload 分頁展示了網站中使用到組合式函式 useState、useAsyncData 與 useFetch 所建立的狀態，這些狀態在伺服器端建立時，會以 JSON Payload 與 HTML 一併回傳給客戶端重複做使用，讓客戶端不必在次請求資料直接在 Payload 中取得。

![image](https://hackmd.io/_uploads/H120rYfO6.png)

你也可以在 State 或 Data 狀態分類中修改各個狀態JSON 結構的 Payload，修改的值也會同步的響應至狀態，例如我們修改頁面中使用 useAsyncData 得到的文章資料 Payload，修改後的 title 頁面中也會同步響應呈現。


State 或 Data 狀態分類中，每個狀態都擁有兩個圖示按鈕 Refresh View 與 Generate Data Scheme，分別可以重新同步頁面上的狀態及產生狀態的 Scheme。

![image](https://hackmd.io/_uploads/BkwSLYz_T.png)

# Open Graph
![image](https://hackmd.io/_uploads/SyPqLKz_T.png)

Open Graph 分頁，能幫助你在做網頁的 SEO 搜尋引擎最佳化時，查看你對網頁設定的 Meta Tags 並提醒與建議你遺漏的 Meta Tags，除了可以透過上方網址列快速跳轉到其他頁面，也使用旁邊的按鈕圖示來開啟檔案、重新整理資料，另外你也透過面板提供的預覽功能，查看你的 Open Graph Tags 是否設定正確，它以常見的社群媒體預覽不同樣式的連結縮圖。

![image](https://hackmd.io/_uploads/rJnkDYM_T.png)

面板上不僅會呈現遺漏的建議標籤，也可以透過如下圖的紅色框起處，來使用工具提供建議的程式碼片段來添加建議的 Meta Tags。

![image](https://hackmd.io/_uploads/r1lBwYGuT.png)

# Plugins

![image](https://hackmd.io/_uploads/Hy7SKKM_6.png)
Plugins 分頁依序展示了專案中插件的載入，包含了使用者自訂、套件模組的插件，並依序條列的載入出來，每個插件也會標記上來自於套件或哪個目錄下的檔案，也會依據伺服器端、客戶端等類型來特別標記插件。

![image](https://hackmd.io/_uploads/rJBDYYfup.png)

標示了各個插件載入執行所花費的時間與所有插件的執行總時間，插件在載入執行的時間，其實間接的影響到頁面的請求時間，所以如果對於效能要求比較高的網站，使用介面提供資訊能輔助你追蹤載入較費時的插件。

# Timeline
![image](https://hackmd.io/_uploads/B1N9KFz_6.png)

Timeline 分頁的功能就像是瀏覽器開發者工具的時間線 (Timeline)，可以讓你追蹤網站的耗費時間的分佈，例如 DOM 事件、分頁元件的渲染等，Nuxt DevTools 的 Timeline 功能預設是關閉的，如下圖依據指引進行啟用就可以開始使用該功能。

![image](https://hackmd.io/_uploads/ByD_stzdp.png)
>在介面上按下 Start Tracking，並開始操作網頁上的事件，例如點擊連結，介面就會開始紀錄函式的呼叫與花費時間。


