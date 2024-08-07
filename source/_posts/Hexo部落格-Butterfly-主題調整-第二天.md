---
title: Hexo部落格 - Butterfly 主題調整 第二天
date: 2024-08-01 15:31:26
tags:
 - Hexo 
 - Butterfly
categories:
  - 架站記錄
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/HyWykput0.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

# 設定語言

修改網站配置文件 `_config.yml`

調整以下變數
```
language:
```

默認語言是 en

主題支持三種語言

default(en)
zh-CN (簡體中文)
zh-TW (繁體中文)

我們這邊改為 zh-TW (繁體中文)

# 網站資料
修改網站各種資料，例如標題、副標題和電子信箱等個人資料，請修改部落格根目錄的`_config.yml`

```
# Site
title: <部落格名稱>
subtitle: ''
description: ''
keywords:
author: <作者名稱>
language: zh-TW
timezone: ''

```

這邊需要仔細想想keywords 要設定成什麼

# 導航欄設置 (Navigation bar settings)

主題配置文件`_config.yml`中

```
nav:
  logo: #image
  display_title: true
  fixed: false # fixed navigation bar
```


logo:網站的 logo，支持圖片，直接填入圖片鏈接
display_title:是否顯示網站標題，填寫 true 或者 false
fixed:是否固定狀態欄，填寫 true 或者 false

# 菜單/目錄
修改 主題配置文件
```
Home: / || fas fa-home
Archives: /archives/ || fas fa-archive
Tags: /tags/ || fas fa-tags
Categories: /categories/ || fas fa-folder-open
List||fas fa-list:
  Music: /music/ || fas fa-music
  Movie: /movies/ || fas fa-video
Link: /link/ || fas fa-link
About: /about/ || fas fa-heart

```

例如：
```
menu:
  首頁: / || fas fa-home
  時間軸: /archives/ || fas fa-archive
  標籤: /tags/ || fas fa-tags
  分類: /categories/ || fas fa-folder-open
  清單||fa fa-heartbeat:
    音樂: /music/ || fas fa-music
    照片: /Gallery/ || fas fa-images
    電影: /movies/ || fas fa-video
  友鏈: /link/ || fas fa-link
  關於: /about/ || fas fa-heart

```

# 代碼 (Code Blocks)
Butterfly 支持6種代碼高亮樣式：

darker
pale night
light
ocean
mac
mac light
修改 主題配置文件

```
highlight_theme: light
```

# 設定搜尋功能

