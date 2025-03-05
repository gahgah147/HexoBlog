---
title: 在 Docker desktop 上使用 Kubernetes Helm 部署 Casdoor
date: 2025-03-05 17:16:45
tags:
    - Casdoor
categories:
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

# 在 Docker desktop 上使用 Kubernetes Helm 部署 Casdoor

![image](https://hackmd.io/_uploads/r1-pPifskg.png)
> https://casdoor.org/docs/basic/try-with-helm

## 簡介

本指南將介紹如何在 Kubernetes 上使用 Helm 部署 Casdoor，以實現輕鬆且可擴展的身份驗證管理。

# 部屬在 Docker desktop 上

## **💡 你需要準備的環境**
1. **安裝 Docker Desktop**
   - 確保 **Docker Desktop** 已安裝，並啟用 Kubernetes 。
   
2. **啟用 Docker Desktop 內建的 Kubernetes**
   - **開啟 Docker Desktop**
   - **進入 `Settings` (設定) → `Kubernetes`**
   - **勾選 `Enable Kubernetes`，然後點選 `Apply & Restart`**
![image](https://hackmd.io/_uploads/rkx6GWBVoJl.png)
>打開Kubernetes 開關

![image](https://hackmd.io/_uploads/SkiQWB4sJx.png)



![image](https://hackmd.io/_uploads/SyENWr4oke.png)

- 等待 Kubernetes 啟動，確保 `kubectl` 可以正常運行：
     ```sh
     kubectl get nodes
     ```
     如果看到 `Ready`，表示 Kubernetes 已啟動。
     


![image](https://hackmd.io/_uploads/BkcObBVoyx.png)

3. **安裝 Helm（如果尚未安裝）**
   - 下載 Helm：
     ```sh
     curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
     ```
   - 確認安裝成功：
     ```sh
     helm version
     ```

---


## **🛠️ 使用 Helm 安裝 Casdoor**
在 **Docker Desktop Kubernetes** 環境中安裝 **Casdoor**，步驟如下：

### **1️⃣ 安裝 Casdoor Helm Chart**
執行以下指令：
```sh
helm install casdoor oci://registry-1.docker.io/casbin/casdoor-helm-charts --version v1.702.0
```
這會在 Kubernetes 叢集內部建立 **Casdoor** 相關的 Deployment、Service 等資源。

![image](https://hackmd.io/_uploads/rywobrNi1l.png)


### **2️⃣ 確認 Pod 運行狀態**
確保 **Casdoor Pod** 已成功啟動：
```sh
kubectl get pods
```
如果 `STATUS` 顯示 `Running`，表示 Casdoor 已經成功部署。

## **✅ 步驟 1：下載 `values.yaml`**
先下載官方 Helm Chart 的 `values.yaml`，這樣我們可以直接修改它：
```bash
helm show values oci://registry-1.docker.io/casbin/casdoor-helm-charts > my-values.yaml
```
這會產生一個 `my-values.yaml` 文件，裡面包含所有 Casdoor Helm Chart 的預設設定。

---

## **✅ 步驟 2：編輯 `my-values.yaml`**
打開 `my-values.yaml`，然後根據你的需求修改以下設定：



### **🔹 1. 設定 PostgreSQL 為資料庫**
找到 `database` 部分，改成：
```yaml
database:
  driver: postgres
  user: casdoor
  password: yourpassword  # 改成你的真實密碼
  host: your-db-host      # 改成你的 PostgreSQL 伺服器 IP 或名稱
  port: 5432
  databaseName: casdoor
  sslMode: disable  # 如果你的 PostgreSQL 不使用 SSL，可以設為 disable
```
這樣 Casdoor 會使用 **PostgreSQL** 作為儲存後端，而不是預設的 `sqlite3`。

![image](https://hackmd.io/_uploads/ryQWMH4s1g.png)



## **✅ 步驟 3：使用 `values.yaml` 來更新 Casdoor**
現在，你可以用這個設定檔來部署 Casdoor：
```bash
helm upgrade casdoor oci://registry-1.docker.io/casbin/casdoor-helm-charts -f my-values.yaml
```
這樣 Helm 會根據 `my-values.yaml` 來部署 Casdoor，而不會使用預設值。

![image](https://hackmd.io/_uploads/SktGMBEiyx.png)


這邊可以看到有提示
```
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=casdoor-helm-charts,app.kubernetes.io/instance=casdoor" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
```
跟指示執行，這邊可以看到可以訪問 Casdoor

![image](https://hackmd.io/_uploads/rJ4VGHNike.png)

![image](https://hackmd.io/_uploads/r1dVfB4j1g.png)

:::info
這邊使ㄠ用官方預設帳號密碼可以登入
帳號:admin
密碼:123
:::


## **📌 卸載 Casdoor**
如果要移除 Casdoor：
```sh
helm delete casdoor
```

如果要刪除 PostgreSQL：
```sh
helm delete postgres
```

---

## **🎉 結論**
你現在已經成功在 Docker Desktop Kubernetes 部署了 Casdoor！ 🎉

這篇教學讓你學會：

- 如何啟用 `Docker Desktop` Kubernetes
- 如何用 `Helm` 安裝 `Casdoor`
- 如何連接 `PostgreSQL`
- 如何訪問 `Casdoor` 後台
希望這篇文章對你有幫助！ 🚀
