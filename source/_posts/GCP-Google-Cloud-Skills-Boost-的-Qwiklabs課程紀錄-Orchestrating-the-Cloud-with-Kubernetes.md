---
title: GCP - Qwiklabs課程紀錄 Orchestrating the Cloud with Kubernetes
date: 2024-09-05 17:13:25
tags:
  - GCP
  - Kubernetes
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/rkwy8lD3A.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---


![image](https://hackmd.io/_uploads/rkwy8lD3A.png)

今天這篇文章是在記錄我練習Google Cloud Skills Boost 官方學習資源平台的過程，今天練習的課程是 Orchestrating the Cloud with Kubernetes，這個 實踐實驗室（Qwiklabs） 主題是在介紹 透過 Kubernetes 自動化調度管理雲端資源 功能。
![image](https://hackmd.io/_uploads/BJ42MxP3R.png)

# GSP021
![image](https://hackmd.io/_uploads/ry3n7gD2C.png)

# 總覽

Kubernetes 是開放原始碼專案 (可透過 kubernetes.io 存取)，能夠在許多不同環境中運作，包括筆記型電腦、高可用性的多節點叢集、公有雲、地端部署、虛擬機器和裸機環境。

在本研究室中，使用 Kubernetes Engine 等代管環境可讓您專心體驗 Kubernetes，不必費心設定基礎架構。Kubernetes Engine 是專用於部署容器化應用程式的代管環境。這項服務匯集了開發人員效率提升、資源效率、自動化作業和開放原始碼靈活性等方面的最新技術，有助於縮短上市時間。


{% note info simple %}
應用程式託管於 GitHub，並提供 12 因子應用程式範例。在本研究室中，將使用以下 Docker 映像檔：
* kelseyhightower/monolith：包含 Auth 和 Hello 服務的單體。
* kelseyhightower/auth：Auth 微服務，可為通過驗證的使用者產生 JWT 權杖。
* kelseyhightower/hello：Hello 微服務，會向通過驗證的使用者打招呼。
* nginx：Auth 和 Hello 服務的前端。
{% endnote %}

# 目標

* 使用 Kubernetes Engine 佈建完整的 Kubernetes 叢集。
* 使用 kubectl 部署及管理 Docker 容器。
* 使用 Kubernetes 的 Deployment 和 Service 將應用程式拆解成微服務。


# Google Kubernetes Engine

1. 在 Cloud Shell 環境中，輸入以下指令來設定可用區：
```
gcloud config set compute/zone us-central1-c
```

2. 啟動要使用的cluster：
```
gcloud container clusters create io --zone us-central1-c
```

# 工作 1：取得程式碼範例
1. 從 Cloud Shell 指令列複製原始碼：
```
gsutil cp -r gs://spls/gsp021/* .
```
2. 變更為本研究室所需的目錄：

```
cd orchestrate-with-kubernetes/kubernetes
```
3. 列出檔案以便查看：

```
ls
```

# 工作 2：Kubernetes 快速示範
如要開始使用 Kubernetes，最簡單的方法是運用 `kubectl create` 指令。

1. 使用這項指令啟動 nginx 容器的單一執行個體：

```
kubectl create deployment nginx --image=nginx:1.10.0
```

Kubernetes 已建立 Deployment。稍後會再針對 Deployment 進行說明，目前您只需要知道 Deployment 可讓 Pod 保持運作，即使執行 Pod 的節點發生問題也沒關係。

Kubernetes 中的所有容器都是透過 Pod 執行。

2. 使用 `kubectl get pods` 指令查看運作中的 nginx 容器：

```
kubectl get pods
```

3. nginx 容器處於「運作中」狀態後，您就可以使用 kubectl expose 指令，在 Kubernetes 外部公開該容器：

```
kubectl expose deployment nginx --port 80 --type LoadBalancer
```

4. 使用 `kubectl get services` 指令列出服務：
```
kubectl get services
```
{% note info simple %}
「ExternalIP」欄位可能需要幾秒鐘才會填入服務的外部 IP 位址。這是正常現象，只要每隔幾秒重新執行 kubectl get services 指令，直到該欄位填入位址即可。
{% endnote %}

5. 在這項指令中加入外部 IP，從遠端連至該 Nginx 容器：

```
curl http://<External IP>:80
```

![image](https://hackmd.io/_uploads/HkOmZA8hC.png)

![image](https://hackmd.io/_uploads/BJ-SW0U2A.png)

# 工作 3：Pod
Kubernetes 的核心是 [Pod](https://kubernetes.io/docs/concepts/workloads/pods/)。

Pod 代表並存放了一或多個容器。一般來說，如果多個容器之間有硬相依性，就可以包裝在同一個 Pod 中。

![image](https://hackmd.io/_uploads/H1wD-RLn0.png)

這個範例中有一個包含單體和 nginx 容器的 Pod。

Pod 也有[磁碟區](https://kubernetes.io/docs/concepts/storage/volumes/)。磁碟區是效期與 Pod 相同的資料磁碟，可由該 Pod 中的容器使用。Pod 為所含內容提供共用命名空間，因此範例 Pod 中的兩個容器可互相通訊，並且共用所連接的磁碟區。

不同的 Pod 還會共用網路命名空間，因此每個 Pod 都有一個 IP 位址。

接著讓我們來深入瞭解 Pod。

# 工作 4：建立 Pod
Pod 可使用 Pod 設定檔建立。請花點時間瞭解單體 Pod 設定檔。
1.前往目錄：
```
cd ~/orchestrate-with-kubernetes/kubernetes
```

2.執行以下指令：
```
cat pods/monolith.yaml
```

![image](https://hackmd.io/_uploads/Sk2CbRI3A.png)

輸出結果會顯示公開設定檔：
```
apiVersion: v1
kind: Pod
metadata:
  name: monolith
  labels:
    app: monolith
spec:
  containers:
    - name: monolith
      image: kelseyhightower/monolith:1.0.0
      args:
        - "-http=0.0.0.0:80"
        - "-health=0.0.0.0:81"
        - "-secret=secret"
      ports:
        - name: http
          containerPort: 80
        - name: health
          containerPort: 81
      resources:
        limits:
          cpu: 0.2
          memory: "10Mi"
```

這裡有幾點要注意。從輸出結果可看出：

* Pod 包含一個容器 (單體)。
* 您在容器啟動時傳遞了幾個引數至容器。
* 您開啟了用於 http 流量的通訊埠 80。

3. 使用 `kubectl` 建立單體 Pod：

```
kubectl create -f pods/monolith.yaml
```
![image](https://hackmd.io/_uploads/B1iVz08hA.png)


4. 檢查 Pod。請使用 `kubectl get pods` 指令列出在預設命名空間中運作的所有 Pod：

```
kubectl get pods
```

![image](https://hackmd.io/_uploads/rJ-IMC83R.png)

{% note info simple %}
單體 Pod 可能需要幾秒鐘才會開始運作。單體容器映像檔必須先從 Docker Hub 提取出來才能執行。
{% endnote %}

5. Pod 開始運作後，請使用 `kubectl describe` 指令取得更多有關該單體 Pod 的資訊：

```
kubectl describe pods monolith
```

您會看到許多關於該單體 Pod 的資訊，包括 Pod 的 IP 位址和事件記錄。這些資訊在疑難排解時可派上用場。

![image](https://hackmd.io/_uploads/HkVe7A8n0.png)

Kubernetes 可根據設定檔中的描述建立 Pod，並讓您在 Pod 運作時輕鬆查看相關資訊。到了這個階段，您已經可以建立 Deployment 所需的所有 Pod！


# 工作 5：與 Pod 互動

根據預設，Pod 會獲分配私人 IP 位址，且無法從叢集外部連線。請使用 `kubectl port-forward` 指令將本機通訊埠對應至單體 Pod 內部的通訊埠。

{% note info simple %}
在本研究室的後續部分中，您必須透過多個 Cloud Shell 分頁設定 Pod 之間的通訊。如果指令是透過第二或第三個指令殼層執行，則會在指令的操作說明中標示。
{% endnote %}

1. 開啟第二個 Cloud Shell 終端機。您現在有兩個終端機，分別用於執行 `kubectl port-forward` 指令及下達 `curl` 指令。

![image](https://hackmd.io/_uploads/Hk44Q0I3C.png)

2. 在第 2 個終端機中，執行以下指令來設定通訊埠轉送：

```
kubectl port-forward monolith 10080:80
```

![image](https://hackmd.io/_uploads/BytLXAInC.png)

3.接著在第 1 個終端機中使用 curl 開始與 Pod 通訊：
```
curl http://127.0.0.1:10080
```
![image](https://hackmd.io/_uploads/rJItmCI3A.png)

很好！容器傳回了友善的回應：「Hello」。

4. 接著使用 `curl` 指令，看看連到安全端點時會發生什麼事：

```
curl http://127.0.0.1:10080/secure
```

![image](https://hackmd.io/_uploads/SJe6XAI3C.png)

糟糕！

5. 嘗試登入，從單體取回驗證權杖：

```
curl -u user http://127.0.0.1:10080/login
```
![image](https://hackmd.io/_uploads/SJgmHVA8nC.png)

6. 畫面上顯示登入提示時，使用密碼登入。
![image](https://hackmd.io/_uploads/rypEHRIhR.png)
這邊的密碼在這邊

7. 由於 Cloud Shell 無法妥善複製較長的字串，因此請為權杖建立環境變數。

```
TOKEN=$(curl http://127.0.0.1:10080/login -u user|jq -r '.token')
```

![image](https://hackmd.io/_uploads/HJvYHCI2A.png)

8. 系統提示您輸入主機密碼時，再次輸入密碼。
9. 使用以下指令複製權杖，並透過 `curl` 使用該權杖連至安全端點：
```
curl -H "Authorization: Bearer $TOKEN" http://127.0.0.1:10080/secure
```
應用程式應該會傳回回應，讓我們知道一切都運作正常。

10. 使用 `kubectl logs` 指令查看 `monolith` Pod 的記錄。

```
kubectl logs monolith
```

![image](https://hackmd.io/_uploads/r13L8AIn0.png)

11. 開啟第 3 個終端機，並使用 -f 標記取得即時記錄串流：

```
kubectl logs -f monolith
```
![image](https://hackmd.io/_uploads/BkB9LRL3C.png)


12. 如果您在第 1 個終端機中使用 curl 與單體互動，記錄就會在第 3 個終端機中更新：

```
curl http://127.0.0.1:10080
```

![image](https://hackmd.io/_uploads/Bk5hI0Ln0.png)

![image](https://hackmd.io/_uploads/BkhTUAUnR.png)

13.使用 `kubectl exec` 指令在單體 Pod 內執行互動式殼層。如要在容器內進行疑難排解，這個殼層就能派上用場：
```
kubectl exec monolith --stdin --tty -c monolith -- /bin/sh
```

![image](https://hackmd.io/_uploads/rkS7D0L30.png)

14. 舉例來說，在單體容器中建立殼層後，您就能使用 ping 指令測試外部連線：
```
ping -c 3 google.com
```

![image](https://hackmd.io/_uploads/SydLw08hR.png)

15.使用完這個互動式殼層後，請務必登出。
```
exit
```

![image](https://hackmd.io/_uploads/Hy8KvA8hA.png)

如您所見，只要使用 `kubectl` 指令，就能輕鬆與 Pod 互動。如需從遠端連至容器，或是取得登入殼層，Kubernetes 提供所有必要資源。

# 工作 6：Service

Pod 不會永久有效，可能會因許多因素停止或啟動 (例如未通過有效性或完備性檢查)，進而造成一個問題：

與一組 Pod 通訊會發生什麼情形？這些 Pod 重新啟動時可能會有不同的 IP 位址。

在這種時候，[Service](https://kubernetes.io/docs/concepts/services-networking/service/) 便能派上用場。Service 可為 Pod 提供穩定的端點。

![image](https://hackmd.io/_uploads/HkHnwRI3R.png)

Service 會根據標籤決定要在哪個 Pod 上運作。如果 Pod 的標籤正確，Service 就會自動辨識並公開 Pod。

Service 為一組 Pod 提供的存取層級取決於 Service 類型。目前 Service 分為以下三種：

* ClusterIP (內部)：這是預設類型，表示這項 Service 只會在叢集內部顯示
* NodePort：為叢集中的每個節點提供可從外部存取的 IP
* LoadBalancer：新增雲端服務供應商的負載平衡器，用於將 Service 的流量轉送至當中的節點

接下來您將瞭解如何：

* 建立 Service
* 使用標籤選取器，對外公開一部分的 Pod

# 工作 7：建立 Service

在建立 Service 前，請先建立可處理 https 流量的安全 Pod。

1. 如果您變更了目錄，請務必返回 `~/orchestrate-with-kubernetes/kubernetes` 目錄：

```
cd ~/orchestrate-with-kubernetes/kubernetes
```

2. 查看單體 Service 設定檔：

```
cat pods/secure-monolith.yaml
```

![image](https://hackmd.io/_uploads/S1a6OAI3C.png)

3. 建立安全單體 Pod 及其設定資料：
```
kubectl create secret generic tls-certs --from-file tls/
kubectl create configmap nginx-proxy-conf --from-file nginx/proxy.conf
kubectl create -f pods/secure-monolith.yaml
```

您已建立安全的 Pod，接著要對外公開安全單體 Pod。為此，請建立 Kubernetes Service。

![image](https://hackmd.io/_uploads/SyXWYA830.png)


4. 查看單體 Service 設定檔：

```
cat services/monolith.yaml
```
輸出內容：
```
kind: Service
apiVersion: v1
metadata:
  name: "monolith"
spec:
  selector:
    app: "monolith"
    secure: "enabled"
  ports:
    - protocol: "TCP"
      port: 443
      targetPort: 443
      nodePort: 31000
  type: NodePort
```

![image](https://hackmd.io/_uploads/BJbQtCIhC.png)

{% note info simple %}
注意事項：
* 輸出內容包含選取器，用來自動尋找及公開含有「app: monolith」和「secure: enabled」標籤的 Pod。

* 現在您必須公開節點通訊埠，這樣才能將外部流量從通訊埠 31000 轉送至位於通訊埠 443 的 nginx。
{% endnote %}

5. 使用 `kubectl create` 指令，透過單體 Service 設定檔建立單體 Service：

```
kubectl create -f services/monolith.yaml
```

輸出內容：
```
service/monolith created6
```

![image](https://hackmd.io/_uploads/B1zUYRU3A.png)


測試已完成的工作

請點選下方的「Check my progress」，確認您的研究室進度。如果您已成功建立單體 Pod 和 Service，就會看到評量分數。
![image](https://hackmd.io/_uploads/B1Jj_C830.png)

您是使用通訊埠公開 Service，因此如果其他應用程式嘗試繫結至其中一個伺服器的通訊埠 31000，可能會發生通訊埠衝突。

在一般情況下，Kubernetes 會處理通訊埠指派作業，但在本研究室中，您自行選擇了通訊埠，以便之後設定健康狀態檢查。

6. 使用 `gcloud compute firewall-rules` 指令，允許流量傳送到公開節點通訊埠上的單體 Service：
```
gcloud compute firewall-rules create allow-monolith-nodeport \
  --allow=tcp:31000
```

![image](https://hackmd.io/_uploads/Byc3tAU3C.png)

測試已完成的工作
請點選下方的「Check my progress」，確認您的研究室進度。如果您已成功建立防火牆規則來允許通訊埠 31000 的 TCP 流量，就會看到評量分數。

![image](https://hackmd.io/_uploads/HJVoY08n0.png)

一切都設定完成後，您應該就能從叢集外部連至安全單體 Service，不必使用通訊埠轉送。

1. 首先，取得其中一個節點的外部 IP 位址。

```
gcloud compute instances list
```
![image](https://hackmd.io/_uploads/r1EQ508nA.png)

2. 接著使用 curl 嘗試連至安全單體 Service：

```
curl -k https://<EXTERNAL_IP>:31000
```

![image](https://hackmd.io/_uploads/HyPDqCU2A.png)


糟糕！作業逾時。發生了什麼事？

{% note info simple %}
附註：來驗收一下您的學習成果吧。

請使用以下指令回答下方問題：
kubectl get services monolith

kubectl describe services monolith

問題：

為何單體 Service 無法傳回回應？
單體 Service 有幾個端點？
Pod 必須有哪些標籤，單體 Service 才能辨識？
{% endnote %}

提示：關鍵在於標籤。您將在下一節修正錯誤。

# 工作 8：為 Pod 新增標籤

目前單體 Service 沒有端點。如要排解這類問題，其中一個方法是使用 `kubectl get pods` 指令和標籤查詢。

1.您會發現有幾個包含單體標籤的 Pod 正在運作。
```
kubectl get pods -l "app=monolith"
```

![image](https://hackmd.io/_uploads/Sy-3qRIhA.png)


2.但如果是「app=monolith」和「secure=enabled」呢？
```
kubectl get pods -l "app=monolith,secure=enabled"
```
![image](https://hackmd.io/_uploads/By3aqAIhA.png)

您會發現這個標籤查詢並未顯示任何結果。您似乎需要加上「secure=enabled」標籤。

3. 使用 `kubectl label` 指令，為安全單體 Pod 新增缺少的 `secure=enabled` 標籤。完成後，您可以確認標籤是否已更新。

```
kubectl label pods secure-monolith 'secure=enabled'
kubectl get pods secure-monolith --show-labels
```

![image](https://hackmd.io/_uploads/HJY-jRI2C.png)


4. 為 Pod 加上正確標籤後，請查看單體 Service 的端點清單：
```
kubectl describe services monolith | grep Endpoints
```
![image](https://hackmd.io/_uploads/HyX4oC8hC.png)

5. 再次連到其中一個節點進行測試。

```
gcloud compute instances list
curl -k https://<EXTERNAL_IP>:31000
```

![image](https://hackmd.io/_uploads/SJSDoAIhA.png)

測試已完成的工作
請點選下方的「Check my progress」，確認您的研究室進度。如果您已成功為單體 Pod 新增標籤，就會看到評量分數。
![image](https://hackmd.io/_uploads/SyW_oA8hR.png)


# 工作 9：透過 Kubernetes 部署應用程式

本研究室的目標是協助您做好準備，以便在實際工作環境中調度資源及管理容器。在這種時候，[Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#what-is-a-deployment) 便能派上用場。Deployment 可透過宣告方式，確保運作中的 Pod 數量與使用者指定的所需 Pod 數量相同。

![image](https://hackmd.io/_uploads/Hk15oR8h0.png)

Deployment 的主要好處在於簡化了 Pod 管理作業的低層級細節。Deployment 實際上會使用 [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) 來啟動及停止 Pod。如果 Pod 需要更新或調度資源，Deployment 就會處理。假如 Pod 因故停止運作，Deployment 也可重新啟動 Pod。

請查看以下簡短範例：

![image](https://hackmd.io/_uploads/SkS3iRIhR.png)


Pod 的生命週期取決於建立時所在的節點。在上方範例中，Node3 已停止運作，並連帶使一個 Pod 停止運作。在這個情況下，Deployment 建立了新的 Pod 並在 Node2 上啟動該 Pod，因此您不必手動建立新的 Pod 及尋找節點。

很方便吧！

接著來運用您學到的所有 Pod 和 Service 相關知識，使用 Deployment 將單體式應用程式拆解成較小的 Service。

# 工作 10：建立 Deployment
您要將單體式應用程式拆解成三個不同的部分：

* Auth：為通過驗證的使用者產生 JWT 權杖。
* Hello：向通過驗證的使用者打招呼。
* Frontend：將流量轉送至 Auth 和 Hello Service。

您現在可以為每項 Service 分別建立 Deployment。之後，您將為 Auth 和 Hello Deployment 定義內部 Service，並為 Frontend Deployment 定義外部 Service。完成後，您就能像處理單體一樣與微服務互動，只不過每項微服務都能獨立調度資源和部署！

1.首先檢查 Auth Deployment 設定檔。

```
cat deployments/auth.yaml
```
輸出內容

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: auth
spec:
  selector:
    matchlabels:
      app: auth
  replicas: 1
  template:
    metadata:
      labels:
        app: auth
        track: stable
    spec:
      containers:
        - name: auth
          image: "kelseyhightower/auth:2.0.0"
          ports:
            - name: http
              containerPort: 80
            - name: health
              containerPort: 81
...
```

Deployment 建立了 1 個備用資源，而您使用的是 2.0.0 版的 Auth 容器。

執行 `kubectl create` 指令來建立 Auth Deployment 時，會產生一個符合 Deployment 資訊清單資料的 Pod。這表示您可以變更「Replicas」欄位指定的數字來調整 Pod 數量。

2.總之，請建立 Deployment 物件：
```
kubectl create -f deployments/auth.yaml
```

3. 接著來建立 Auth Deployment 的 Service。使用 kubectl create 指令建立 Auth Service：

```
kubectl create -f services/auth.yaml
```

4. 現在使用相同指令來建立並公開 Hello Deployment：

```
kubectl create -f deployments/hello.yaml
kubectl create -f services/hello.yaml
```

5. 再次使用相同指令來建立並公開 Frontend Deployment：

```
kubectl create configmap nginx-frontend-conf --from-file=nginx/frontend.conf
kubectl create -f deployments/frontend.yaml
kubectl create -f services/frontend.yaml
```

{% note info simple %}
您必須透過容器儲存設定資料，因此要另外建立 Frontend。
{% endnote %}

6. 與 Frontend 互動，擷取其外部 IP 並執行 curl 指令：

```
kubectl get services frontend
```

![image](https://hackmd.io/_uploads/rkX52RL2R.png)

{% note info simple %}
外部 IP 位址可能需要一分鐘才能產生。如果 EXTERNAL-IP 欄狀態為「待處理」，請再次執行上方指令。
{% endnote %}

```
curl -k https://<EXTERNAL-IP>
```

您會收到「hello」回應！

測試已完成的工作
請點選下方的「Check my progress」，確認您的研究室進度。如果您已成功建立 Auth、Hello 和 Frontend Deployment，就會看到評量分數。

![image](https://hackmd.io/_uploads/HJZPhRIhA.png)

# 總結
這篇文章記錄在 Google Cloud Skills Boost 上學習 "Orchestrating the Cloud with Kubernetes" 的過程，並介紹了 Kubernetes 的基本概念與實際操作流程。內容涵蓋如何建立 Kubernetes 叢集、部署容器、與 Pod 互動等，使用 kubectl 指令來進行 Kubernetes 管理與資源操作。