---
title: LinkedIn Redesign Nuxtjs3
date: 2024-01-09 17:45:13
tags:
    - Builder.io
    - Figma
    - Nuxt 3
    - tailwindcss
---

# LinkedIn Redesign Nuxtjs3

# 準備Figma 設計稿
https://www.figma.com/file/7EeOLaEuMD7cNIsXTM8vp0/LinkedIn-Redesign-UI-Kit-(Community)?node-id=0%3A1&mode=dev

# 建立Nuxt.js 3 專案

npx nuxi@latest init nuxt-linkedIn-redesign

# 把每一頁透過 Builder.io 產生程式

![image](https://hackmd.io/_uploads/B1ILUFqO6.png)

Framework 選擇 Vue
![image](https://hackmd.io/_uploads/ryyKLY5Op.png)

# 新增 profile page 元件
```
npx nuxi add page profile
```
調整 app.vue 檔案
```
<template>
  <div>
    <NuxtPage />
  </div>
</template>
```
{% note info simple %}

另外需要安裝 tailwindcss
{% endnote %}
![image](https://hackmd.io/_uploads/B1jHtt5da.png)

成果:
![image](https://hackmd.io/_uploads/BkJ_tF9ua.png)
>http://localhost:3000/profile

專案repo:
https://github.com/gahgah147/nuxt-linkedIn-redesign