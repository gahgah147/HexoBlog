---
title: 使用 Vercel 部署 NestJS 程式
date: 2024-01-17 16:15:12
tags:
    - Vercel
    - Nestjs
    - 後端
    - CI/CD
---

# 前言 

這邊我是參考這篇 [一文教会你如何使用 Vercel 部署你的 NestJS 应用](https://www.levenx.com/article/how-to-deploy-your-nestjs-application-using-vercel#heading-4) 教學文章跟著操作的紀錄

# Nestjs 專案增加 vercel 設定文件

在跟目錄下新增 vercel.json 文件

```
{
  "version": 2,
  "builds": [
    {
      "src": "src/main.ts",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "src/main.ts",
      "methods": [
        "GET",
        "POST",
        "PUT",
        "DELETE",
        "PATCH"
      ]
    }
  ]
}
```

# Nestjs 專案上傳到github

![image](https://hackmd.io/_uploads/rkGZLZHtT.png)

# 授權给 vercel
點選右上角頭像展開選單
![image](https://hackmd.io/_uploads/ByXTLWBKT.png)

選擇setting
![image](https://hackmd.io/_uploads/SywhLZBt6.png)

選擇 config
![image](https://hackmd.io/_uploads/B1Ps8ZBtp.png)

# Vercel 平台新增專案

這邊找到剛剛建立的repo 點選import
![image](https://hackmd.io/_uploads/rkP6w-HY6.png)

修改執行命令，並且執行 deploy

部屬完成
![image](https://hackmd.io/_uploads/ryEjdZSKp.png)

