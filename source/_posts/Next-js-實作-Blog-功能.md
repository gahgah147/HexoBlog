---
title: Next.js 實作 Blog 功能
date: 2023-09-20 17:45:20
tags: Next.js Blog React.js
---


# 前言

這篇是參考 鐵人賽 系列文章 「從零開始打造炫砲個人部落格」系列簡介 - Modern Next.js Blog 系列 實作的紀錄，實際操作上有遇到很多問題，但大致上跟著git修改的部分調整都可以修改成功。

這篇的解說很清楚，彙整的也很完整，推薦跟著教學文章操作。

使用的前端技術


| 功能 | Next.js 工具 |
| -------- | -------- | 
|  UI 樣式  |   Tailwind CSS    | 
|  多語系   |next-i18next     | 
|  SEO meta tags  |next-seo   | 
|  指令面板  | kbar   | 
|  留言系統  | giscus   | 
|  換頁進度條  | nprogress   | 
|  更扎實的 JavaScript  | TypeScript   | 
|  統一程式碼格式  | ESLint, Prettier   | 
|  Markdown/MDX 文章處理  | Contentlayer   | 
|  網站託管  | Vercel   | 


Next.js：現代全端框架
Vercel：網站託管
Contentlayer：Markdown/MDX 文章處理

參考文章: https://ithelp.ithome.com.tw/articles/10291960

# 官方文件

https://nextjs.tw/learn/foundations/about-nextjs/what-is-nextjs



# 環境設定

建立專案
```
pnpm create next-app --typescript
```

啟動 Next.js 專案
```
pnpm dev
```
