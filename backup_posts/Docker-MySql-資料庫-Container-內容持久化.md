---
title: Docker -  MySql 資料庫 Container 內容持久化
date: 2024-01-29 10:10:59
tags: 
    - Docker
    - MySql
    - Docker compose
---

# 前言

這篇是我看到 [[Docker] 如何讓 MySql 資料保存，不會隨著容器而消失](https://blog.mewo.com.tw/docker/docker-%E5%A6%82%E4%BD%95%E8%AE%93-mysql-%E4%BF%9D%E5%AD%98%EF%BC%8C%E4%B8%8D%E6%9C%83%E9%9A%A8%E8%91%97%E5%AE%B9%E5%99%A8%E8%80%8C%E6%B6%88%E5%A4%B1/?fbclid=IwAR29_1eWXWRUYc8w_pUzs0b8oK_1XACRTVlcqPiz60QJipYG-etzRzvJCpU)
跟著實作的紀錄

# Container 內容持久化

開發的時候 Docker 扮演一個重要的角色，我們能透過 docker-compose 快速的啟用一些需要使用到 App服務. 此篇就是要來介紹，如果透過 Volume 的方式，將 MySql Container 內容持久化。


# Docker 指令介紹

根據 dokcer-compose .yaml 啟動
```
docker-compose up
```
停止 contanier
```
docker-compose stop
```

移除 container
```
docker-compose down
```

使用 docker 指令的時候，很會透過 docker-compose down 來關閉 container，這時候就會發現存放在 mysql 中的 資料，在下一次啟動 container 的時候就會全部消失。

# 如何解決 docker-compose down 資料也不會消失
在 yaml 中新增 Volumes，Volumes 會將資料存放於 Container 之外，範例中就是會把資料存放於 db_data 這個資料夾

```
volumes:
      - ./db_data:/var/lib/mysql
```

此時使用 docker-compose down 關閉 container

再透過 docker-compose up 就會發現 mysql 的資料還存在

# Yaml 設定檔內容
```
version: "3.9"

services:
  mydb:
    image: mysql:5.7
    volumes:
      - ./db_data:/var/lib/mysql
    restart: always
    ports:
      - 3306:3306
    environment:
      MYSQL_ROOT_PASSWORD: somewordpress
      MYSQL_DATABASE: mydatebae
      MYSQL_USER: root
      MYSQL_PASSWORD: password
networks:
    LAN:
        driver: bridge
        name: mysql_LAN
```