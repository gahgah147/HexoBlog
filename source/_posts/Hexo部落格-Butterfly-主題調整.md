---
title: Hexo部落格 - Butterfly 主題調整
date: 2024-06-13 15:33:01
tags:
 - Hexo 
 - Butterfly
categories:
  - 架站記錄
keywords:
description:
top_img:
comments:
cover:
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---
# Hexo部落格 - Butterfly 主題調整

本文介紹如何在 Hexo 部落格中使用 Butterfly 主題，以及如何進行一些常見的調整。包括檔案結構介紹、主題顏色調整、樣式修改、Tags位置調整等。

## 目錄
- [檔案結構介紹](#檔案結構介紹)
- [主題顏色調整](#主題顏色調整)
- [樣式 (css相關的項目)](#樣式-css相關的項目)
- [Tags：移至文章上方](#tags移至文章上方)
- [版權框內的字句](#版權框內的字句)
- [為文章加密](#為文章加密)
  - [使用方法](#使用方法)
- [右下角按鈕：改為默認顯示，按才隱藏](#右下角按鈕改為默認顯示按才隱藏)
- [右下角新增【到最底部】按鈕](#右下角新增到最底部按鈕)
- [文章網址名稱、文章位置整理](#文章網址名稱文章位置整理)
- [生成 sitemap - atom.xml](#生成-sitemap---atomxml)
- [製作 404 page](#製作-404-page)

## 檔案結構介紹

### Hexo 相關檔案
```
.
├── public            // 執行 hexo generate 後，輸出的靜態網頁
├── scaffolds         // 模板。Hexo會根據scaffold來建立新文章/新頁面
├── scripts           // 存放自定義 js 文件
├── source        
|   ├── _drafts       // 草稿文章
|   ├── _posts        // 發佈文章
|   ├── link          // 友情連結
|   ├── categories    // 分類頁面
|   └── tags          // 標籤頁面
├── themes            // Hexo 主題文件，Butterfly 主題的檔案就在裡面
├── _config.yml       // 整個 Blog 的配置
└── package.json      // 已下載的插件及其版本 version no.
```

### Butterfly 主題的檔案
```
.
└──themes
   └── Butterfly
       ├── languages    // 主題語言字眼
       ├── layout       // pug 文件，後會渲染成 html
       ├── scripts      // js 文件
       ├── source        
       |   ├── css      // styl 文件，後會渲染成 css
       |   ├── img      // 主題配置用到的圖片
       |   └── js       // js 文件
       └── _config.yml  // Butterfly 主題配置
```

## 主題顏色調整

如果想進階修改主題顏色的話，可以修改 `.\themes\Butterfly\source\css\var.styl` 文件。

## 樣式 (css相關的項目)

如果想修改特定元素的樣式，例如字體大小、字體顏色、背景顏色、tag 外觀樣式、border style 、button、動畫效果等等，可以修改 layout 檔案 `.\themes\Butterfly\source\css\_layout`。

例如想修改黑夜模式的顏色組合，就到這裡修改： `.\themes\Butterfly\source\css\_mode\darkmode.styl`。

## Tags：移至文章上方

在 `.\themes\Butterfly\layout\post.pug` 這個文件中，搜尋下面這段，把它移到至 `block content` 的下一行插入。

```pug
.tag_share
  if (theme.post_meta.tags)
    .post-meta__tag-list
      each item, index in page.tags.data
        a(href=url_for(item.path)).post-meta__tags #[=item.name]
```

## 版權框內的字句

在 `.\themes\Butterfly\languages` 這裡面的 yml 檔裡進行修改。

## 為文章加密

在 GitBash 中輸入以下命令來安裝插件：

```bash
npm install --save hexo-blog-encrypt
```

### 使用方法

在需要加密的文章頭加上 `password` 和 `message` (可選):

```markdown
title: 測試 - 為文章加密
date: 2024-06-13 14:05:02
tags:
    - Hexo
    - 架站
categories: [架站記錄, 技巧]
password: test123
message: 試試加密，這篇的密碼是 test123
---

恭喜成功解密！

這裡是文章內容。
```

## 右下角按鈕：改為默認顯示，按才隱藏

右下角的黑夜模式、繁簡轉換、字體大小按鈕原本是默認隱藏的，需按設定按鈕才會顯示。想要改成默認顯示，按設定按鈕收起來，再按再彈出來。

修改 `.\themes\Butterfly\source\css\_layout\rightside.styl` 文件：

```styl
#rightside
  position: fixed
  right: -38px
  bottom: 40px
  opacity: 0
  transition: all .5s

  #rightside-config-hide
    transform: translate(0, 0)

  .rightside-in
    animation: rightsideIn .3s

  .rightside-out
    animation: rightsideOut .3s
    transform: translate(30px, 0) !important

  & > div
    & > i,
    & > a,
    & > div
      display: block
      margin-bottom: 2px
      width: 30px
      height: 30px
      background-color: $light-blue
      color: $white
      text-align: center
      text-decoration: none
      font-size: 16px
      line-height: 29px
      cursor: pointer

      &:hover
        background-color: $ruby

  #rightside_config
    i
      animation: avatar_turn_around 2s linear infinite

  #mobile-toc-button
    display: none

@media screen and (max-width: $bg)
  #rightside
    #mobile-toc-button
      display: block

@keyframes rightsideOut
  0%
    transform: translate(0, 0)

  100%
    transform: translate(30px, 0)

@keyframes rightsideIn
  0%
    transform: translate(30px, 0)

  100%
    transform: translate(0, 0)
```

## 右下角新增【到最底部】按鈕

除了文章 (post) 頁面，其他頁面都加上【到最底部】按鈕在最

右下方。

1. 在 `.\themes\Butterfly\layout\includes\rightside.pug` 中，於最底添加這兩行：

```pug
if !is_post()
  i.fa.fa-arrow-down#go-down(title=_p("rightside.back_to_bottom") aria-hidden="true")
```

2. 在 `.\themes\Butterfly\source\js\main.js` 中，添加以下代碼：

```js
// go down smooth scroll
$('#go-down').on('click', function () {
  scrollTo('footer')
})
```

## 文章網址名稱、文章位置整理

所有發佈的文章自動生成在 `.\source\_posts` 這個資料夾。但排序雜亂無章，而且部署到 GitHub 後，所有文章都散佈在第一層，很亂。希望文章原檔案按照日期排序，但不影響文章網址名稱（在網址中不顯示日期），並且在 GitHub 自動生成一個名叫 post 的資料夾裝放所有文章原檔案。

方法是在 `./config.yml` 裡，把這兩選項更改成以下：

```yaml
permalink: post/:title/  # 在 GitHub 自動生成一個名叫 post 的資料夾裝放所有文章原檔案
new_post_name: post/:year-:month-:day-:title/:title.md  # 在你的電腦儲存位置，會達成以上 tree structure 那樣
```

## 生成 sitemap - atom.xml

在 bash 中輸入以下命令來安裝插件：

```bash
npm install hexo-generator-feed --save
```

在 `./config.yml` 裡，添加以下配置：

```yaml
feed:
  type: atom
  path: atom.xml
  limit: 10
  hub:
  content:
  content_limit: 250
  content_limit_delim: ' '
  order_by: -date
  icon: icon.png
  autodiscovery: true
  template:
```

## 製作 404 page

把你想遇到 404 時轉跳的頁面命名為 `404.html`，放在 `.\source` 資料夾裡。

然後在 `./config.yml` 裡，設定以下內容：

```yaml
skip_render:
  - 404.html
  - README.md
  - robots.txt
```

由於還創建了不需渲染的 `README.md` 和 `robots.txt`，所以把它們也設定在 skip_render 底下。

## 結尾
以上就是進階Butterfly相關設定，如果有任何問題或需要進一步的幫助，歡迎在留言區提出。
