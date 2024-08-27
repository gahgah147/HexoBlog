---
title: 使用ATOM 和 RSS 格式把Hexo內容搬到 Wordpress 上的流程
date: 2024-08-27 14:14:13
tags:
    - Hexo
    - Wordpress
    - ATOM
    - RSS
categories:
    - 架站記錄
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/r15501oiR.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

# ATOM 和 RSS 的簡介

**RSS（Really Simple Syndication）** 和 **ATOM** 都是用來分發網路內容的標準格式。它們的主要目的是幫助使用者訂閱和自動獲取網站更新，無需手動訪問網頁。這對於部落格或新聞網站非常有用，因為它能讓讀者即時接收新文章的通知。

## RSS

![image](https://hackmd.io/_uploads/SyJICyojR.png)

RSS 是一種 XML 格式，常見的版本為 RSS 2.0。使用 RSS，網站可以將最新的內容發布到訂閱者的 RSS 閱讀器中。讀者可以使用 RSS 閱讀器訂閱 RSS Feed，當網站更新時，內容會自動推送到他們的裝置上。

## ATOM

![image](https://hackmd.io/_uploads/r15501oiR.png)

ATOM 是另一種 XML 格式，功能類似於 RSS，但有更多可自定義的元素。ATOM 被認為是 RSS 的改進版，因為它具有更好的格式和結構，適合用於更複雜的內容發佈需求。

## 如何使用
用戶只需將網站提供的 RSS 或 ATOM 連結添加到他們的 RSS 閱讀器中即可。對於網站管理員來說，提供 RSS 或 ATOM Feed 是吸引讀者的重要方式之一，能有效提升內容曝光率。

# 產出 Hexo 的 RSS 摘要格式文章檔案
RSS 摘要格式可以方便 WordPress 導入，在 _config.yml 檔案中調整設定

在 Hexo 中，如果要生成 RSS 摘要（也稱為 RSS Feed），你需要安裝一個 RSS 插件並進行相應設定。以下是詳細步驟：

## 安裝 RSS 插件

### 方法一 : `hexo-generator-feed`
首先，你需要安裝 `hexo-generator-feed` 插件。打開終端機並在你的 Hexo 專案目錄下執行以下命令：

```bash
npm install hexo-generator-feed --save
```

![image](https://hackmd.io/_uploads/H13fgKHjR.png)

### 方法二 : `hexo-migrator-rss`
後來有看到這一篇hexo官方說明文件
https://hexo.io/zh-tw/docs/migration

裡面有提到使用 `hexo-migrator-rss` 這個工具來進行轉移

首先，安裝 hexo-migrator-rss 外掛。
```
$ npm install hexo-migrator-rss --save
```

一旦外掛安裝完成，執行下列指令，從 RSS 轉移所有文章。 source 可以是檔案路徑或網址。

```
$ hexo migrate rss <source>
```
這邊我最終是使用 hexo-generator-feed 產生的

## 配置 `_config.yml`

安裝完成後，你需要在 Hexo 的主配置檔 `_config.yml` 中添加 RSS 的相關設定。以下是我設定的配置：

```yaml
feed: 
	type:
    - atom
    - rss2
  path:
    - atom.xml
    - rss2.xml
	limit: 0
	hub:	
	content: true
```

{% note info simple %}
變數內容說明

- **enable**：啟用或停用此插件。預設為啟用。
- **type**：Feed 的類型。可以是 `atom` 或 `rss2`。指定為 `['atom', 'rss2']` 以輸出這兩種類型。（預設：`atom`）
- **path**：Feed 的路徑。如果指定了多種類型，路徑必須按照類型的順序排列。（預設：`atom.xml/rss2.xml`）
- **limit**：Feed 中顯示的最大文章數量。（設為 `0` 或 `false` 以顯示所有文章）
- **hub**：PubSubHubbub hub 的 URL。（如果不使用，請保持空白）
- **content**：（可選）設為 `true` 時，會在 Feed 中包含整篇文章的內容。
- **content_limit**：（可選）摘要內容的字數上限。僅在 `content` 設為 `false` 且沒有自訂文章描述時使用。
- **content_limit_delim**：（可選）如果使用 `content_limit` 來縮短文章內容，僅在達到字數上限前的最後一個指定分隔符處截斷內容。預設不使用。
- **order_by**：Feed 的排序方式。（預設：`-date`，即按日期倒序）
- **icon**：（可選）自訂 Feed 圖示。預設使用主設定中的 email 對應的 Gravatar。
- **autodiscovery**：自動發現 Feed 的設定。（預設：`true`）許多主題已提供此功能，如果需要停用，可能需要調整主題設定。
- **template**：自訂模板路徑。這個檔案將用來生成 Feed 的 XML 檔案，預設模板為 `atom.xml` 和 `rss2.xml`。即使插件設定為輸出多種 Feed 類型，也可以只指定一個自訂模板。

{% endnote %}

依照這樣以上設定執行產生時，會生成下面兩種內容的網址:
https://gahgah147.github.io/atom.xml
https://gahgah147.github.io/rss2.xml


## 生成靜態文件

設定完成後，執行以下命令生成靜態文件：

```bash
hexo generate
```
或是

```bash
hexo g
```

生成後，RSS 文件會自動保存在你的 public 資料夾中，路徑是 `public/rss.xml`（或者你在配置中設定的路徑）。

實際上我平常部屬到github.io網頁上的流程是這樣，一樣可以更新到RSS 或是ATOM
```
hexo clean && hexo deploy
```

## 驗證 RSS

在瀏覽器中打開 `http://你的網站域名/atom.xml` 或是 `http://你的網站域名/rss2.xml`（或你設定的路徑）檢查 RSS 是否正確生成。

例如我這邊產生的是
`https://gahgah147.github.io/atom.xml`和`https://gahgah147.github.io/rss2.xml`

我這邊成功產生的RSS畫面
![image](https://hackmd.io/_uploads/rysfWFSsC.png)
>https://gahgah147.github.io/atom.xml


# 將文章導入 WordPress

我後來是使用 FeedWordPress 這個套件來匯入

![image](https://hackmd.io/_uploads/BknKO6YjA.png)

安裝完成之後在 New source 這邊輸入生成的  `http://你的網站域名/atom.xml`
![image](https://hackmd.io/_uploads/H1uou6FsA.png)


然後在這邊點選 Update Now
![image](https://hackmd.io/_uploads/S1j1YatiA.png)

以下是我成功匯入的Hexo 部落格文章
![image](https://hackmd.io/_uploads/rJWAOpqi0.png)

# 為什麼這邊Wordpress 的標題點進去之後都會導引到hexo的文章連結?

當使用 RSS 將 Hexo 的文章同步到 WordPress 時，如果標題點進去後會導引到 Hexo 的文章連結，這通常是因為 RSS Feed 中的文章連結 (link 標籤) 指向的是原始網站（即 Hexo 部署的站點）。

原因分析： RSS Feed 的結構中，每篇文章都有一個 link 標籤，這個標籤是用來指定該文章的原始連結。在你將 RSS Feed 匯入到 WordPress 時，這些連結會保留原本的目標（即 Hexo 部落格的 URL），因此在 WordPress 中點擊標題後會導向原始的 Hexo 網頁。

使用 FeedWordPress 套件時，默認情況下匯入的文章會保留 RSS Feed 中的原始連結，因此點擊標題時會跳轉到 Hexo 的文章連結。然而，FeedWordPress 提供了一些選項，可以讓你調整這種行為。

你可以按照以下步驟來修改：

1. **設定 FeedWordPress 將文章匯入為 WordPress 本地內容：**

   - 在 WordPress 後台，進入「FeedWordPress」的設定頁面。
   - 在「Feeds & Updates」中，找到並點選你已經設定的 RSS Feed。
   - 在該 Feed 的詳細設定中，找到「Posts & Links」部分。
![image](https://hackmd.io/_uploads/B1Nz31os0.png)
   - 會看到一個選項「Permalinks point to:」，將此選項設置為「The local copy on this website」而不是「The original source of the syndicated item」。

![image](https://hackmd.io/_uploads/HJFUhyoj0.png)
>這邊應該要改為The local copy on this website

   這樣設置後，FeedWordPress 會將匯入的文章設置為本地的 WordPress 文章，並且點擊標題後將導向 WordPress 上的文章頁面，而非 Hexo 原始連結。

2. **手動修改匯入的文章：**

   如果希望更加自定義某些文章的行為，也可以在文章匯入後手動編輯文章中的連結。

透過這些設定，就可以讓 FeedWordPress 將 RSS Feed 的文章匯入為 WordPress 本地內容，避免跳轉到 Hexo 的文章頁面。


# 總結 

這樣就可以成功同步 Hexo 的文章到 WordPress 部落格文章上，有些細節還是要花點時間測試調整之後才知道如何改動，這些功能實際大約花了我3天時間，大家如果之後有需要把hexo部落格搬家可以參考看看，同時也可以考慮保留兩邊的部落格，因為自動化導入RSS的功能我覺得其實蠻方便的，另外Hexo加上github的架設其實不用額外花錢維護。

