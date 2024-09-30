---
title: GCP - 深入解讀 GKE Kubernetes 中的 Service 概念與應用
date: 2024-09-30 10:58:11
tags:
    - GCP
    - 雲端服務
    - Kubernetes
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/HyRbG9w0A.png 
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

![image](https://hackmd.io/_uploads/HyRbG9w0A.png)


今天要來跟大家分享Kubernetes的 Service設定，這篇是我在學習Kubernetes的時候看到官方文件的資料整理。

在 Kubernetes 中，Service 是一個重要的資源，它提供了一個抽象層，將動態變化的 Pod 集合與外部或內部網路的請求進行連接。

在 Google Kubernetes Engine (GKE) 上使用 Service，可以讓我們更靈活地管理和分配應用的流量，並提升應用的可用性和擴展性。

本文將帶你深入了解 Kubernetes Service 的類型、其如何運作，以及在 GKE 上如何使用這些 Service。

以下是官方Kubernetes 的服務介紹文件
![image](https://hackmd.io/_uploads/rkwgatD0C.png)
> https://kubernetes.io/zh-cn/docs/concepts/services-networking/service/#type-clusterip

## 什麼是 Kubernetes Service？

Kubernetes 中的 Pod 是應用程序的基本運行單元，但 Pod 的生命週期短暫，IP 地址會隨著創建和刪除而不斷變動。為了解決這個問題，Kubernetes 引入了 Service 概念。Service 是一個穩定的網路實體，能夠自動為一組動態變化的 Pod 提供固定的網路訪問路徑。這使得即使 Pod 被重建或移動，應用也能保持連續的服務。

## Kubernetes Service 的類型

Kubernetes 提供了多種不同類型的 Service，每一種類型都有其特定的應用場景。以下是主要的 Service 類型：

### 1. **ClusterIP**
   這是 Kubernetes 中的預設 Service 類型。ClusterIP 為 Service 分配一個集群內部的 IP 地址，僅允許集群內部的 Pod 之間進行通訊。這種 Service 適合內部應用之間的互相調用，而不需要暴露給外部。

### 2. **NodePort**
   NodePort 將 Service 暴露在每個節點的特定端口上，允許外部通過節點的 IP 地址和端口號來訪問服務。
   這種方式非常簡單，但如果應用需要高流量或高可用性時，則需要配合其他負載平衡技術。

以下是`type: NodePort`服務的清單範例，其中指定了NodePort 值（在本例中為30007）：

```
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: NodePort
  selector:
    app.kubernetes.io/name: MyApp
  ports:
    # 默認情況下，為了方便起見，`targetPort` 被設置為與 `port` 欄位相同的值。
    - port: 80
      targetPort: 80
      # 可選欄位
      # 默認情況下，為了方便起見，Kubernetes 控制平面會從某個範圍內分配一個端口號
      #（默認：30000-32767）
      nodePort: 30007
```


### 3. **LoadBalancer**
   LoadBalancer 主要用於雲環境中，它會為每個 Service 創建一個雲端提供的負載平衡器（如 GCP 的 LoadBalancer），並自動分配一個外部 IP 地址，方便外部流量直接訪問。這是大多數公有雲平台上應用最廣泛的 Service 類型之一，特別適合需要對外提供服務的應用。

以下是官方的使用範例:
```
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app.kubernetes.io/name: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376
  clusterIP: 10.0.171.239
  type: LoadBalancer
status:
  loadBalancer:
    ingress:
    - ip: 192.0.2.127
```

### 4. **ExternalName**
   ExternalName 讓 Service 能夠將請求轉發到集群外部的 DNS 名稱。這類 Service 尤其適合集群中的應用需要訪問外部資源時使用。

例如，下列Service 定義將prod名字空間中的my-service服務對應到 `my.database.example.com`：


```
apiVersion: v1
kind: Service
metadata:
  name: my-service
  namespace: prod
spec:
  type: ExternalName
  externalName: my.database.example.com
```

## Service 與 Pod 的連結

Kubernetes 使用 Label Selector 將 Service 與一組特定的 Pod 連結在一起。當一個 Service 創建後，會根據 Pod 的標籤來選擇對應的 Pod，並動態維護這些 Pod 的列表。這樣即使 Pod 發生變更，Service 仍然能夠自動更新其連接的目標，保持應用的正常運行。

此外，Service 會創建一個名為 Endpoints 的資源，記錄與該 Service 連接的 Pod 的實際 IP 地址。這樣，當流量到達 Service 時，Kubernetes 會根據 Endpoints 將流量正確地分發到對應的 Pod。

以下是 Kubernetes Service 類型的官方說明文件
![image](https://hackmd.io/_uploads/HJZqTYwRC.png)
>https://kubernetes.io/zh-cn/docs/concepts/services-networking/service/#publishing-services-service-types

## GKE 中的 Service 運作方式

在 GKE 上，使用 Service 更加簡單和高效。當你在 GKE 上創建一個 LoadBalancer 類型的 Service 時，GCP 會自動創建一個對應的雲端負載平衡器，並分配一個外部 IP 地址。這樣的整合大大簡化了應用對外提供服務的配置過程，讓你無需手動配置複雜的負載平衡器。

GKE 還提供了 Internal LoadBalancer，讓你可以僅在 VPC 內部使用負載平衡器，這對於內部流量管理和安全隔離來說非常重要。

## 實際應用場景

以下是一些 Kubernetes Service 的常見應用場景：

1. **NodePort 開放外部訪問**：如果你希望將應用程序暴露給外部訪問，但又不想使用負載平衡器，可以選擇 NodePort 類型的 Service。這種方法雖然簡單，但不適合處理大量流量。
   
2. **使用 LoadBalancer 支援高可用性**：當應用需要對外提供高流量或高可用性的服務時，LoadBalancer 是最佳選擇。它能夠自動調整流量並確保應用在多個節點之間進行負載均衡。

3. **選擇合適的 Service 類型**：在 Kubernetes 中選擇合適的 Service 類型至關重要。對於內部服務，可以選擇 ClusterIP 或 Internal LoadBalancer，而對於需要暴露給外部的應用，則應使用 LoadBalancer 以提供穩定的外部訪問路徑。

## Service 與 Ingress 的區別

Service 和 Ingress 常常一起使用，但它們在 Kubernetes 中的角色有所不同。Service 主要負責將流量分發給特定的一組 Pod，而 Ingress 則是一種更高層次的資源，提供了基於路徑的流量管理功能。例如，Ingress 可以根據 URL 路徑或主機名將請求轉發到不同的 Service，這對於實現複雜的流量路由非常有用。

## 結論

Kubernetes Service 是管理和分發網路流量的核心組件，尤其是在 GKE 這樣的雲端環境中，它可以無縫整合 Google Cloud Platform 的負載平衡器服務。無論是內部應用還是對外的服務，Kubernetes Service 都能提供靈活且高效的解決方案，幫助開發者更好地管理應用的網路需求。

透過瞭解 Kubernetes Service 的各種類型和運作原理，你將能夠更好地設計和部署應用，確保在各種情境下，應用的可用性和性能都能夠得到充分保障。