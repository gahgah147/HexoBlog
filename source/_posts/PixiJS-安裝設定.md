---
title: PixiJS 安裝設定
date: 2024-01-09 14:58:13
tags:
    - PixiJS
    - 2022 iTHome 鐵人賽
---

# 前言

這篇文章是我在 2022 iTHome 鐵人賽看到 [PixiJS青銅玩家 系列](https://ithelp.ithome.com.tw/users/20152526/ironman/5741) 文章做的一個紀錄。

# PixiJS 是什麼?
PixiJS 是一個用於創建2D網頁遊戲和互動內容的快速輕量級渲染引擎。它是一個使用JavaScript編寫的開源庫，提供了簡單而強大的API，使開發者能夠輕鬆地創建高性能的瀏覽器內遊戲和互動應用。

# 安裝PixiJS

## npm
```
npm i pixi.js
```

## 下載JS文件

https://github.com/pixijs/pixijs/releases

可以從以上PixiJS的主要發布頁面中，找到各種版本的PixiJS，現在最新版本是v8.0.0-rc.2，往下滑到Asset的部份，可以看見很多個文件（如下圖），其中最重要的就是pixi.js跟pixi.min.js，這兩個檔案都可以使用。

![image](https://hackmd.io/_uploads/By8t1DcO6.png)
> https://github.com/pixijs/pixijs/releases/tag/v8.0.0-rc.2


## CDN

https://cdnjs.com/libraries/pixi.js/4.5.5

![image](https://hackmd.io/_uploads/r1n7XwcuT.png)
>https://cdnjs.com/libraries/pixi.js

{% note info simple %}


.js檔與.min.js檔案的區別

|   | .js檔 | .min.js檔 |
| -------- | -------- | -------- |
|優點    | 可讀性高，比較好觀察、修改    | 1. 減小體積，使傳輸變快 2. 可以使JS防止被偷窺、竊取|
|缺點   | 體積較大，傳輸較慢   |可讀性差|
{% endnote %}

# 執行

在HTML執行 
```
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>範例</title>
</head>
<body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pixi.js/4.8.5/pixi.min.js" ></script>
    <script>
        let type = "WebGL"
        if(!PIXI.utils.isWebGLSupported()){
        type = "canvas"
        }

        PIXI.utils.sayHello(type)
    </script>
</body>
</html>
```

當我們執行上述程式碼後，假如PixiJS成功可以運作時，以Chrome來說就可以在DevTools中的console裡面看見底下的圖片：
![image](https://hackmd.io/_uploads/BywBnwc_p.png)
