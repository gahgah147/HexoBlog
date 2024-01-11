---
title: Nuxt3 運行在Docker 上
date: 2024-01-11 16:30:33
tags:
    - Nuxt 3
    - Docker
---

# 前言
這邊在練習Nuxt 3時想要運行在Docker 上，所以就找到這篇文章
[將 Nuxt3 發布至 docker 中，Dockerfile 看這裡就對了](https://www.ruyut.com/2023/04/deploy-nuxt3-to-docker-with-dockerfile.html)
實際測試可以成功，所以記錄一下過程

# Dockerfile
```
# 使用 node 長期支援版
FROM node:lts-alpine

# 設定工作目錄
WORKDIR /app

# 複製 package.json 和 package-lock.json 至工作目錄
COPY package*.json ./

# 依照指定版本安裝依賴
RUN npm ci

# 複製所有
COPY . .

# 建立生產版本
RUN npm run build

# 暴露的連接埠
EXPOSE 3000

# 啟動應用程式
CMD ["node", ".output/server/index.mjs"]
```

# 打包

```
docker build -t my-nuxt-app .
```

![image](https://hackmd.io/_uploads/r1pUUXp_T.png)


# 啟動
```
docker run -d --name nuxt-app -p 3000:3000 my-nuxt-app
```
![image](https://hackmd.io/_uploads/SkGuLmT_T.png)

![image](https://hackmd.io/_uploads/SJX9I7pOa.png)
> 結果成功執行