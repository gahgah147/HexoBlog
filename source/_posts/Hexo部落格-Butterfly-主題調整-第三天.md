---
title: Hexo部落格 - Butterfly 主題調整 第三天
date: 2024-08-07 16:52:53
tags:
 - Hexo 
 - Butterfly
categories:
  - 架站記錄
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/HJF2tD1c0.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---
# 設計Logo
![logo](https://hackmd.io/_uploads/HJF2tD1c0.png)

# 今天設定了 Nav Bar
![image](https://hackmd.io/_uploads/S11M3wkcA.png)


修改 主題配置文件  `themes/butterfly/_config.yml`
```
nav:
  logo: #image
  display_title: true
  fixed: false # fixed navigation bar
  
  
```


修改 主題配置文件  `themes/butterfly/_config.yml`
```
menu:
  首頁: / || fas fa-home
  時間軸: /archives/ || fas fa-archive
  標籤: /tags/ || fas fa-tags
  分類: /categories/ || fas fa-folder-open
  # 清單||fas fa-list:
  #   音樂: /music/ || fas fa-music
  #   電影: /movies/ || fas fa-video
  友情連結: /link/ || fas fa-link
  關於: /about/ || fas fa-heart
```

這邊設定成了中文

# 頭像

修改 主題配置文件  `themes/butterfly/_config.yml`
```
avatar:
  img: /img/logo.png
  effect: true # 頭像會一直轉圈
```

這邊換成我設計的Logo了

![image](https://hackmd.io/_uploads/HJWfAvJ9A.png)

# 社交圖標 (Social Settings)

Butterfly支持 font-awesome v6 圖標.

書寫格式 圖標名：url || 描述性文字 || color

修改 主題配置文件  `themes/butterfly/_config.yml`

```
social:
  fab fa-github: https://github.com/xxxxx || Github || "#hdhfbb"
  fas fa-envelope: mailto:xxxxxx@gmail.com || Email || "#000000"
```

這邊我設定了 github的社交連結

![image](https://hackmd.io/_uploads/HySttceqR.png)


# 頂部圖


| 配置 | 解釋 |
| -------- | -------- | 
| index_img     | 主頁的 top_img     | 
| default_top_img     | 默認的 top_img，當頁面的 top_img 沒有配置時，會顯示 default_top_img    |
 archive_img     | 歸檔頁面的 top_img  | 
 tag_img     | tag 子頁面 的 默認 top_img | 
 tag_per_img     | tag 子頁面的 top_img，可配置每個 tag 的 top_img | 
 category_img     | category 子頁面 的 默認 top_img | 
 category_per_img     | category 子頁面的 top_img，可配置每個 category 的 top_img | 

# 運行時間

修改 主題配置文件  `themes/butterfly/_config.yml`

```
runtimeshow:
  enable: true
  publish_date: 6/7/2018 00:00:00  
  ##網頁開通時間
  #格式: 月/日/年 時間
  #也可以寫成 年/月/日 時間
```

![image](https://hackmd.io/_uploads/SyQSl2xqA.png)

這樣可以顯示已執行時間

# 最新評論
修改 主題配置文件  `themes/butterfly/_config.yml`

```
# Aside widget - Newest Comments
newest_comments:
  enable: true
  sort_order: # Don't modify the setting unless you know how it works
  limit: 6
  storage: 10 # unit: mins, save data to localStorage
  avatar: true


```

這邊我依設定啟動就會顯示空白，我想可能是因為目前還沒有任何評論，所以暫時還是先設定成 false

# 總結

今天設定了Logo、Nav Bar、頂部圖、運行時間、最新評論等等的設定，發現官方文件還有更多詳細內容，超級多設定今天先暫時這樣好了，接下來的設定等改天再找時間來做
