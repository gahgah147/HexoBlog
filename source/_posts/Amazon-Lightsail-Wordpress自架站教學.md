---
title: Amazon Lightsail + Wordpress自架站教學
date: 2024-05-10 15:42:22
tags:
    - AWS
    - AWS Lightsail
    - Wordpress
---

# Amazon Lightsail + Wordpress自架站教學

這篇是我看到youtube 毛巾的教學影片跟著操作的紀錄
https://youtu.be/ufmCi7pMgKU?si=DG0bd_pwWzb20Lj5

# Amazon 

註冊AWS 帳號

# Amazon Lightsail

![image](https://hackmd.io/_uploads/rJDljZsfR.png)
> 點選Create Instance 創建 instance

![image](https://hackmd.io/_uploads/rkvLoZszA.png)
>伺服器地區選擇比較近的東京

![image](https://hackmd.io/_uploads/SkrjobiGA.png)
>選擇Wordpress

![image](https://hackmd.io/_uploads/SylBn-ozC.png)
>這邊選擇最便宜的5塊錢方案

![image](https://hackmd.io/_uploads/S1FdnZofC.png)
>取名 這邊我取NalsonBlog

大概等個兩分鐘就建置好了

![image](https://hackmd.io/_uploads/Bk2anbizR.png)
>建置完成的畫面


![image](https://hackmd.io/_uploads/rywaTZifC.png)
>這邊可以看到我們成功建立好的WordPress 網頁模板

# 進入WordPress 更改後台設定

https://docs.aws.amazon.com/zh_tw/lightsail/latest/userguide/log-in-to-your-bitnami-application-running-on-amazon-lightsail.html

上面這篇文章教學很詳細

![image](https://hackmd.io/_uploads/SkaRezozR.png)
點選 連結圖示 SSH 用戶端視窗會開啟，如以下範例所示。

![image](https://hackmd.io/_uploads/H1xmWfiGA.png)

請輸入如下命令以擷取預設應用程式密碼：
```
cat bitnami_application_password
```

## 登入WordPress後台管理
![image](https://hackmd.io/_uploads/ryNaWMsM0.png)

可以先將語言改成中文
![image](https://hackmd.io/_uploads/By9mzMoGR.png)

再來可以選擇喜歡的佈景主題
![image](https://hackmd.io/_uploads/HkfvfMiz0.png)
