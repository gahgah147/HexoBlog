---
title: IPFS介紹 - 星際檔案系統
date: 2024-05-16 16:15:34
tags:
    - IPFS
    - 區塊鏈
    - 星際檔案系統
    - Filecoin
---

# IPFS介紹 - 星際檔案系統 

![image](https://hackmd.io/_uploads/rkqS8qbmC.png)
>https://ipfs.tech/

IPFS（InterPlanetary File System）是一種分佈式的文件系統，旨在建立一個更快、更安全和更開放的互聯網。

https://youtu.be/5Uj6uR3fp-U?si=LLShkmZ5JBewmt6Q

## IPFS的主要特點
### 分佈式存儲
資料不是儲存在單一的伺服器上，而是分佈在全球許多節點上。這種方法提高了資料的冗餘度和可靠性。

### 內容尋址
IPFS 使用內容尋址（Content Addressing）來存取資料，而不是傳統的基於位置的尋址方法。每個文件都有一個唯一的哈希值作為其地址。

### 版本控制
類似於Git，IPFS 支援資料的版本控制，這意味著每個文件的更改都可以被跟蹤和還原。

### 點對點網絡
IPFS 使用點對點（P2P）技術，允許用戶直接連接並共享資源，而不需要依賴中央伺服器。

### 去中心化
IPFS 的架構去除了對中心化伺服器的依賴，減少了單點故障的風險，並且提高了資料的可用性和抗審查性。

## IPFS 的主要用途
### 網站託管
通過IPFS，網站可以以去中心化的方式託管，不再依賴單一伺服器，從而提高網站的穩定性和安全性。

### 分佈式應用程式（dApps）
IPFS 常被用於支援去中心化應用程式，這些應用程式需要一個可靠的分佈式存儲解決方案。

### 大文件共享
由於其高效的分塊和分發機制，IPFS 非常適合用來共享和存儲大文件。


## 實際操作

### 設定與啟動

建立一個ipfs_test資料夾，結構如下。

```
ipfs_test
|_ staging
|_ data
```
![image](https://hackmd.io/_uploads/H18n2qW7A.png)

staging 是準備要放即將要 export 出去的檔案的地方。

使用 docker 拉go-ipfs image 啟動，並指定檔案 export 的路徑。
```
export ipfs_staging=/absolute/path/to/<staging的資料夾>/
export ipfs_data=/absolute/path/to/<data的資料夾>/
docker run -d --name ipfs_host -v $ipfs_staging:/export -v $ipfs_data:/data/ipfs -p 4001:4001 -p 4001:4001/udp -p 127.0.0.1:8080:8080 -p 127.0.0.1:5001:5001 ipfs/go-ipfs:latest
```

:::warning

這邊我有遇到錯誤訊息
![image](https://hackmd.io/_uploads/SJLDPXQ7A.png)

這個錯誤訊息表明在WSL 2中無法找到docker命令，這可能是因為Docker Desktop尚未與WSL 2整合或安裝。

要在WSL 2中使用Docker Desktop，需要先啟用WSL整合。請按照以下步驟操作：

1.打開Docker Desktop。
![image](https://hackmd.io/_uploads/B1ScPXmQR.png)

2.點擊左上角的Docker圖標，選擇"Settings"。
![image](https://hackmd.io/_uploads/BkxjPXXQ0.png)

3.在"Resources"->"WSL integration"部分，勾選"Enable integration with my default WSL distro" 並且也把"Ubuntu-20.04"這邊的開關打開。
![image](https://hackmd.io/_uploads/r15pPXQ7A.png)

4.點擊"Apply & Restart"來應用更改。
完成這些步驟後，Docker Desktop將啟用WSL 2整合並重啟。然後，你應該能夠在WSL 2中使用docker命令來運行容器。

:::

如果要監看 logs，可以下：

```
docker logs -f ipfs_host
```

![image](https://hackmd.io/_uploads/SkKaT7Qm0.png)


進入 container 做事：
```
docker exec -it ipfs_host /bin/sh

```

![image](https://hackmd.io/_uploads/r1Yy0Qm70.png)

![image](https://hackmd.io/_uploads/HkqbRXmQR.png)
這邊可以發現開啟了3個docker

啟動後可以查看介面
![image](https://hackmd.io/_uploads/BkFO0QQ7R.png)
> http://localhost:5001/webui

### 將檔案上傳至 IPFS

進入 container 後，把檔案（這裡以 測試檔案 xlsx 為例）丟到本地的 staging 資料夾，下 export指令把它上傳到 ipfs 並取得 hash 值。

```
docker exec -it ipfs_host /bin/sh
ipfs add -r /export/
```
![image](https://hackmd.io/_uploads/H1GC7Vm7A.png)

上傳完後會取得 ipfs-hash

```
added QmaEa7JhzR6qpFZpRNRecKsAsf1tqzAJKktXxQ6tE4iTPf export/test0050.xlsx
added QmUELrk81uAbSsEj4r9XHUtUov7GDLMnTyiVXeCSSoK98o export
```


### 用 ipfs-hash 去查看檔案
查看剛剛丟的檔案：
```
ipfs cat /ipfs/QmaEa7JhzR6qpFZpRNRecKsAsf1tqzAJKktXxQ6tE4iTPf
```

也可以從這邊查看 http://127.0.0.1:8080/ipfs/QmaEa7JhzR6qpFZpRNRecKsAsf1tqzAJKktXxQ6tE4iTPf
>這邊會直接下載下來

### 其他常用指令
```
# 查看 log
docker logs -f ipfs_host

# 停止容器
docker stop ipfs_host

# 查看內容
ipfs cat /ipfs/QmV3LyHokfUH1kp94Nrxn8q1E8p95Kt9kfKfJSUpXsGc6Q

# docker exec ipfs_host [指令]
docker exec ipfs_host ipfs add -r /export/
```

## 把 node 連結到 IPFS network

查詢自己的 id
```
 ipfs id
```

![image](https://hackmd.io/_uploads/BJfg84QQC.png)

介面這邊也可以查看到節點ID
![image](https://hackmd.io/_uploads/rJ0fUVQ7R.png)


尋找其他的 peers
```
ipfs swarm peers
```
![image](https://hackmd.io/_uploads/SJO5L4m7R.png)

圖形化介面查看方式:
![image](https://hackmd.io/_uploads/HynoLV77C.png)

## 查看別人的檔案

可以透過自己的 IPFS 節點造訪別人的檔案內容。我們來看看被 IPFS 團隊放上 IPFS 網絡的土耳其文維基百科 snapshot！

```
ipfs cat Qme2sLfe9ZMdiuWsEtajWMDzx6B7VbjzpSC2VWhtB6GoB1/wiki/Peer-to-peer.html 
```

![image](https://hackmd.io/_uploads/rJp-v47m0.png)


查看土耳其文維基百科部分的檔案：

```
ipfs ls Qme2sLfe9ZMdiuWsEtajWMDzx6B7VbjzpSC2VWhtB6GoB1/wiki/Anasayfa.html
```

## IPFS 操作介面

### 首頁
![image](https://hackmd.io/_uploads/r1vU_EXmC.png)

### 檔案
![image](https://hackmd.io/_uploads/H1vDu4m7R.png)

### 瀏覽
![image](https://hackmd.io/_uploads/ByVddVmX0.png)

### 用戶群
![image](https://hackmd.io/_uploads/S1wYuV7X0.png)

![image](https://hackmd.io/_uploads/By0q_VXmA.png)

### 設定
![image](https://hackmd.io/_uploads/Hk53u47mC.png)


這邊我發現實際操作已經跟教學文章比較起來有更新很多畫面了。

## 後記

這一篇是我在網路上看到這篇教學文章
https://medium.com/wenchin-rolls-around/%E8%A9%A6%E7%8E%A9-ipfs-a69a52abb954

跟著實際操作的紀錄，這邊有官方介紹文件 https://docs.ipfs.tech/concepts/usage-ideas-examples/ 有興趣可以繼續研究，另外還有其他人開發的 IPFS 相關應用 https://github.com/ipfs/awesome-ipfs
