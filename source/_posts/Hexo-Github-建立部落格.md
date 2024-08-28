---
title: Hexo + Github 建立部落格
date: 2023-08-31 14:12:53
tags: 
 - Node.js 
 - Hexo 
 - Github
categories:
  - 架站記錄
---


# Hexo + Github 建立部落格
## 為什麼想要架設 Blog

身為一個工程師，不知不覺也工作了四年，工作上使用的套件不管是前端、後端、框架都越來越多，所以想記錄自己曾使用過的套件，要用的時候可以很快的查到。

* 建立自己的工具箱
* 累積屬於自己在技術專業知識品牌
* 可以作為作品集展示
* 另外想紀錄什麼都可以寫上去

## 為什麼選 Hexo 

* 可以免費放在Github 上
* 可以選好看的主題
* 支援 Markdown  (因為之前有在用 hackmd 紀錄文件)

查找到感覺最完整的架設教學文章是這篇 
>https://chanchandev.com/note/Hexo/hexo-introduction/2335841689/#%E7%82%BA%E4%BB%80%E9%BA%BC%E8%A6%81%E6%9E%B6%E8%A8%AD-Blog

所以就決定跟著來一起嘗試架設Blog

## 環境設定

### NodeJs
![](https://hackmd.io/_uploads/Hygizoop62.png)
>https://nodejs.org/en

{% note info simple %}
有用Node js 推薦也一起使用 nvm，因為有時候常常會遇到版本問題
![](https://hackmd.io/_uploads/ryAznjaT3.png)
>https://github.com/coreybutler/nvm-windows/releases

選擇 nvm-setup 開始下載
{% endnote %}

### Git
![](https://hackmd.io/_uploads/H1vIss66n.png)
>https://git-scm.com/

### Visual Studio Code (vs code)
![](https://hackmd.io/_uploads/HJ4toipph.png)
>https://code.visualstudio.com/

## Hexo 設定

安裝 Hexo
```
npm install -g hexo-cli
```

建立 Hexo 專案
```
hexo init hexoblog

```
會產生一個 hexoblog 資料夾
```
cd hexoblog
```

啓動 Hexo 的伺服器
```
hexo server
```

接下來用瀏覽器打開 http://localhost:4000 就可以看到Hexo 的效果
![](https://hackmd.io/_uploads/HkTGRjap3.png)

## 要怎麼在在文章上放圖片呢
查看了各種教學後來決定先把文章圖片放在 HackMD上，再採用設定公開表的方式分享照片
![](https://hackmd.io/_uploads/SyLWU7JR3.png)


## 選擇主題樣式

### 使用 Butterfly 主題樣式
另外可以選擇其他樣式

![](https://hackmd.io/_uploads/SydzvSNCn.png)
> https://hexo.io/themes/

因為是我參考 ChanChanDev 圈圈工程師 寫的[這篇文章](https://chanchandev.com/note/Hexo/hexo-introduction/2335841689/#%E9%81%B8%E6%93%87%E4%B8%BB%E9%A1%8C%E6%A8%A3%E5%BC%8F) 實作的，比較起來我也感覺 Butterfly 這個主題最好看

#### 方法一 
下載 Butterfly 主題及配件
```
git clone -b master https://github.com/jerryc127/hexo-theme-butterfly.git themes/Butterfly
npm install cheerio@0.22.0 --save
npm install hexo-renderer-pug hexo-renderer-stylus --save
```
下載完成後，在 .\Desktop\mywebsite\githubBlog\themes 裡，會看見多了個名叫 Butterfly 的 folder。

更改主題:開啓這個文件 .\githubBlog\_config.yml，把主題改為 Butterfly
```
theme: Butterfly
```

參考官方教學:https://butterfly.js.org/posts/21cfbf15/#%E5%AE%89%E8%A3%9D

另外這個方式會遇到以下問題
![image](https://hackmd.io/_uploads/HkxXDItSC.png)

這個警告表示你正在將另一個 git 儲存庫添加到當前的 git 儲存庫中。也就是說在我們原本的部落格git專案裡面還有別的git專案

可以用以下方式解決
```
git rm -f --cached themes/Butterfly
git submodule add https://github.com/jerryc127/hexo-theme-butterfly.git themes/Butterfly
```

第一個命令會從索引中刪除 themes/Butterfly，第二個命令則將其重新添加為子模組。這樣做後，Git 應該能正確處理 themes/Butterfly。

#### 方法二 (這方法有個問題就是在 themes/ 底下沒有Butterfly 會沒辦法調整設置)
安裝 Butterfly 主題樣式
```
npm i hexo-theme-butterfly

```
安裝 Butterfly 所需的套件
```
npm install hexo-renderer-pug hexo-renderer-stylus --save

```

開啓 _config.yml 檔，更改 theme 設定
```
theme: butterfly
```

在本機端啓動 Hexo 的伺服器，就可以看到套用了 Butterfly 主題樣式的網站囉！

```
hexo server
```

![](https://hackmd.io/_uploads/By-YOrEC3.png)

### 應用 Butterfly 主題

#### Front-matter 設定

Front-matter 是 markdown 文件最上方以 --- 分隔的區域，用於指定個別檔案的變數。

Page Front-matter 用於頁面配置
Post Front-matter 用於文章頁配置
>如果標注`可選`的參數，可根據自己需要添加，不用全部都寫在 markdown 裏

##### 調整頁面配置: Page Front-matter
開啓這個文件 .\githubBlog\scaffolds\page.md，改成下面這樣子：
```
---
title:
date:
type: （tags,link,categories這三個頁面需要配置）
comments: (是否需要顯示評論，默認true)
description:
top_img: (設置頂部圖)
mathjax:
katex:
---


```

更多細節可以參考官方文件:https://butterfly.js.org/posts/dc584b87/#Post-Front-matter

##### 調整文章頁配置: Post Front-matter
開啓這個文件 .\githubBlog\scaffolds\post.md，改成下面這樣子：
```
---
title:
date:
tags:
categories:
keywords:
description:
top_img: （除非特定需要，可以不寫）
comments  是否顯示評論（除非設置false,可以不寫）
cover:  縮略圖
toc:  是否顯示toc （除非特定文章設置，可以不寫）
toc_number: 是否顯示toc數字 （除非特定文章設置，可以不寫）
copyright: 是否顯示版權 （除非特定文章設置，可以不寫）
mathjax:
katex:
hide:
---
```

更多細節可以參考官方文件:https://butterfly.js.org/posts/dc584b87/#Post-Front-matter

#### 創建標籤頁
輸入以下命令：
```
hexo new page tags

```
開啓這個文件 .\githubBlog\source\tags\index.md，把 type 設定為 "tags"
```
---
title: 標籤
date: 2024-06-12 00:00:00
type: "tags"
---

```

這邊是產生的標籤頁效果 https://<username>.github.io/tags/
![image](https://hackmd.io/_uploads/S1uihFLH0.png)

#### 創建分類頁

輸入以下命令：
```
hexo new page categories

```
開啓這個文件 .\githubBlog\source\categories\index.md，把 type 設定為 "categories"
```
---
title: 分類
date: 2024-06-12 00:00:00
type: "categories"
---
```

#### 創建友情連結頁
輸入以下命令：
```
hexo new page link
```
開啓這個文件 .\githubBlog\source\link\index.md，把 type 設定為 "link"
```
---
title: 友情連結
date: 2024-06-12 00:00:00
type: "link"
---

```

開啓這個文件（如沒有就自己新增）.\githubBlog\source\_data\link.yml，內容如下：


## Hexo 常用指令

初始化專案 / 建立專案資料夾
```
hexo init [資料夾名稱]
```
建立一篇新的文章，若標題包括空格，請用引號括起來
```
hexo new [layout] <文章標題>
```
在本機端啓動伺服器，預設是 http://localhost:4000/
```
hexo server
```

## 指令新增第一篇文章
```
hexo new post "我的第一篇文章 By Hexo"
```

會發現在 source 的 _posts 的資料夾多了一個 我的第一篇文章-By-Hexo.md 的檔案。

```
---
title: 我的第一篇文章 By Hexo
date: 2021-03-07 17:15:57
tags:
---

# 我的第一篇文章的標題
hihihi ~ 你好～ 我是第一篇文章的內容～
在這裏可以用 `Markdown` 語法撰寫

```

##  部署 Deploy 設定

### 申請 Github 帳號
![](https://hackmd.io/_uploads/rk0N6SV0h.png)
>https://github.com

### 設定 repository

新增一個public 的 repository，並且命名爲 githubusername.github.io

例如：你的 github 使用者帳號爲 abc_xyz 那麼這個 repository 的名稱就會是 abc_xyz.github.io

### 安裝部署外掛

```
npm install hexo-deployer-git --save
```

### 調整_config.yml 設定
```
# Deployment
## Docs: https://hexo.io/docs/one-command-deployment
deploy:
  type: git
  repo: git@github.com:abc_xyz/abc_xyz.github.io.git # 貼上剛剛複製的 Github Repository 網址
  branch: master # 預設分支名稱
  message:
```

### 執行以下指令將 Hexo 產生的網站內容上傳到 Github 

```
hexo clean && hexo deploy
```
用瀏覽器在網址輸入上述的網址 `https://<username>.github.io`，就可以看到 Hexo 的網站順利地架在 Github 的 Page 上了

![](https://hackmd.io/_uploads/rk5SyU40n.png)


## 常用的 Hexo 命令
### 清理快取文件（db.json）和生成的文件（public）
```
hexo clean
```

### 生成靜態文件
```
hexo g
```

### 啟動本地伺服器
```
hexo s       
```

### 部屬到github上
```
hexo d
```

### 生成完成後再部署

```
hexo g -d
```

### 生成完成後再部署時提交的訊息
```
hexo g -d -m "message"
```

-m "message": 在部署時提交的訊息（通常用於版本控制系統，如 Git）。

### 建立新的文章
```
hexo new <post-title>
```

### 建立新的頁面
```
hexo new page <page-title>
```

### 總攬
```
hexo clean   # 清理快取文件（db.json）和生成的文件（public）
hexo g       # 生成靜態文件
hexo s       # 啟動本地伺服器
hexo d       # 部屬到github上
hexo g -d    # 生成完成後再部署
hexo g -d -m "message"      # 生成完成後再部署時提交的訊息
hexo new <post-title>       # 建立新的文章
hexo new page <page-title>  # 建立新的頁面
```
