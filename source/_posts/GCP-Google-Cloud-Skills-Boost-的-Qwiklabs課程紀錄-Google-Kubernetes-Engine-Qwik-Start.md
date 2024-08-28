---
title: >-
  GCP - Google Cloud Skills Boost 的 Qwiklabs課程紀錄 : Google Kubernetes Engine:
  Qwik Start
date: 2024-08-28 11:35:21
tags:
  - GCP
  - Google Cloud Skills Boost
  - Kubernetes
  - 雲端服務
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/rJ7NUf3sA.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

![image](https://hackmd.io/_uploads/rJ7NUf3sA.png)


今天這篇文章是在記錄我練習Google Cloud Skills Boost 官方學習資源平台的過程，今天練習的課程是 Google Kubernetes Engine: Qwik Start，這個 實踐實驗室（Qwiklabs） 主題是在介紹 Google 雲端平台上面的Kubernetes 功能。

![image](https://hackmd.io/_uploads/rkNv8G3jA.png)

我會記錄題目的內容跟翻譯成中文的意思，還有我操作的結果畫面，方便之後複習時可以縮短學習時間。

# 什麼是Google Cloud Learning Courses and Certifications ? 

![image](https://hackmd.io/_uploads/Hk4NWznjR.png)
>https://cloud.google.com/learn?hl=zh_tw

Google Cloud Learning Courses and Certifications是 Google Cloud 的學習資源平台。這個網站提供了一系列的學習資源，幫助使用者學習和掌握 Google Cloud 技術。內容包括教學課程、實驗室練習、學習路徑、認證準備資源，以及其他可以幫助使用者提升技能的教育材料。無論是初學者還是有經驗的專業人員，都可以在這裡找到適合的學習內容，進一步了解如何有效地使用 Google Cloud 服務和技術。

![image](https://hackmd.io/_uploads/Hk_fEz2i0.png)

這邊點擊 訓練 -> 開始訓練 就可以進入 Google Cloud Skills Boost

# 什麼是 Google Cloud Skills Boost ?
![image](https://hackmd.io/_uploads/SyTOXGno0.png)
>https://www.cloudskillsboost.google/

是 Google Cloud 提供的學習平台，專門用來幫助使用者提升雲端技能。該平台包含各種實踐實驗室（Qwiklabs）、學習路徑、課程和其他學習資源，旨在幫助使用者掌握 Google Cloud 的技術和服務。平台上的內容涵蓋了從基礎到進階的各種主題，適合不同經驗水平的學習者。此外，它還提供認證準備資源，幫助學習者準備 Google Cloud 的官方認證考試。


# GSP100
![image](https://hackmd.io/_uploads/HJao_DYoC.png)

# 教學影片 
[Manage Containerized Apps with Kubernetes Engine | Google Cloud Labs](https://www.youtube.com/watch?v=u9nsngvmMK4&feature=youtu.be)

# Overview - 概述

[Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine) (GKE) provides a managed environment for deploying, managing, and scaling your containerized applications using Google infrastructure. The GKE environment consists of multiple machines (specifically [Compute Engine](https://cloud.google.com/compute) instances) grouped to form a [container cluster](https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-architecture).

In this lab, you get hands-on practice with container creation and application deployment with GKE.


Google Kubernetes Engine (GKE) 提供了一個受管理的環境，用於在 Google 基礎架構上部署、管理和擴展您的容器化應用程式。GKE 環境由多台機器（具體來說是 Compute Engine 實例）組成，這些機器被分組形成一個 容器集群。

在本次實驗中，您將進行實際操作，練習使用 GKE 進行容器創建和應用程式部署。

# Objectives - 目標

In this lab you will learn how to:

* Create a GKE cluster
* Deploy an application to the cluster
* Delete the cluster

以上內容是在本次實驗中，您將學習如何：

* 建立一個 GKE cluster (集群)
* 將應用程式部署到該 cluster (集群)
* 刪除該 cluster (集群)

## Cluster orchestration with Google Kubernetes Engine - 使用 Google Kubernetes Engine 進行叢集編排

Google Kubernetes Engine (GKE) clusters are powered by the [Kubernetes](https://kubernetes.io/) open source cluster management system. Kubernetes provides the mechanisms through which you interact with your container cluster. You use Kubernetes commands and resources to deploy and manage your applications, perform administrative tasks, set policies, and monitor the health of your deployed workloads.

Kubernetes draws on the same design principles that run popular Google services and provides the same benefits: automatic management, monitoring and liveness probes for application containers, automatic scaling, rolling updates, and more. When you run your applications on a container cluster, you're using technology based on Google's 10+ years of experience with running production workloads in containers.

以上內容是在描述 GKE 如何可以編輯 Cluster 的原理跟功能介紹

Google Kubernetes Engine (GKE) 的叢集是由 [Kubernetes](https://kubernetes.io/) 開源叢集管理系統提供支持的。Kubernetes 提供了與容器叢集進行互動的機制。您可以使用 Kubernetes 的指令和資源來部署和管理應用程式、執行管理任務、設定政策以及監控已部署工作負載的健康狀況。

Kubernetes 借鑑了運行 Google 眾多熱門服務的相同設計原則，並提供了相同的優勢：自動管理、應用程式容器的監控和存活探針、自動縮放、滾動更新等功能。當您在容器叢集上運行應用程式時，您正在使用基於 Google 超過十年運行生產環境工作負載經驗的技術。

## Kubernetes on Google Cloud - 在 Google Cloud 上使用 Kubernetes

When you run a GKE cluster, you also gain the benefit of advanced cluster management features that Google Cloud provides. These include:

* [Load balancing](https://cloud.google.com/compute/docs/load-balancing-and-autoscaling) for Compute Engine instances
* [Node pools](https://cloud.google.com/kubernetes-engine/docs/node-pools) to designate subsets of nodes within a cluster for additional flexibility
* [Automatic scaling](https://cloud.google.com/kubernetes-engine/docs/cluster-autoscaler) of your cluster's node instance count
* [Automatic upgrades](https://cloud.google.com/kubernetes-engine/docs/node-auto-upgrade) for your cluster's node software
* [Node auto-repair](https://cloud.google.com/kubernetes-engine/docs/how-to/node-auto-repair) to maintain node health and availability
* [Logging and Monitoring](https://cloud.google.com/kubernetes-engine/docs/how-to/logging) with Cloud Monitoring for visibility into your cluster

Now that you have a basic understanding of Kubernetes, you will learn how to deploy a containerized application with GKE in less than 30 minutes. Follow the steps below to set up your lab environment.

以上內容是進階介紹 Kubernetes 的功能細節

當您運行 GKE 叢集時，還可以享受 Google Cloud 提供的進階叢集管理功能。這些功能包括：

- 為 Compute Engine 實例提供的[負載平衡](https://cloud.google.com/compute/docs/load-balancing-and-autoscaling)
- 使用[節點池](https://cloud.google.com/kubernetes-engine/docs/node-pools)來指定叢集內的節點子集，以增加彈性
- 自動調整叢集節點實例數量的[自動縮放](https://cloud.google.com/kubernetes-engine/docs/cluster-autoscaler)
- 為叢集節點軟體提供的[自動升級](https://cloud.google.com/kubernetes-engine/docs/node-auto-upgrade)
- 維護節點健康與可用性的[節點自動修復](https://cloud.google.com/kubernetes-engine/docs/how-to/node-auto-repair)
- 使用 Cloud Monitoring 進行叢集的[日誌記錄與監控](https://cloud.google.com/kubernetes-engine/docs/how-to/logging)，以提升叢集的可視性

現在您已經對 Kubernetes 有了基本的了解，接下來將學習如何在不到 30 分鐘內使用 GKE 部署容器化應用程式。請按照以下步驟來設置您的實驗環境。

# Task 1. Set a default compute zone - 設定預設的計算區域

Your [compute zone](https://cloud.google.com/compute/docs/regions-zones/#available) is an approximate regional location in which your clusters and their resources live. For example, us-central1-a is a zone in the us-central1 region.

In your Cloud Shell session, run the following commands.

你的 [計算區域](https://cloud.google.com/compute/docs/regions-zones/#available) 是叢集及其資源所在的近似區域位置。例如，us-central1-a 是 us-central1 區域中的一個區域。

在你的 Cloud Shell 會話中，運行以下命令。

1. Set the default compute region:

```
gcloud config set compute/region "REGION"
```

Expected output:

```
Updated property [compute/region].
```

![image](https://hackmd.io/_uploads/ryZ5gdKo0.png)

2. Set the default compute zone:

```
gcloud config set compute/zone "ZONE"
```

Expected output:

```
Updated property [compute/zone].
```

![image](https://hackmd.io/_uploads/S1psguFjC.png)

# Task 2. Create a GKE cluster - 建立一個 GKE 叢集

A [cluster](https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-architecture) consists of at least one cluster master machine and multiple worker machines called nodes. Nodes are [Compute Engine virtual machine (VM) instances](https://cloud.google.com/compute/docs/instances/) that run the Kubernetes processes necessary to make them part of the cluster.

:::info
Note: Cluster names must start with a letter and end with an alphanumeric, and cannot be longer than 40 characters.
:::

Run the following command:

一個 [叢集](https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-architecture) 由至少一個叢集主控機器和多個稱為節點的工作機器組成。節點是運行 Kubernetes 所需進程的 [Compute Engine 虛擬機器 (VM) 實例](https://cloud.google.com/compute/docs/instances/)，使它們成為叢集的一部分。

:::info
注意：叢集名稱必須以字母開頭並以字母或數字結尾，且名稱長度不得超過 40 個字元。
:::

執行以下指令：

Create a cluster:

```
gcloud container clusters create --machine-type=e2-medium --zone=ZONE lab-cluster
```

You can ignore any warnings in the output. It might take several minutes to finish creating the cluster.

Expected output:
```
NAME: lab-cluster
LOCATION: ZONE
MASTER_VERSION: 1.22.8-gke.202
MASTER_IP: 34.67.240.12
MACHINE_TYPE: e2-medium
NODE_VERSION: 1.22.8-gke.202
NUM_NODES: 3
STATUS: RUNNING
```

Click Check my progress to verify the objective.
![image](https://hackmd.io/_uploads/SJs0cDYj0.png)

![image](https://hackmd.io/_uploads/Hy-eGdFoR.png)
>這一步執行會花一段時間

![image](https://hackmd.io/_uploads/SJuDG_KiC.png)


# Task 3. Get authentication credentials for the cluster - 獲取叢集的身份驗證憑證

After creating your cluster, you need authentication credentials to interact with it.

* Authenticate with the cluster:

在建立叢集後，你需要身份驗證憑證來與叢集互動。

* 與叢集進行身份驗證：

```
gcloud container clusters get-credentials lab-cluster
```

Expected output:
```
Fetching cluster endpoint and auth data.
kubeconfig entry generated for my-cluster.
```

![image](https://hackmd.io/_uploads/S1weX_FiC.png)


# Task 4. Deploy an application to the cluster - 部署應用程式到叢集

You can now deploy a containerized application to the cluster. For this lab, you'll run hello-app in your cluster.

GKE uses Kubernetes objects to create and manage your cluster's resources. Kubernetes provides the [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) object for deploying stateless applications like web servers. [Service](https://kubernetes.io/docs/concepts/services-networking/service/) objects define rules and load balancing for accessing your application from the internet.

1.To **create a new Deployment** `hello-server` from the `hello-app` container image, run the following `kubectl create` command:

你現在可以將容器化的應用程式部署到叢集。在這個實驗中，你將在叢集中運行 `hello-app`。

GKE 使用 Kubernetes 物件來創建和管理叢集的資源。Kubernetes 提供了 [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) 物件來部署無狀態應用程式，如網頁伺服器。[Service](https://kubernetes.io/docs/concepts/services-networking/service/) 物件則定義了從互聯網訪問你的應用程式的規則和負載均衡。

1.要從 `hello-app` 容器映像中**創建一個新的 Deployment** `hello-server`，請運行以下 `kubectl create` 指令：

```
kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0
```

Expected output:
```
deployment.apps/hello-server created
```

![image](https://hackmd.io/_uploads/H1dPXdtj0.png)


This Kubernetes command creates a deployment object that represents `hello-server`. In this case, `--image` specifies a container image to deploy. The command pulls the example image from a [Container Registry](https://cloud.google.com/container-registry/docs) bucket. `gcr.io/google-samples/hello-app:1.0` indicates the specific image version to pull. If a version is not specified, the latest version is used.

這個 Kubernetes 指令會創建一個代表 `hello-server` 的 Deployment 物件。在這個例子中，`--image` 指定了要部署的容器映像。該指令會從 [Container Registry](https://cloud.google.com/container-registry/docs) 儲存區中提取範例映像。`gcr.io/google-samples/hello-app:1.0` 表示要提取的特定映像版本。如果未指定版本，則會使用最新版本。

Click **Check my progress** to verify the objective.
![image](https://hackmd.io/_uploads/SJNx2vFsA.png)

2. To create a Kubernetes Service, which is a Kubernetes resource that lets you expose your application to external traffic, run the following kubectl expose command:

要建立一個 Kubernetes Service，它是一種 Kubernetes 資源，允許你將應用程式公開給外部流量，請執行以下 `kubectl expose` 指令：

```
kubectl expose deployment hello-server --type=LoadBalancer --port 8080
```

In this command:
* `--port` specifies the port that the container exposes.
* `type="LoadBalancer"` creates a Compute Engine load balancer for your container.

Expected output:

在這個指令中：
* `--port` 指定容器所開放的端口。
* `type="LoadBalancer"` 為你的容器建立一個 Compute Engine 負載平衡器。

預期輸出：

```
service/hello-server exposed
```

![image](https://hackmd.io/_uploads/B1FqQOtjR.png)


3. To inspect the `hello-server` Service, run `kubectl get`:

要檢查 `hello-server` 服務，請執行 `kubectl get`：

```
kubectl get service
```

Expected output:
```
NAME             TYPE            CLUSTER-IP      EXTERNAL-IP     PORT(S)           AGE
hello-server     loadBalancer    10.39.244.36    35.202.234.26   8080:31991/TCP    65s
kubernetes       ClusterIP       10.39.240.1               433/TCP           5m13s
```

:::info
**Note**: It might take a minute for an external IP address to be generated. Run the previous command again if the EXTERNAL-IP column status is **pending**.

**注意**：生成外部 IP 地址可能需要一分鐘。如果 EXTERNAL-IP 欄位狀態為 **pending**，請再次執行之前的指令。
:::

![image](https://hackmd.io/_uploads/HkT2X_FiA.png)


4. To view the application from your web browser, open a new tab and enter the following address, replacing `[EXTERNAL IP]` with the `EXTERNAL-IP` for `hello-server`.

要在網頁瀏覽器中查看應用程式，開啟一個新標籤頁並輸入以下地址，將 `[EXTERNAL IP]` 替換為 `hello-server` 的 `EXTERNAL-IP`。

```
http://[EXTERNAL-IP]:8080
```

**Expected output**: The browser tab displays the message **Hello, world!** as well as the version and hostname.

**預期輸出**：瀏覽器標籤頁顯示消息 **Hello, world!** 以及版本和主機名稱。

這邊實作產生的 EXTERNAL-IP 是 34.85.205.6 測試瀏覽的畫面如下

![image](https://hackmd.io/_uploads/HkjG4OtsR.png)
>http://34.85.205.6:8080/


Click **Check my progress** to verify the objective.
![image](https://hackmd.io/_uploads/BJOVpwYjR.png)

# Task 5. Deleting the cluster - 刪除叢集

1. To delete the cluster, run the following command:
 要刪除叢集，請運行以下命令：
```
gcloud container clusters delete lab-cluster
```
2. When prompted, type Y to confirm.

Deleting the cluster can take a few minutes. For more information on deleted GKE clusters from the Google Kubernetes Engine (GKE) article, [Deleting a cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/deleting-a-cluster).

當系統提示時，輸入 Y 以確認。

刪除叢集可能需要幾分鐘。欲了解更多有關從 Google Kubernetes Engine (GKE) 刪除叢集的資訊，請參閱文章 [刪除叢集](https://cloud.google.com/kubernetes-engine/docs/how-to/deleting-a-cluster)。

![image](https://hackmd.io/_uploads/SymdEuYjC.png)

![image](https://hackmd.io/_uploads/r1zjr_YsC.png)
> 這邊也可以直接在介面上操作

Click **Check my progress** to verify the objective.

![image](https://hackmd.io/_uploads/Bkl3aDtsC.png)

# Congratulations! - 恭喜！
You have just deployed a containerized application to Google Kubernetes Engine! In this lab, you created a GKE cluster, deployed a containerized application to the cluster, and deleted the cluster. You can now apply this knowledge to deploy your own applications with GKE.

您剛剛成功將容器化應用程式部署到 Google Kubernetes Engine！在這個實驗中，您建立了一個 GKE 叢集，將容器化應用程式部署到叢集，並刪除了該叢集。現在，您可以將這些知識應用到部署您自己的應用程式上。

## Next steps / Learn more - 下一步 / 了解更多

This lab is part of a series of labs called Qwik Starts. These labs are designed to give you some experience with the many features available with Google Cloud. Search for "Qwik Starts" in the [Google Cloud Skill Boost catalog](http://google.qwiklabs.com/catalog) to find the next lab you'd like to take!

這個實驗是 Qwik Starts 系列實驗的一部分。這些實驗旨在讓您體驗 Google Cloud 提供的眾多功能。您可以在 [Google Cloud Skill Boost 目錄](http://google.qwiklabs.com/catalog) 中搜尋 "Qwik Starts" 來找到您想參加的下一個實驗！

## Google Cloud training and certification - Google Cloud 培訓與認證

...helps you make the most of Google Cloud technologies. [Our classes](https://cloud.google.com/training/courses) include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. [Certifications](https://cloud.google.com/certification/) help you validate and prove your skill and expertise in Google Cloud technologies.

...幫助您充分利用 Google Cloud 技術。我們的[課程](https://cloud.google.com/training/courses)涵蓋了技術技能和最佳實踐，能夠幫助您快速上手並持續學習。我們提供從基礎到高級的培訓課程，並有隨選、現場和虛擬選項以適應您的繁忙日程。[認證](https://cloud.google.com/certification/)能幫助您驗證和證明您在 Google Cloud 技術方面的技能和專業知識。


# 總結
今天跟大家分享 Google Cloud Skills Boost 中 Google Kubernetes Engine: Qwik Start 課程的操作過程，包括設置計算區域、創建 GKE 叢集、部署應用程式到叢集、獲取身份驗證憑證以及刪除叢集的步驟。

之後我還會持續練習 Qwiklabs 的內容並記錄分享給大家，如果有問題歡迎在部落格文章留言詢問。
