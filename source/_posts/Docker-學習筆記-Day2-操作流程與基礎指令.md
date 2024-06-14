---
title: Docker 學習筆記 Day2 - 操作流程與基礎指令
date: 2024-06-11 17:43:37
tags:
    - Docker
categories:
    - Docker 學習筆記
---
# Docker 學習筆記 Day2 - 操作流程與基礎指令

# 執行範例

## 複製練習專案檔案

練習專案程式碼:https://github.com/sixeyed/diamol 
![image](https://hackmd.io/_uploads/BktHImSrA.png)

使用以下指令進行複製檔案
```
git clone https://github.com/sixeyed/diamol.git
```

## 執行 Hello World Docker 範例
```
docker container run diamol/ch02-hello-diamol
```

這邊我遇到這個問題
![image](https://hackmd.io/_uploads/B13mwQBBC.png)

這邊代表要啟用WSL2，要在 Docker desktop 的 Setting -> Resources 把 
Enable integration with additional distros: 這邊的 Ubuntu 選項打開，
然後按 Apply & restart
![image](https://hackmd.io/_uploads/r11KvXSBC.png)

調整過後執行成功的畫面
![image](https://hackmd.io/_uploads/H1swMVrHR.png)

# 容器是什麼?
容器（Container）是一種虛擬化技術，用於將應用程式及其依賴環境打包在一起，以確保應用程式可以在任何計算環境中一致地運行。容器利用操作系統的虛擬化功能，提供輕量級、便攜且獨立的運行環境。

## 容器的優點

1. **輕量化**：容器與傳統虛擬機相比，更加輕量，不需要啟動一個完整的操作系統，因此啟動速度快，占用資源少。
2. **可移植性**：容器打包了應用程式及其所有依賴，確保應用程式在開發、測試和生產環境中運行一致。
3. **隔離性**：容器之間相互隔離，確保一個容器內的問題不會影響其他容器，提升應用程式的安全性和穩定性。
4. **高效性**：容器利用操作系統的共享資源功能，比虛擬機更加高效，適合高密度部署。

# 透過 Docker 互動模式執行容器

```
docker container run --interactive --tty diamol/base
```

- `docker container run`: 告訴 Docker 執行一個容器。
- `--interactive` 或 `-i`: 表示在容器中啟動互動模式，使得可以與容器中的應用進行互動。
- `--tty` 或 `-t`: 分配一個 pseudo-TTY（虛擬終端），這樣就可以在容器內進行命令行操作。
- `diamol/base`: 是要運行的 Docker 映像的名稱。在這個例子中，指定了一個名為 `diamol/base` 的映像。

![image](https://hackmd.io/_uploads/ryOskqrSC.png)
> 執行後對連接到容器中的終端對話視窗

# 在容器中託管 (host) 一個網站

```
docker container run --detach --publish 8088:80 diamol/ch02-hello-diamol-web
```

- `--detach` 或 `-d`: 表示在背景運行容器，即使容器啟動後，終端仍然可用。
- `--publish 8088:80` 或 `-p 8088:80`: 將容器的端口 80 映射到主機的端口 8088。這樣，當您訪問主機的 8088 端口時，流量將被轉發到容器的 80 端口。
- `diamol/ch02-hello-diamol-web`: 是要運行的 Docker 映像的名稱。在這個例子中，指定了一個名為 `diamol/ch02-hello-diamol-web` 的映像。

若不確定是否有這個映像檔可以到  https://hub.docker.com/ 查詢

![image](https://hackmd.io/_uploads/r18d_9HBA.png)
>這邊可以發現 diamol/ch02-hello-diamol-web 跟書本範例上的名稱不太一樣


![image](https://hackmd.io/_uploads/rkaXF9HBA.png)
成功執行結果

![image](https://hackmd.io/_uploads/ryMst5rr0.png)

點選畫面中的 8088:80 可以看到網頁結果

![image](https://hackmd.io/_uploads/rkVkc5rrR.png)
>http://localhost:8088/


# Docker 基本指令

**`docker run`**: 執行一個容器。
**`docker build`**: 使用 Dockerfile 構建一個新的映像。
**`docker pull`**: 從 Docker 鏡像倉庫下載一個映像。
**`docker push`**: 將一個映像推送到 Docker 鏡像倉庫。
**`docker start`**: 啟動一個停止的容器。
**`docker stop`**: 停止正在運行的容器。
**`docker restart`**: 重啟一個容器。
**`docker rm`**: 刪除一個或多個容器。
**`docker rmi`**: 刪除一個或多個映像。
**`docker ps`**: 列出正在運行的容器。
**`docker ps -a`**: 列出所有的容器，包括停止的容器。
**`docker images`**: 列出本地的所有映像。
**`docker exec`**: 在正在運行的容器中執行命令。
**`docker logs`**: 查看容器的日誌。
**`docker inspect`**: 查看容器或映像的詳細信息。
**`docker-compose`**: 使用 Docker Compose 管理多容器應用程序。

這些是 Docker 中的一些基本指令，用於管理容器、映像和其他相關資源。

## 結尾

以上就是第二天的練習內容，今天實際執行了Hello World的範例跟host一個網站、另外還有一些Docker 基本指令，如果有任何問題或需要進一步的幫助，歡迎在留言區提出。
