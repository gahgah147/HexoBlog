---
title: ncu(npm-check-updates) 工具
date: 2023-09-20 17:58:59
tags: node.js
---

# 前言
使用 node.js 開發時版本問題各種相依性問題導致每次在 npm install 完，開起來都會爆炸，真的是很煩
後來看到這篇文章 [無痛更新專案中的 npm 相依套件](https://blog.marsen.me/2022/09/08/2022/how_to_npm_update_more_smoothly/)
發現原來有  npm-check-updates 工具可以使用，真的是解決了很多問題。

# 檢查過舊的版本
```
npm outdated
```

# ncu(npm-check-updates) 工具
```
npm install -g npm-check-updates
```
執行更新
```
ncu -u
```

參考來源: https://blog.marsen.me/2022/09/08/2022/how_to_npm_update_more_smoothly/