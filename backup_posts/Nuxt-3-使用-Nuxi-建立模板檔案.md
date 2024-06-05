---
title: Nuxt 3 使用 Nuxi 建立模板檔案
date: 2023-12-14 16:53:41
tags:
  - 前端框架
  - Vue
  - Nuxt 3
  - 2023 iTHome 鐵人賽
  - nuxi
---

# 前言

這篇文章是我在 2023 iTHome 鐵人賽看到 Ryan 大大 寫的 [Nuxt 3 實戰筆記 系列](https://ithelp.ithome.com.tw/users/20152617/ironman/6959) 文章做的一個紀錄，我之前也都有看到發表Nuxt 相關的文章，寫得都很用心仔細很值得跟著練習，我覺得最特別的是 Nuxt 新的 DevTools功能 

# 使用 nuxi 快速建立模板檔案

建立檔案的指令格式如下：
```
npx nuxi add <TEMPLATE> <NAME> [--cwd] [--force]
```
| 變數 | 功能 | 
| -------- | -------- | 
| TEMPLATE | 指定要產生的檔案模板類型，目前支援專案內常會使用到的 component、page 與伺服器 api 等。 |
| NAME     | 填寫檔案名稱，也可以以路徑串接，來建立子資料夾中的檔案     | 
| --cwd     | 指定專案起始目錄，預設為 .。    | 
| --force   | 如果檔案存在，強制覆蓋檔案。    | 


## 建立路由頁面 - nuxi add page 
舉個例子，建立一個 about 路由頁面：
```
npx nuxi add page about
```

產生出的檔案 ./pages/about.vue 內容如下，預設會有一個模板提供給使用者快速進行後續開發。
```
<script lang="ts" setup></script>

<template>
  <div>
    Page: foo
  </div>
</template>

<style scoped></style>

```

![image](https://hackmd.io/_uploads/ByRF-EuLp.png)

產生出的檔案 ./pages/category/[id].vue

```
npx nuxi add page "category/[id]"
```

![image](https://hackmd.io/_uploads/r1jfoEdUp.png)


## 建立 composable - nuxi add composable
```
npx nuxi add composable foo
```

建立 ./composables/foo.ts 檔案
![image](https://hackmd.io/_uploads/B1_vsVuUa.png)

![image](https://hackmd.io/_uploads/HJKLjVO8a.png)

## 建立 layout - nuxi add layout
```
npx nuxi add layout custom
```

建立 ./layouts/custom.ts 檔案
![image](https://hackmd.io/_uploads/BJjciEOL6.png)

![image](https://hackmd.io/_uploads/SyN3iVO8T.png)

## 建立元件 - nuxi add component 
```
npx nuxi add component TheHeader
# 等價
npx nuxi add component TheHeader --mode "client|server"
```
![image](https://hackmd.io/_uploads/HyNo0V_UT.png)

建立 ./components/TheHeader.vue 檔案

在建立元件時，可以添加修飾參數 --mode "client|server"、--client、--server，來建立客戶端或伺服器端的元件。

```
npx nuxi add component TheFooter --client
# 等價
npx nuxi add component TheFooter --mode client
```
![image](https://hackmd.io/_uploads/HkQTC4OIp.png)

建立 ./components/TheFooter.client.vue 檔案


```
npx nuxi add component TheFooter --server
# 等價
npx nuxi add component TheFooter --mode server
```

![image](https://hackmd.io/_uploads/ByMZyBuUa.png)

建立 ./components/TheFooter.server.vue 檔案

![image](https://hackmd.io/_uploads/HJO71rd86.png)


## 建立插件 - nuxi add plugin

```
npx nuxi add plugin analytics
```

插件的建立，同樣也可以添加修飾參數 --mode "client|server"、--client、--server。
![image](https://hackmd.io/_uploads/rJsSJHuIp.png)

建立 ./plugins/analytics.ts 檔案

![image](https://hackmd.io/_uploads/SkaPkBdLp.png)

## 建立路由中間件 - nuxi add middleware

```
npx nuxi add middleware auth
```
![image](https://hackmd.io/_uploads/ByEBlrdLT.png)
建立路由中間件 ./middleware/auth.ts 檔案。

建立時可以添加修飾參數 --global 用以建立通用的全域路由中間件，舉例來說，建立 ./middleware/always-run.global.ts 檔案。

```
npx nuxi add middleware always-run --global
```
![image](https://hackmd.io/_uploads/rkwvlSu8a.png)



![image](https://hackmd.io/_uploads/B1_KxBu8T.png)


## 建立伺服器 API - nuxi add api

```
npx nuxi add api hello
```

![image](https://hackmd.io/_uploads/S1ehZruUT.png)

建立伺服器 API 處理程式 ./server/api/hello.ts。

建立時可以添加修飾參數 --method post、--method delete 等用以建立不同請求方法的 API，舉例來說，建立 ./server/api/items.post.ts 檔案。

```
npx nuxi add api items --method post
```

![image](https://hackmd.io/_uploads/r1_abrdU6.png)


>支援請求方法的參數有 connect, delete, get, head, options, patch, post, put 或 trace

![image](https://hackmd.io/_uploads/BkK1MBOL6.png)


# 小結
nuxi add 指令最重要的是透過指令建立的模板，你不需要在擔心要在哪一個目錄建立，使用的約定是什麼，Nuxt CLI 將會幫你處理好並建立在對應的目錄，在使用 nuxi add 指令建立的模板檔案時，因為 Nuxt 內置了 TypeScript，所以你會發現模板實作多以 TypeScript 的方式來定義，不過也不影響尚未導入 TypeScript 的專案，僅需要把一些 TypeScript 的關鍵字移除及重新命名檔案名稱後，就可以接續檔案內的實作範例來做開發，對於開發上還是能提升不少的速度。

# 心得
這邊觀察下來我認為算是一個框架規範，每個人使用的話就都會產生固定格式的東西