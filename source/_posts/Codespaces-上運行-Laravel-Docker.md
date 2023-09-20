---
title: Codespaces 上運行 Laravel Docker
date: 2023-09-06 11:37:49
tags: Laravel Docker Github Codespaces
---
# Codespaces 上運行 Laravel Docker

![](https://hackmd.io/_uploads/H1iYrdrRh.png)

## 前言
目前因為想要練習 Laravel，所以看到一篇在 Github Codespaces 上運行Laravel 的文章所以來實作，並將結果放在[這邊](https://github.com/nalson0219/laravel-docker)

## 1.創建 Github Repository 從 Laravel Docker 範例
![](https://hackmd.io/_uploads/rJuObwrCh.png)
>https://github.com/rakibdevs/laravel-docker
點擊 Use this template

## 2.建立 Codespace 

![](https://hackmd.io/_uploads/B1EEEDrRh.png)

## 3. Build Docker Container

下載必要的套件，並根據Dockerfile 建立 Docker image
```
$ docker compose build
```

完成後可以執行以下指令開啟 Docker container:
```
$ docker-compose up -d
```

![](https://hackmd.io/_uploads/BJxTEPS03.png)

## 4.下載 Laravel
```
$ sudo chmod 777 src/
$ docker compose exec php composer create-project --prefer-dist laravel/laravel .
```

Now copy .env.example to .env by following this command:

```
$ cp src/.env.example src/.env
```

更新 database 設定檔
```
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=1234
```

## 5 Run other esential commands 

```
$ docker compose exec php php artisan storage:link
$ docker compose exec php chmod -R 777 storage bootstrap/cache
$ docker compose exec php php artisan migrate:refresh

```

## 6. 產生　APP_KEY
```
$ cd src 
$　composer install
$ php artisan key:generate
```

接下來點擊 codespace 下方這個圖案就能開啟網頁
![](https://hackmd.io/_uploads/SkyVGdr0n.png)
>移動到 3399 port 的本機位置 ctrl + 按一下 就能看到 laravel 畫面

![](https://hackmd.io/_uploads/SJjtMur03.png)


參考文章: https://rakibdevs.medium.com/github-codespaces-code-on-the-go-with-laravel-in-docker-container-c31f42212e42

規劃後續練習參考教學文章: https://ithelp.ithome.com.tw/articles/10219573