---
title: Google Analytics 4 練習紀錄
date: 2023-11-13 09:32:48
tags: 
 - GA4 
---

這篇是記錄我在看[鐵人賽  跟著 OXXO 一起學 GA4 ( Google Analytics 4 )](https://ithelp.ithome.com.tw/articles/10314237) 的過程 

# GA4 介紹

## GA4 是什麼？

Google Analytics 4 ( GA4 ) 是 Google 的最新版本分析工具，與過去的版本不同的是，GA4 更加注重事件驅動的分析，除了支持跨設備和跨平台數據收集，也提供了更多人工智慧和機器學習功能，能夠更有效地透過流量了解使用者。

GA4 以「事件 Events」為資料收集的基礎，除了幾個基本事件，如果要分析額外資訊，則需要自行建立其他額外事件，這種全新的資料收集架構，大幅提高在商業應用上的深度與彈性，但也增加了不少學習門檻，且 GA4 目前仍在不斷發展階段，許多未來「可能調整」的介面或功能，也是導入 GA4 時需要面對的挑戰。

## 發展歷程

自 2005 年推出以來，GA 整合了許多的功能，已經成為一個廣泛使用且不可或缺的分析工具，下方簡單整理了 GA 的發展歷程與重要里程碑：

| 年份 | 概要 | 
| -------- | -------- | 
| 1997     | 網站數據分析工具 Urchin 誕生    | 
| 2005     | Google 收購 Urchin，正式推出 Google Analytics ( GA )。    | 
| 2008	    | 加入 Custom Reports 和 Advanced Segments 功能，增強自訂分析和進階分析的能力。  | 
| 2009	    | 加入 Event Tracking 功能，增強深度監測和分析使用者互動行為。  | 
| 2011	    | 加入 Multi-Channel Funnels ( MCF ) 功能，降低多管道歸因分析門檻，並加入 Real-Time 即時監看數據的功能。 | 
| 2012	    | 發佈 Google Tag Manager ( GTM )，讓使用者更能有效地整合自己的 GA 程式碼。 | 
| 2012	    | 發佈Universal Analytics ( UA )，允許跨設備和跨平台數據收集。 | 
| 2013	    | 發佈 Measurement Protocol 測量協議，定義從任何系統或裝置傳送資料到 Google Anlaytics 的方法。 | 
| 2014	    | 發佈 Enhanced ecommerce，增強電商處理數據功能。 | 
| 2016	    | 發佈 Google Analytics 360，整體解決方案升級為 Google Analytics Solutions。 | 
| 2018	    | 發佈 Google Marketing Platform，整合 Google Analytics 360 和 DoubleClick。 | 
| 2019	    | 發佈 APP + Web Property ( 取代 Google Analytics For APP )。| 
| 2020	    | 發佈 Google Analytics 4 ( GA4 )，也是 APP + Web 的延伸。| 
| 2023	    | 全面使用 GA4，停用通用版本 GA。| 

## 特色
1. 智慧化報告：透過更加智慧化的報告，更容易了解使用者行為。
1. 注重資料隱私：更強大的資料隱私功能，可以更好地保護用戶的資料安全 ( 例如無 Cookie 的評估功能、行為與轉換模擬 )。
1. 跨設備追蹤：具有跨設備追蹤功能，可以追蹤使用者在不同設備上的互動。
1. 事件驅動：以事件 (而非工作階段) 為基礎的資料。
1. 客製化功能：具有更加靈活的客製化功能，可以根據使用者需求定製不同的報告。
1. 整合媒體平台：整合 Google 廣告系統，可以更好地管理網絡廣告。
1. 預測功能：不需要複雜模型即可提供指引。

# 建立分析資源

## 單純建立 GA4 分析資源
登入 Google 帳戶之後，從下方的網址可以前往 Google Analytics 平台：
![](https://hackmd.io/_uploads/BJzAdSAM6.png)
>https://analytics.google.com/analytics/web/provision/#/provision

:::info
點擊開始評估就能啟用 Google Analytics 的帳戶
:::

![](https://hackmd.io/_uploads/S1DuKrRMT.png)
>在帳戶設定步驟，將「帳戶共用設定」的共用方式全部勾選 ( 或是使用預設值也可以 )。

在資源設定步驟，輸入資源名稱以及對應的貨幣、時區，進階選項會詢問是否建立通用版的 GA，根據個人需求選擇是否同時建立 ( 因為 2023 年 7 月以後 Google 不支援通用版 GA，因此可以不用建立 )。
![image.png](https://hackmd.io/_uploads/SJItkkbXa.png)

![image.png](https://hackmd.io/_uploads/ByksJ1Z7p.png)
>建立商家資訊

![image.png](https://hackmd.io/_uploads/HJT61kZQT.png)
>選擇業務目標

![image.png](https://hackmd.io/_uploads/ryaSxJ-QT.png)
>設定資料串流

![image.png](https://hackmd.io/_uploads/HJ8qxkZXa.png)
>一個 GA4 的分析資源就會建立完成。


如果已經有 Google Analytics 的帳戶和資源，點擊左下角的「設定」按鈕圖示，就能「建立帳戶」或從現有帳戶「建立資源」。

#  安裝資料收集代碼

![image.png](https://hackmd.io/_uploads/rJB7VCW7a.png)
點擊該筆資料串流，開啟串流設定畫面後捲動到最下方，點擊「查看代碼操作說明」。

![image.png](https://hackmd.io/_uploads/S1S8EAZQa.png)
> 複製要放在網站中的資料收集代碼，並將這些資料收集代碼，按照說明放在網頁的 HTML 中

```
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-RQQ6S8TM5J"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-RQQ6S8TM5J');
</script>
```

## 測試 GA4 資料收集代碼
參考下方範例程式碼，將資料收集代碼放入網頁 HTML 裡，可以使用 JS Bin 的線上網頁編輯器進行測試 ( 參考「使用測試網頁」)。
```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

  <!-- Google tag (gtag.js) -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXX"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-XXXXXX);
  </script>
</head>
<body>

</body>
</html>
```

網頁開啟後，應該就能在 GA4 資源的「首頁」裡，看到過去 30 分鐘的使用者出現「1」個使用者，這也表示資料收集代碼已經順利安裝成功。
>GA4 的「即時」通常可能會有三十秒到一分鐘左右的延遲。
要正確執行代碼，不能單純開啟網頁，而是要在本機環境啟用一個網頁伺服器，或使用 JS Bin 的線上網頁編輯器進行測試 ( 參考「使用測試網頁」 )

![image.png](https://hackmd.io/_uploads/ByXNBAWQT.png)

## 查看 GA4 資料串流評估 ID
如果要查看 GA4 資料串流評估 ID，可以從「管理 > 資源 > 資料串流」裡，點擊想要查看的資料串流。
![image.png](https://hackmd.io/_uploads/H1RvBCbmp.png)

## 刪除與還原帳戶

如果要刪除帳戶，可以從「管理 > 帳戶 > 帳戶詳情」的頁面，點擊「丟進垃圾桶」就能刪除帳戶。
![image.png](https://hackmd.io/_uploads/BJ1k1uwm6.png)
>點擊「丟棄帳戶」，就會將該帳戶放入垃圾桶。

![image.png](https://hackmd.io/_uploads/rkTgJuDQ6.png)

前往「已經被丟棄的帳戶」的「管理 > 帳戶 > 垃圾桶」，就能看到被刪除的帳戶，垃圾桶中的項目在保留 35 天之後，就會永久刪除。系統會在變更記錄中留下刪除記錄 ( 帳戶如果存在垃圾桶中，無法使用帳戶設定以及篩選器功能 )。


![image.png](https://hackmd.io/_uploads/ryU7k_wmp.png)

勾選要還原的帳戶，點擊「還原」，就能還原帳戶 ( 還原帳戶需要有「編輯者」權限的使用者 )。
![image.png](https://hackmd.io/_uploads/rkwV1_wQa.png)

## 刪除與還原資源
如果要刪除資源，可以從「管理 > 資源 > 資源設定」的頁面，點擊「丟進垃圾桶」就能刪除資源。
![image.png](https://hackmd.io/_uploads/rkOv1_wma.png)

點擊「移至垃圾桶」，就會將該資源放入垃圾桶。
![image.png](https://hackmd.io/_uploads/r10_JuPQa.png)

前往「管理 > 帳戶 > 垃圾桶」，就能看到被刪除的資源，垃圾桶中的項目在保留 35 天之後，就會永久刪除。系統會在變更記錄中留下刪除記錄，點擊「還原」，就能還原資源 ( 還原帳戶需要有「編輯者」權限的使用者 )。

## 移動資源

移動資源功能可以將資源從「來源」帳戶移至「目標」帳戶，移動資源時，例如代碼 ID、資源設定、資料串流、報表資料、資源層級整合等項目會跟著移動，但是例如變更記錄則會保留在來源帳戶中。如果要移動資源，可以從「管理 > 資源 > 資源設定」的頁面，點擊「移動資源」。

![image.png](https://hackmd.io/_uploads/ry91gdwma.png)

選擇要移動到的帳戶，勾選確認變更後，點擊「開始移動」就會移動資源。

![image.png](https://hackmd.io/_uploads/Bk6Wguv7a.png)

## 查看帳戶與資源變更紀錄

只要帳戶有所更動，在「管理 > 帳戶 > 帳戶變更紀錄」裡都會看到相關資訊。

![image.png](https://hackmd.io/_uploads/SySte_w76.png)

如果是資源變更資訊，可以在「管理 > 資源 > 資源變更紀錄」裡看到相關資訊。

![image.png](https://hackmd.io/_uploads/SkNugOvQa.png)

## 開啟設定輔助程式

![image.png](https://hackmd.io/_uploads/HJWQGuvXT.png)
設定輔助程式可以讓使用者快速進行 GA4 的常用設定，只要點擊各項設定後方的「>」，就會引導至對應的設定畫面或直接進行設定，如果勾選標示完成，上方也會顯示完成的進度條。

設定輔助程式可以進行的設定
下方列出設定輔助程式可以進行的相關設定：

| 設定 | 說明 |
| -------- | -------- | 
| 收集網站和應用程式資料     | 前往「資料串流」新增資料串流收集資料( 教學參考 )。     | 
| 啟用 Google 信號     | 前往「資料設定 > 資料收集」啟用或關閉 Google 信號( 教學參考 )。     | 
| 設定轉換     | 前往「轉換」管理轉換事件( 教學參考 )。     |
| 定義目標對象     | 前往「目標對象」管理目標對象。     |
| 連結至 Google Ads    | 前往「Google Ads 連結」管理 Google Ads 的連結。  |
| 針對 GA4 轉換出價    | 確認是否使用GA4 轉換出價。  |
| 將廣告指定給 GA4 目標對象  | 確認是否將廣告指定給 GA4 目標對象。  |
| 管理使用者 | 前往「資源存取管理」管理使用者權限，或匯入通用版 GA 使用者資料。  |
| 匯入資料 | 確認是否使用匯入資料 ( 教學參考 )。  |
| 連結至 BigQuery | 前往「BigQuery 連結」管理與 BigQuery 的連結。  |
| 設定 User-ID | 確認是否使用 User-ID ( 教學參考 )。  |
| 使用 Measurement Protocol | 	確認是否使用 Measurement Protocol ( 教學參考 )。  |

# 使用測試網頁

## JS Bin

> 網址：https://jsbin.com/?html,output

開啟 JS Bin 後，將 GA4 的資料收集代碼貼到 HTML 欄位的程式碼裡，放在 </head> 之前，按下右上角的「Run width JS」就會執行網頁，隨後在 GA4 的即時監控中就能看到出現一個使用者。

![image.png](https://hackmd.io/_uploads/Hkwfd3KmT.png)

## JSFiddle
> 網址：https://jsfiddle.net/

開啟 JSFiddle 後，將 GA4 的資料收集代碼貼到 HTML 欄位的程式碼裡，按下左上角的「Run」就會執行網頁，隨後在 GA4 的即時監控中就能看到出現一個使用者。

![image.png](https://hackmd.io/_uploads/Hy9qKhYm6.png)

## CodePen
CodePen 是一個偏向「網頁作品展示」的線上編輯器，除了可以編輯 HTML、CSS 和 JavaScript，更加入社群的功能，讓程式設計師可以在平台裡分享自己的程式作品。

> 網址：https://codepen.io/

開啟 CodePen 後，將 GA4 的資料收集代碼貼到 HTML 欄位的程式碼裡，按下左上角的「Run」就會執行網頁，隨後在 GA4 的即時監控中就能看到出現一個使用者。
![image.png](https://hackmd.io/_uploads/BkjFs2tma.png)

#  啟用示範帳戶
Google Analytics 示範帳戶是功能完整的 GA 帳戶，可供任何 Google 使用者存取。其中包含一個通用版 GA 資源和兩個 GA4 資源，在 Google 官方教學裡，也是使用示範帳戶進行展示，這篇文章會介紹如何啟用 Google Analytics 示範帳戶。

## 存取示範帳戶
Google Analytics 提供了三個示範帳戶，登入並建立 Google Analytics 帳戶後 ( 參考「建立分析資源」)，點擊示範帳戶網址，示範帳戶就會自動加入自己的 GA 資源裡 ( 參考「示範帳戶」 )。

>[Google Analytics (分析) 4 資源：Google 商品網路商店 (網站資料)](https://support.google.com/analytics/answer/6367342#access&zippy=%2C%E6%9C%AC%E6%96%87%E5%85%A7%E5%AE%B9)
>[Google Analytics (分析) 4 資源：Flood-It! (應用程式和網站資料)](https://support.google.com/analytics/answer/6367342#access)
>[通用 Analytics (分析) 資源：Google 商品網路商店 (網站資料)](https://support.google.com/analytics/answer/6367342#access&zippy=%2C%E6%9C%AC%E6%96%87%E5%85%A7%E5%AE%B9)

# GTM
GTM ( Google Tag Manager ) 是 Google 提供的免費網站標籤管理工具，它可以讓網站管理者更容易的新增、編輯和刪除網站上的追蹤程式碼 ( 例如 Google Analytics、Facebook Pixel、Google Ads Conversion Tracking...等 )，GTM 可以透過網頁標籤嵌入網頁，在不需要接觸網站原始碼的情況下，就能快速管理所有網站追蹤程式碼。

![image](https://hackmd.io/_uploads/rkXLCWiQT.png)

## GTM 和 GA 的差別
GTM ( Google Tag Manager ) 和 GA ( Google Analytics ) 都是 Google 所提供的工具，但是它們的功能和使用方式有所不同。

GTM 是一個「網站標籤管理工具」，它可以讓管理者更容易地管理和部署網站上的跟蹤標籤，例如 GA 追蹤碼、Facebook Pixel...等。GTM 提供一個容器，在不需要進入網站原始碼的情況下，就能進行添加、編輯和刪除追蹤標籤。它還提供了許多進階功能，例如事件追蹤、電子商務追蹤、自定義 JavaScript 程式碼...等。

GA 是一個「分析工具」，它可以幫助管理者追蹤和分析使用者的行為和互動。GA 也可以掌握使用者的地理位置、瀏覽器類型、裝置類型、訪問時間、頁面流量...等，並進一步分析訪問者的行為，例如頁面停留時間、轉換率、漏斗分析，GA 甚至還提供許多報表和圖表，可以更有效的了解各項數據和趨勢。


|  | 功能 | 進階功能 |
| -------- | -------- | -------- |
| GTM     | 網站標籤管理工具 | 事件追蹤、電子商務追蹤、自定義 JavaScript 程式碼...   |
| GA     | 分析工具 | 掌握使用者的地理位置、瀏覽器類型、裝置類型、訪問時間、頁面流量... |

![image](https://hackmd.io/_uploads/rk0lQMs76.png)
>GTM 可以用於部署 GA 追蹤碼，而 GA 可以分析 GTM 中所設置的事件和行為。

## 使用 GTM 的好處

對於管理者而言，使用 GTM 有下列幾個好處：

* 簡化網站追蹤程式碼管理流程：管理者可以更快速地添加、刪除和更新程式碼，不需要依賴開發人員。
* 提高網站效能：GTM 可以將多個跟蹤程式碼整合成一個標籤，減少網站載入時間。
* 提供更好的追蹤功能，GTM 可以追蹤網站的各種行為和互動 ( 例如點擊、頁面滾動、表單提交...等 )。
* 追蹤碼統一管理：所有追蹤碼都可以從後台清楚呈現，維護更新非常方便。

## GTM 對行銷人員的好處

通常行銷人員並不如程式設計師一般的熟悉程式編輯，因此對於行銷人員而言，GTM 有下列幾個好處：

* 更容易管理和追蹤：GTM 還提供了許多追蹤功能 ( 事件追蹤、電子商務追蹤、網站轉換追蹤...等 )，行銷人員可以更好的了解使用者在網站上的行為和互動，並能追蹤訂單、收入和轉換率等重要指標，也可以透過網站轉換追蹤去追蹤特定目標，甚至進行 A/B 測試，比較不同版本的網站，找到最有效的方案。
* 不需要過度仰賴程式設計師：行銷人員可以透過 GTM 快速添加、編輯和刪除追蹤標籤，不需要過度依賴開發人員，節省時間和成本。

總而言之，對於行銷人員而言，透過 GTM 可以更容易去了解使用者行為和網站效能，並且可以幫助他們更有效地執行網站的改善和數據驅動的行銷策略。

## 使用GTM

> 原文參考：[開始使用 GTM](https://steam.oxxostudio.tw/category/ga4/gtm/start-use.html)

登入 GTM
使用 Google 帳號登入 GTM，登入後可以建立帳戶，或查看自己 Google 帳號下的 GA 追蹤代碼。

>GTM 網址：https://tagmanager.google.com/

![image](https://hackmd.io/_uploads/rJmQoGimT.png)

在「建立帳戶」頁籤裡，可以建立 GTM 的帳戶已變進行代碼管理，切換到「Google 代碼」頁籤，則可以管理自己 Google 帳號下擁有管理或觀察權限的 GA 追蹤代碼。

![image](https://hackmd.io/_uploads/H1AJhfj7p.png)

### 建立帳戶
要使用 GTM 必須先「建立帳戶」，該帳戶與個人帳戶不同，是專門用來管理 GTM 代碼的帳戶，點擊「建立帳戶」按鈕，簡單輸入帳戶名稱以及容器名稱 ( 通常是以網站網址作爲名稱 )。

>在 GTM 裡，會使用「容器」安裝各種不同工具與代碼，每個帳號下可以具有有多個不同的容器，每個容器裡可以建立多個不同種類的代碼，容器彼此獨立互不影響。


![image](https://hackmd.io/_uploads/HJA-pGsXa.png)

確認相關條款後，GTM 的帳戶就建立完成。

![image](https://hackmd.io/_uploads/BydB6Momp.png)

### 新增代碼
點擊左側「代碼」選項，點擊右上方的「新增」，就能在 GTM 的容器裡，新增相關的追蹤代碼。
![image](https://hackmd.io/_uploads/H1yBCMjQa.png)

點擊「代碼設定」欄位，就能選擇要加入的代碼類型，在「精選」的區域通常是 Google 自家追蹤代碼。

![image](https://hackmd.io/_uploads/S1xx1moQ6.png)

如果有其他沒有在清單裡面的代碼，就需要使用「自訂 HTML 代碼」進行部署，甚至也可以使用「自訂圖片代碼」部署像素廣告代碼
![image](https://hackmd.io/_uploads/r1ydxQs7T.png)

### 安裝 GTM 容器代碼
如果要透過 GTM 執行各種代碼的追蹤，必須要先將 GTM 的容器代碼放到網站 HTML 裡，點擊「管理」頁籤，點選「安裝 Google 代碼管理工具」。

![image](https://hackmd.io/_uploads/r1P9xmjXa.png)
點擊後，按照操作步驟，將 GTM 容器程式碼放到網頁 HTML 中指定的位置，放在 <head></head> 裡的是主要容器代碼，放在 <body></body> 裡的是在瀏覽器不支援 JavaScript 時才會啟用的代碼。

![image](https://hackmd.io/_uploads/r11ngmomT.png)


### 認識 GTM 的 Data Layer

資料層 ( Data Layer ) 是 GTM 運作的基礎，也是 GTM 用於收集網站數據的關鍵。Data Layer 屬於一種 JavaScript 物件，目的在於儲存網站中所獲得的數據，讓 GTM 可以輕鬆地檢測到並追蹤這些數據，並在特定事件發生時進行觸發，GTM 可以更準確地追蹤使用者行為並收集更豐富的數據。

觀察安裝在 HTML 裡的 GTM 程式碼，可以發現裡面出現了「dataLayer」的文字，在程式碼中的 dataLayer 代表程式變數，目的是透過變數收集數據，並藉由 push 的命令將數據傳送到 GTM，因此透過 GTM 操作自訂事件時，常常會使用dataLayer.push的語法。

# gtag.js
gtag.js 是 Google Analytics 的 JavaScript 追踪代碼，它取代了以前 的Analytics.js 代碼。gtag.js 可以直接嵌入網站代碼中，以收集使用者的行為數據，並更加精確地測量網站的流量與互動成效。
>詳細設定參考：[安裝 GA4 資料收集代碼](https://steam.oxxostudio.tw/category/ga4/info/install.html)

只要將 gtag.js 的資料收集代碼放到網頁 HTML 中指定的位置，網頁開啟後就會開始收集數據，基本的範例如下：
```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

  <!-- Google tag (gtag.js) -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXX"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-XXXXXX);
  </script>
</head>
<body>

</body>
</html>
```

## GTM 和 gtag.js 比較




功能：

| GTM | 全面的標籤管理系統，可以管理許多種不同的標籤和代碼，包括 Google Analytics、AdWords、Facebook Pixel...等。 |
| -------- | -------- | 
| gtag.js     |專門用於 Google Analytics 數據收集的輕量級追踪代碼。 |

實現方式：

| GTM | 屬於中間層的「容器」，可以在不更改網站代碼的情況下進行管理和部署作業。 |
| -------- | -------- | 
| gtag.js     |直接嵌入到網站 HTML 中的追踪代碼，不需要通過中間層容器進行管理。 |


效率：

| GTM | 因使用時需要通過中間層容器進行處理，可能會對網站速度產生輕微的影響。 |
| -------- | -------- | 
| gtag.js     |直接將資料傳遞至 Google Analytics，速度相對較快。 |

難易度：

| GTM | GTM 可能需要較長的學習曲線，去熟悉其控制介面和設定方式，且仍需學習 GA4 的用法。 |
| -------- | -------- | 
| gtag.js     |只需要知道程式碼安裝的位置和寫法，同樣也需要學習 GA4 的用法。 |


跨平台部署：

| GTM | 可以跨多個平台進行部署，包括網站、移動應用程序和 AMP 頁面等等。 |
| -------- | -------- | 
| gtag.js     |只能在網站中使用，無法應用於移動應用程序或 AMP 頁面等其他平台。 |

版本控制：

| GTM | 允許使用版本控制系統來管理和維護標籤與容器版本。 |
| -------- | -------- | 
| gtag.js     |沒有版本控制功能，所有更改都必須手動維護。 |

# 安裝 GTM 容器代碼
使用 Google 帳號登入 GTM 並進入管理帳戶，點擊「管理」頁籤，點選「安裝 Google 代碼管理工具」。

>GTM 網址：https://tagmanager.google.com/
參考：開始使用 GTM

![image](https://hackmd.io/_uploads/S1sHOxkE6.png)

點擊後，按照操作步驟，將 GTM 容器程式碼放到網頁 HTML 中指定的位置，放在 <head></head> 裡的是主要容器代碼，放在 <body></body> 裡的是在瀏覽器不支援 JavaScript 時才會啟用的代碼。

![image](https://hackmd.io/_uploads/SJYPul1E6.png)

# 新增 GA4 設定代碼
回到 GTM 帳戶，點擊左側「代碼」選項，點擊右上方的「新增」，在 GTM 的容器裡，新增相關的追蹤代碼。
![image](https://hackmd.io/_uploads/SyC5uey4T.png)

點擊「代碼設定」，選擇「Google Analytics ( 分析 )：GA4 設定」，填入 GA4 的評估 ID

![image](https://hackmd.io/_uploads/Syd-YgJ46.png)

在「觸發條件」裡設定觸發條件為「All Pages」。
![image](https://hackmd.io/_uploads/r1APKekNT.png)

完成後儲存代碼，點擊右上方的「提交」。
![image](https://hackmd.io/_uploads/BJUE9gkVp.png)

輸入這次更動的版本名稱和內容，按下「發布」，就能發布並更新 GTM 代碼內容。
![image](https://hackmd.io/_uploads/r11vqxyNp.png)

如果順利發布完成，就會出現已經上線的畫面。
![image](https://hackmd.io/_uploads/rkrq9gJVa.png)

# 檢查 GA4 代碼是否正確安裝

回到已經安裝 GTM 容器代碼的網頁，重新執行該網頁，此時從 GA4 的即時總覽裡，應該就能看到出現了使用者，這表示 GA4 已經順利安裝在 GTM 裡並正常執行收集數據。

![image](https://hackmd.io/_uploads/ryGyjxk4a.png)



參考資料:
[GA4 ( Google Analytics 4 ) 教學]( )
[2023 ithome鐵人賽 - 跟著 OXXO 一起學 GA4 ( Google Analytics 4 )系列](https://ithelp.ithome.com.tw/articles/10314237)