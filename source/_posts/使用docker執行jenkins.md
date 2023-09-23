---
title: 使用docker執行jenkins
date: 2023-09-23 15:22:33
tags: docker jenkins
---

# 使用docker執行jenkins

## 拉取docker hub上的jenkins image
```
docker pull jenkinsci/blueocean
```

## 運行docker 鏡像命令

```
docker run \
  -u root \
  --rm \
  -d \
  -p 8081:8080 \
  -p 50000:50000 \
  -v jenkins-data:/root/docker/jenkins_home \
  -v $PWD/allure-results:/allure-results \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkinsci/blueocean
```

![](https://hackmd.io/_uploads/HJaG4-2y6.png)
> 執行後可以看見docker 運行的狀況

## 打開8081 port，登入jenkins首頁
![](https://hackmd.io/_uploads/SyJLEWnJp.png)
http://localhost:8081/

## 進入容器取得管理員密碼

點擊docker
![](https://hackmd.io/_uploads/rytAVWhkT.png)

![](https://hackmd.io/_uploads/BydZSbnyT.png)
>點擊 Terminal 

輸入 cat /var/jenkins_home/secrets/initialAdminPassword
可以拿到密碼

## 選擇插件，安装jenkins，等待即可完成
![](https://hackmd.io/_uploads/HJlSPZ21a.png)
設定系統管理員帳號後就可以使用了