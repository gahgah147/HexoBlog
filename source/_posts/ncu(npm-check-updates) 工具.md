---
title: ncu(npm-check-updates) 工具
date: 2023-09-20 17:58:59
tags: 
 - node.js
---

## 前言
在使用 Node.js 開發時，版本問題和各種相依性問題常常導致每次在執行 `npm install` 後，專案啟動時出現錯誤，這真的是非常煩惱。不過，在看到這篇文章 [無痛更新專案中的 npm 相依套件](https://blog.marsen.me/2022/09/08/2022/how_to_npm_update_more_smoothly/) 後，我發現原來有一個名為 `npm-check-updates` 的工具可以使用，這真的解決了許多問題。

## 檢查過時的版本
首先，我們可以使用 `npm outdated` 來檢查專案中有哪些套件是過時的：

```sh
npm outdated
```

這個命令會列出所有需要更新的套件及其版本資訊。

![image](https://hackmd.io/_uploads/ByrKVUTVR.png)
>畫面中可以看到我的部落格專案中有4個套件需要更新了。

## 安裝 ncu (npm-check-updates) 工具
接下來，我們來介紹 `npm-check-updates` 工具，它可以幫助我們更輕鬆地管理和更新專案中的 npm 相依套件。首先，全域安裝 `npm-check-updates`：

```sh
npm install -g npm-check-updates
```



## 執行更新
安裝完成後，我們可以使用 `ncu` 命令來檢查並更新相依套件。使用以下命令來更新專案中的套件版本：

```sh
ncu -u
```

![image](https://hackmd.io/_uploads/ByjbBU6ER.png)


這個命令會自動更新 `package.json` 中的相依套件版本到最新版本。接著，我們只需要重新安裝相依套件：

```sh
npm install
```

![image](https://hackmd.io/_uploads/HyXErI6EA.png)


## 結論
通過 `npm-check-updates` 工具，我們可以更輕鬆地管理專案中的相依套件，確保它們始終保持最新，從而避免因為過時的套件版本而引發的各種問題。

參考來源: [無痛更新專案中的 npm 相依套件](https://blog.marsen.me/2022/09/08/2022/how_to_npm_update_more_smoothly/)

希望這篇文章能夠幫助你更好的管理專案中的 npm 相依套件。如果有任何問題或需要進一步的幫助，歡迎在留言區提出。

