---
title: Docker 學習筆記 Day3 - 建立自己的Docker 映像檔
date: 2024-06-14 13:25:57
tags:
    - Docker
categories:
    - Docker 學習筆記
keywords:
description:
top_img:
comments:
cover:
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---
# Docker 學習筆記 Day3 - 建立自己的Docker 映像檔

# Docker Hub 是什麼？

![image](https://hackmd.io/_uploads/rJL5dXYHC.png)
> https://hub.docker.com/

Docker Hub 是一個線上託管服務，專門用來存儲和分發 Docker 映像檔。它提供了一個集中式平台，讓開發者能夠輕鬆分享、搜尋和下載各種應用程式的 Docker 映像檔。Docker Hub 提供了多種功能，例如公共和私有儲存庫、自動建置、Webhooks 及其他整合服務。以下是 Docker Hub 的一些主要功能：

1. **公共和私有儲存庫**：你可以選擇將映像檔設為公共或私有。公共儲存庫可供所有人自由訪問，而私有儲存庫則只有你指定的用戶才能存取。

2. **自動建置**：你可以將 Docker Hub 與 GitHub 或 Bitbucket 等原始碼儲存庫連接，當你的程式碼有變動時，Docker Hub 可以自動建置映像檔。

3. **Webhooks**：當映像檔有更新時，Webhooks 可以通知你指定的應用程式或服務，方便進行自動化流程。

4. **團隊和組織管理**：你可以創建和管理團隊，設定不同成員的訪問權限，適合協作開發和大型專案管理。

像是昨天就有在 Docker Hub 上面查詢到範例的映像檔

## 如何使用 Docker Hub

### 1. 註冊 Docker Hub 帳號
首先，你需要一個 Docker Hub 帳號，可以到 [Docker Hub 官方網站](https://hub.docker.com/) 註冊。

Docker Hub 註冊頁面
![image](https://hackmd.io/_uploads/ryd75QYSR.png)
>https://hub.docker.com/signup

### 2. 登入 Docker Hub
使用以下命令在終端機中登入 Docker Hub：
```bash
docker login
```
輸入你的 Docker Hub 使用者名稱和密碼。

### 3. 上傳映像檔到 Docker Hub
假設你已經有一個本地的 Docker 映像檔，你可以使用以下命令將映像檔推送到 Docker Hub：
```bash
docker tag your-image-name your-dockerhub-username/your-repository-name:tag
docker push your-dockerhub-username/your-repository-name:tag
```

### 4. 從 Docker Hub 下載映像檔
你可以使用以下命令從 Docker Hub 下載並運行映像檔：
```bash
docker pull your-dockerhub-username/your-repository-name:tag
docker run -d your-dockerhub-username/your-repository-name:tag
```


### 實例：建立並上傳自己的 Docker 映像檔

1. **建立 Dockerfile**
在專案目錄中建立一個 `Dockerfile`，內容如下：
```Dockerfile
# 使用官方的 Node.js 映像檔作為基礎映像檔
FROM node:14

# 建立應用目錄
WORKDIR /usr/src/app

# 複製 package.json 和 package-lock.json
COPY package*.json ./

# 安裝應用程式依賴
RUN npm install

# 複製所有檔案到工作目錄
COPY . .

# 暴露應用埠
EXPOSE 8080

# 定義啟動指令
CMD ["node", "app.js"]
```

2. **建置 Docker 映像檔**
在終端機中執行以下命令來建置映像檔：
```bash
docker build -t your-dockerhub-username/your-repository-name:tag .
```

3. **推送映像檔到 Docker Hub**
```bash
docker push your-dockerhub-username/your-repository-name:tag
```


## 使用來自 Docker Hub 的映像檔

使用以下指令抓取 web-ping 應用程式的容器映像檔
```
docker image pull diamol/ch03-web-ping
```


像是`diamol/ch03-web-ping`這個映像檔就可以在 Docker Hub 上面看到
![image](https://hackmd.io/_uploads/HyELj7FB0.png)
>https://hub.docker.com/r/diamol/ch03-web-ping

執行結果 如下
![image](https://hackmd.io/_uploads/H1NzsXYS0.png)

依照結果這邊來看，會發現這邊有很多個檔案
```
Using default tag: latest
latest: Pulling from diamol/ch03-web-ping
e7c96db7181b: Pull complete
bbec46749066: Pull complete
89e5cf82282d: Pull complete
5de6895db72f: Pull complete
f5cca017994f: Pull complete
78b9b6c949f8: Pull complete
Digest: sha256:2f2dce710a7f287afc2d7bbd0d68d024bab5ee37a1f658cef46c64b1a69affd2
Status: Downloaded newer image for diamol/ch03-web-ping:latest
docker.io/diamol/ch03-web-ping:latest
```

這個機制稱為 映像層(image layers)。 也就是每個image 映像黨都是由很多個映像層組合而成的。

## 利用映像檔執行一個容器


當你執行以下命令時：

```bash
docker container run -d --name web-ping diamol/ch03-web-ping
```

這行命令的目的是啟動一個新的 Docker 容器，並且有以下幾個特點：

1. **`docker container run`**：
   - 這是 Docker 的一個命令，用於運行一個新的容器。

2. **`-d`**：
   - `-d` 代表 "detached mode"，這表示容器會在後台執行，不會鎖定終端機。

3. **`--name web-ping`**：
   - `--name` 參數用來給容器指定一個名稱。在這個例子中，容器的名稱被設為 `web-ping`。這樣在未來的操作中，你可以通過這個名稱來引用這個容器，而不是使用自動生成的容器 ID。

4. **`diamol/ch03-web-ping`**：
   - 這是要運行的映像檔的名稱。`diamol` 是映像檔的名稱空間或組織名稱，`ch03-web-ping` 是具體的映像檔名稱。這個映像檔可能已經在你的本地系統上，如果沒有，Docker 會從 Docker Hub 或其他配置的映像檔庫拉取這個映像檔。

總結來說，這行命令會在後台啟動一個名為 `web-ping` 的容器，該容器基於 `diamol/ch03-web-ping` 映像檔。這使得你可以在不影響當前終端機工作的情況下執行並管理這個容器。


![image](https://hackmd.io/_uploads/r1dXkNtB0.png)
>執行結果

這個容器開啟後會反覆不斷的ping 作者的部落格(blog.sixeyed.com)
![image](https://hackmd.io/_uploads/S1yJe4KrA.png)
>可以在 Docker desktop 上觀察

另外也可以使用以下指令查看
```
 docker container logs web-ping
```

## 刪除現有容器
使用以下指令刪除剛剛練習的 `web-ping` 容器
```
docker rm -f web-ping
```

## 設定環境變數: --env

```bash
docker container run --env TARGET=google.com diamol/ch03-web-ping
```

這行命令的目的是啟動一個新的 Docker 容器，並且有以下幾個特點：

1. **`docker container run`**：
   - 這是 Docker 的一個命令，用於運行一個新的容器。

2. **`--env TARGET=google.com`**：
   - `--env` 參數用來設置環境變數。在這個例子中，`TARGET` 是環境變數的名稱，而 `google.com` 是這個變數的值。這個環境變數會傳遞給容器內運行的應用程式，應用程式可以根據這個環境變數來決定其行為。例如，這裡假設應用程式會針對 `google.com` 執行一些操作。

3. **`diamol/ch03-web-ping`**：
   - 這是要運行的映像檔的名稱。`diamol` 是映像檔的名稱空間或組織名稱，`ch03-web-ping` 是具體的映像檔名稱。這個映像檔可能已經在你的本地系統上，如果沒有，Docker 會從 Docker Hub 或其他配置的映像檔庫拉取這個映像檔。

總結來說，這行命令會啟動一個基於 `diamol/ch03-web-ping` 映像檔的容器，並且將 `TARGET` 環境變數設置為 `google.com`。這使得容器內的應用程式可以利用這個環境變數來決定它要針對 `google.com` 執行的操作。

![image](https://hackmd.io/_uploads/BJYQmNtS0.png)
>執行結果

程式會一直執行，按 `Ctrl` + `C` 可以結束應用程式。

環境變數對於Docker而言來說是一個非常重要的機制，能夠視情況朴整不同的設定值，例如
在專案開發中的開發環境(DEV)、測試環境(QAT)、正式環境(PRD)


![image](https://hackmd.io/_uploads/r1ssNEFrA.png)
>圖片來源:https://ryanisagoodguy.blogspot.com/2020/02/devteststageprod.html

# Dockerfile

到 `diamol/ch03/exercises/web-ping` 資料夾中
```
cd diamol/ch03/exercises/web-ping
code .
```

![image](https://hackmd.io/_uploads/BytkL4YHR.png)

可以看到 `Dockerfile`範例內容如下
```
FROM diamol/node

ENV TARGET="blog.sixeyed.com"
ENV METHOD="HEAD"
ENV INTERVAL="3000"

WORKDIR /web-ping
COPY app.js .

CMD ["node", "/web-ping/app.js"]
```


這個 Dockerfile 目的是建立一個自訂的 Docker 映像檔，該映像檔基於 `diamol/node` 映像檔，並設定一些環境變數、工作目錄、複製應用程式檔案以及設定容器啟動時的指令

```Dockerfile
FROM diamol/node
```
這行指令指定了基礎映像檔，`diamol/node`。這表示你的自訂映像檔將基於這個映像檔來構建，繼承其所有的內容和設置。

```Dockerfile
ENV TARGET="blog.sixeyed.com"
ENV METHOD="HEAD"
ENV INTERVAL="3000"
```
這些指令設置了三個環境變數：
  - `TARGET`：指定要 Ping 的目標 URL，預設值為 `blog.sixeyed.com`。
  - `METHOD`：指定 HTTP 請求的方法，預設值為 `HEAD`。
  - `INTERVAL`：指定 Ping 的間隔時間，單位為毫秒，預設值為 `3000` (3秒)。
  這些環境變數可以在容器內的應用程式中使用，允許你在不修改程式碼的情況下更改這些設置。

```Dockerfile
WORKDIR /web-ping
```
這行指令設置了容器內的工作目錄為 `/web-ping`。接下來的所有指令（如 `COPY` 和 `CMD`）都會相對於這個目錄進行操作。

```Dockerfile
COPY app.js .
```
這行指令將本地檔案系統中的 `app.js` 檔案複製到容器內的當前工作目錄 (`/web-ping`) 中。這樣做是為了確保 `app.js` 在容器運行時可以被訪問和執行。

```Dockerfile
CMD ["node", "/web-ping/app.js"]
```
這行指令指定了當容器啟動時要執行的命令。這裡使用 `node` 命令來運行 `app.js` 檔案。`CMD` 指令會在容器啟動時執行一次，並保持容器運行。


# 建立映像檔

使用以下命令來建立一個 Docker 映像檔

```
docker image build --tag web-ping .
```

`docker image build`：這是 Docker 的一個命令，用來建立 Docker 映像檔。

`--tag web-ping`：這個參數用來為建立的映像檔指定一個標籤。在這個例子中，映像檔的標籤被設置為 `web-ping`。這個標籤可以用來識別這個映像檔，後續可以使用這個標籤來運行容器或者上傳到 Docker Hub 等映像檔庫中。

`.`：這表示 Docker 命令應該在當前目錄下查找 Dockerfile。Dockerfile 是一個包含了建立映像檔所需指令的文本文件，通常放在項目的根目錄下。

總結來說，這個命令的目的是在當前目錄下的 Dockerfile 中定義的指令基礎上建立一個名為 web-ping 的 Docker 映像檔。這個映像檔可以通過標籤 web-ping 來識別。

![image](https://hackmd.io/_uploads/Hkzs_VYHC.png)
>成功建立畫面

# 列出映像檔

使用以下指令來列出所有w字母開頭的映像檔

```
docker image ls 'w*'
```

![image](https://hackmd.io/_uploads/HytGY4KHA.png)
>執行結果

# Docker 映像層是什麼?

在 Docker 中，映像檔（Image）是一種輕量、可執行的環境打包方式，它可以包含應用程式運行所需的所有資源，如程式碼、執行環境、庫文件、設定檔等。一個 Docker 映像檔由多個層（Layer）組成，每一層都是對映像檔系統的一次修改。

## 分層結構

當你建立一個新的 Docker 映像檔時，每一個指令（如 `RUN`、`COPY`、`ADD`）都會產生一個新的層。這種分層結構有幾個重要的優勢：

1. **節省空間**：如果兩個映像檔共用相同的層，這些層只會在硬碟上存儲一次，因此節省了空間。

2. **容易分享**：每個層都是獨立的，因此可以更容易地共享和重複使用這些層。這也是 Docker 映像檔如此輕量級和易於傳播的原因之一。

3. **快速構建**：當你修改了一個映像檔並重新構建時，Docker 可以快速地重新使用先前建立的層，只重新建立修改過的部分，從而加快了構建速度。

## 實際應用

例如，假設你有一個基於 Ubuntu 的映像檔，並且對其進行了一些自定義配置和安裝，這些操作會生成一個新的層。當你使用這個映像檔建立容器時，Docker 會將這些層堆疊在一起，最終形成一個完整的運行環境。

## 查看看Docker映像檔的metadata
可以使用以下指令來看 web-ping 的映像檔metadata:
```
docker image history web-ping
```

可以看到每一個映像層都有輸出
![image](https://hackmd.io/_uploads/ryPYsEYH0.png)

CREATED BY 這一欄紀錄的是Dockerfile執行的命令


# 映像層快取

修改一下 app.js 檔案，例如加入空白後執行以下指令
```
docker image build -t web-ping:v2 .
```

調整 Dockerfile 內容如下:
```
FROM diamol/node

CMD ["node", "/web-ping/app.js"]    # CMD 往前放了

ENV TARGET="blog.sixeyed.com" \     # 3個 ENV 合併在一起
    METHOD="HEAD" \
    NTERVAL="3000"

WORKDIR /web-ping
COPY app.js .

```

```
cd ..
cd web-ping-optimized/
docker image build -t web-ping:v3 .
```

![image](https://hackmd.io/_uploads/Hy2cM8FHR.png)


這一段其實有點看不太懂書中說到的優化在哪裡，我只看到有調整了寫法

# 結尾
以上就是第三天的練習內容，今天介紹了Docker Hub、Dockerfile、Docker Image還有Image Layer 相關的知識，如果有任何問題或需要進一步的幫助，歡迎在留言區提出。


