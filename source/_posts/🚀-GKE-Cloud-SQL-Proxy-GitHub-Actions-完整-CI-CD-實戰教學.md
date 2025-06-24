---
title: 🚀 GKE + Cloud SQL Proxy + GitHub Actions 完整 CI/CD 實戰教學
date: 2025-06-24 09:01:38
tags:
    - GKE
    - CI/CD
    - Clcoud
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

# 🚀 GKE + Cloud SQL Proxy + GitHub Actions 完整 CI/CD 實戰教學

## 📌 前言

在 Google Cloud 平台上，很多團隊會同時用 **GKE (Google Kubernetes Engine)** 來部署後端服務，並搭配 **Cloud SQL** 做為後端資料庫。但許多新手常常卡在一件事：**Pod 怎麼安全連接 Cloud SQL？**

這篇文章會帶你一次搞懂：

* 連線 Cloud SQL 的正確做法
* 最推薦的 Proxy 架構
* 以及怎麼結合 **GitHub Actions CI/CD**，實現從 Commit 到 GKE 一條龍部署！

---

## 🎯 目標

* 🔑 用 **Cloud SQL Auth Proxy** 保護資料庫連線
* 🚀 用 **GitHub Actions** 實作 CI/CD
* 🎉 一次部署到 GKE + 自動更新

---

## 🗂️ 常見連線方式比較

| 方式                         | 說明                             | 優缺點                 |
| -------------------------- | ------------------------------ | ------------------- |
| Public IP + 帳密             | 直接暴露 IP，Pod 需要 IP 白名單          | 🟥 最不安全，生產不建議       |
| Private IP + VPC Routing   | 內部走 Private IP，需要設 Routing、NAT | 🟧 安全 OK，但 VPC 配置麻煩 |
| ✅ **Cloud SQL Auth Proxy** | Google 官方推薦，用 IAM 安全通道 + TLS   | 🟩 最安全、最簡單、最穩定      |

---

## ✅ **最佳做法：使用 Cloud SQL Auth Proxy**

Cloud SQL Proxy 是 Google 提供的小工具，幫你：

* ✅ 自動處理 IAM 驗證
* ✅ 自動做 TLS 加密
* ✅ 自動重連
* ✅ 不需要在 SQL 裡設白名單

用 Proxy，應用程式只需要連 `localhost:5432`，其他交給 Proxy 代勞！

---

## ⚙️ **實作步驟**

---

### 1️⃣ 建立 GKE Cluster 與 Cloud SQL

* 建好 GKE Cluster（VPC-Native 建議打開）
* 建好 Cloud SQL（PostgreSQL / MySQL 都支援）
* 開啟 [Workload Identity Federation](https://github.com/google-github-actions/auth#workload-identity-federation)（給 GitHub Actions 用）

---

### 2️⃣ 撰寫 Deployment YAML

重點：把 Proxy 當 Sidecar 加進 Pod。

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      serviceAccountName: my-app-sa  # 要先建立，並授權 roles/cloudsql.client
      containers:
      - name: my-app
        image: <IMAGE_TAG>
        env:
        - name: DB_HOST
          value: "127.0.0.1"
        - name: DB_PORT
          value: "5432"

      - name: cloud-sql-proxy
        image: gcr.io/cloud-sql-connectors/cloud-sql-proxy:2.8.0
        args:
          - "--structured-logs"
          - "--auto-iam-authn"
          - "<PROJECT_ID>:<REGION>:<INSTANCE_NAME>"
        securityContext:
          runAsNonRoot: true
```

---

### 3️⃣ Service YAML

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-app
spec:
  selector:
    app: my-app
  ports:
  - port: 80
    targetPort: 8080
  type: LoadBalancer
```

---

### 4️⃣ 建立 GitHub Actions CI/CD Workflow

在 `.github/workflows/deploy.yml`：

```yaml
name: Build and Deploy to GKE

on:
  push:
    branches:
      - "main"

env:
  PROJECT_ID: "<your-project-id>"
  GAR_LOCATION: "asia-east1"
  GKE_CLUSTER: "<your-cluster-name>"
  GKE_ZONE: "asia-east1-a"
  DEPLOYMENT_NAME: "my-app"
  REPOSITORY: "my-repo"
  IMAGE: "my-app"
  WORKLOAD_IDENTITY_PROVIDER: "projects/<project-number>/locations/global/workloadIdentityPools/<pool>/providers/<provider>"

jobs:
  build-deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: 'read'
      id-token: 'write'

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - id: auth
        uses: google-github-actions/auth@v2
        with:
          workload_identity_provider: ${{ env.WORKLOAD_IDENTITY_PROVIDER }}
          service_account: "<YOUR-GCP-SERVICE-ACCOUNT>"

      - name: Docker Auth
        uses: docker/login-action@v3
        with:
          username: oauth2accesstoken
          password: ${{ steps.auth.outputs.access_token }}
          registry: ${{ env.GAR_LOCATION }}-docker.pkg.dev

      - name: Get GKE credentials
        uses: google-github-actions/get-gke-credentials@v2
        with:
          cluster_name: ${{ env.GKE_CLUSTER }}
          location: ${{ env.GKE_ZONE }}

      - name: Build and Push Docker Image
        run: |
          IMAGE_TAG="${GAR_LOCATION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/${IMAGE}:${GITHUB_SHA}"
          docker build -t "${IMAGE_TAG}" .
          docker push "${IMAGE_TAG}"

      - name: Deploy to GKE
        run: |
          sed -i "s|<IMAGE_TAG>|${GAR_LOCATION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/${IMAGE}:${GITHUB_SHA}|" k8s/deployment.yaml
          kubectl apply -f k8s/
          kubectl rollout status deployment/${DEPLOYMENT_NAME}
```

---

### 5️⃣ 角色與權限

確保：

* Artifact Registry ➜ `roles/artifactregistry.admin`
* GKE ➜ `roles/container.developer`
* Cloud SQL ➜ `roles/cloudsql.client`

都授權給執行 Actions 的 Service Account。

---

## ✅ **驗證**

* Commit & Push
* GitHub Actions 自動執行
* 自動 Build → Push → 更新 GKE → Proxy 幫你穩定連線 Cloud SQL

---

## 🎉 **總結**

這篇教學幫你完成：
✅ Cloud SQL Proxy Sidecar 實作
✅ GKE 部署
✅ GitHub Actions CI/CD 一條龍

新手也能一次成功，直接用在開發、測試、正式環境都沒問題。

---

## 📌 參考連結

* [Cloud SQL Proxy 官方文件](https://cloud.google.com/sql/docs/mysql/connect-kubernetes-engine)
* [GitHub Actions for GCP](https://github.com/google-github-actions)

---

## ✨ **歡迎留言討論！**

希望這篇對想把專案搬上 GKE 的工程師有幫助！
有任何問題或想看其他 GCP DevOps 實戰，歡迎留言給我 🙌

---

## 🔑 **#GKE #CloudSQL #Proxy #GitHubActions #DevOps**