採用本地搜尋功能，這邊我選用hexo-generator-search來實作搜尋功能
![image](https://hackmd.io/_uploads/H1qeGFutA.png)
>https://github.com/wzpan/hexo-generator-search

## 安裝 hexo-generator-search
```
npm install hexo-generator-search --save
```

## 修改 主題配置文件  `themes/butterfly/_config.yml`
```
# Local search
local_search:
  enable: false
  # Preload the search data when the page loads.
  preload: false
  # Show top n results per article, show all results by setting to -1
  top_n_per_article: 1
  # Unescape html strings to the readable one.
  unescape: false
  CDN:

```



| 參數 | 解釋 |
| -------- | -------- |
| enable    | 是否開啟本地搜索     | 
| preload    | 預加載，開啟後，進入網頁後會自動加載搜索文件。關閉時，只有點擊搜索按鈕後，才會加載搜索文件     |
| top_n_per_article    | 	匹配的文章結果，默認顯示最開始的 1段結果     |
| unescape    | 	將 html 字符串解碼為可讀字符串   |
| CDN    | 	搜索文件的 CDN 地址（默認使用的本地鏈接）   |

這邊實測設定後右上角會出現這個搜尋的圖案
![image](https://hackmd.io/_uploads/HJnYm2OFC.png)

然後點擊就可以進行搜尋
![image](https://hackmd.io/_uploads/SJE2Q2dY0.png)

測試真的可以搜尋到文章
![image](https://hackmd.io/_uploads/rkJb42dYC.png)


# 評論功能設定

修改 主題配置文件  `themes/butterfly/_config.yml`
```
comments:
  # Up to two comments system, the first will be shown as default
  # Choose: Disqus/Disqusjs/Livere/Gitalk/Valine/Waline/Utterances/Facebook Comments/Twikoo
  use: Valine,Disqus
  text: true # Display the comment name next to the button
  # lazyload: The comment system will be load when comment element enters the browser's viewport.
  # If you set it to true, the comment count will be invalid
  lazyload: true
  count: true # Display comment count in top_img
  card_post_count: false # Display comment count in Home Page
```
	

| 參數 | 解釋 |
| -------- | -------- | 
| use     | 使用的評論（請注意，最多支持兩個，如果不需要請留空）注意：雙評論不能是 Disqus 和 Disqusjs 一起，由於其共用同一個 ID，會出錯     | 
| text     | 是否顯示評論服務商的名字   | 
| lazyload     | 是否為評論開啟lazyload，開啟後，只有滾動到評論位置時才會加載評論所需要的資源（開啟 lazyload 後，評論數將不顯示） | 
| count     | 是否在文章頂部顯示評論數
livere、Giscus 和 utterances 不支持評論數顯示 | 
| card_post_count     | 是否在首頁文章卡片顯示評論數
gitalk、livere 、Giscus 和 utterances 不支持評論數顯示 | 

以上變數是在 2024-08-01 參考 Butterfly 官方配置說明文件設定的，最新內容建議可以參考官方網站https://butterfly.js.org/posts/ceeb73f/#%E8%A9%95%E8%AB%96


這邊修改過後實測真的有評論區可以留言了^^
![image](https://hackmd.io/_uploads/SyEFBn_t0.png)

# 分享

## 通用設置
這邊Butterfly設定內建是使用 sharejs
![image](https://hackmd.io/_uploads/HynyBhdKA.png)
>https://github.com/overtrue/share.js/


修改 主題配置文件  `themes/butterfly/_config.yml`

```
sharejs:
  enable: true
  sites: facebook  #想要顯示的內容  ,twitter,wechat,weibo,qq
```

這邊因為我只有facebook 所以這樣更改

目前暫時先設定通用設置，官網還有其他留言板設定像是Disqus、livere (來必力)、gitalk、 Valine、Waline、Utterances、Facebook Comments、Twikoo、Giscus、remark42、artalk 可以參考，有很多的選擇。

# 在線聊天

## 通用設置

修改 主題配置文件  `themes/butterfly/_config.yml`

```
# Chat Button [recommend]
# It will create a button in the bottom right corner of website, and hide the origin button
chat_btn: true
```

為了不影響訪客的體驗，主題提供一個`chat_hide_show`配置
設為`true`後，使用工具提供的按鈕時，只有向上滾動才會顯示聊天按鈕，向下滾動時會隱藏按鈕。

修改 `主題配置文件`

```
# The origin chat button is displayed when scrolling up, and the button is hidden when scrolling down
chat_hide_show: true
```

:::info
如果使用工具自帶的聊天按鈕，按鈕位置可能會遮擋右下角圖標，請配置`rightside_bottom`調正右下角圖標位置
:::

設定之後在這邊會顯示有聊天功能
![image](https://hackmd.io/_uploads/r1zpTnOKC.png)

## 設定crisp
![image](https://hackmd.io/_uploads/HyWykput0.png)
>https://crisp.chat/en/

註冊 crisp 帳號
![image](https://hackmd.io/_uploads/Sk1zJauKA.png)

設定樣式
![image](https://hackmd.io/_uploads/B1Xc1pdK0.png)

註冊完成後可以取得這個資料
![image](https://hackmd.io/_uploads/SkxRJ6_KC.png)

找到需要的網站ID 進行設定
```
# crisp
# https://crisp.chat/en/
crisp:
  enable: true
  website_id: xxxxxxxx
```

實測設定完可以成功留言
![image](https://hackmd.io/_uploads/Sk-fMa_YR.png)

也可以成功在後台看到這邊的訊息，也可以回應。
![image](https://hackmd.io/_uploads/HkC8fTOYA.png)

# 總結

今天設定了Butterfly 主題的代碼樣式、搜尋功能、評論功能、分享、跟在線聊天設定，官方網站還有好幾項，這部分我覺得之後再來找時間設定好了