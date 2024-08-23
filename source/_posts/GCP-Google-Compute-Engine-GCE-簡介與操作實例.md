---
title: GCP - Google Compute Engine (GCE) 簡介與操作實例
date: 2024-08-23 10:24:19
tags:
    - GCP
    - 雲端服務
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/BJpQkdBoR.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

# Google Compute Engine 是什麼?

![image](https://hackmd.io/_uploads/BkfHy_rjA.png)

Google Compute Engine 是 GCP 的核心運算服務，專門提供可擴展的虛擬機器，讓企業能夠運行各種工作負載。Compute Engine 支援多種作業系統、機器類型與區域選擇，並能夠與其他 GCP 服務如 Cloud Storage 和 BigQuery 無縫整合，提供靈活且高效的雲端運算解決方案。

Google Compute Engine 的主要優勢包括：

1. **可擴展性**：無論是單一 VM 還是成千上萬的 VM，Compute Engine 都能夠快速部署並靈活應對工作負載的變化。
2. **自動化管理**：自動縮放、快照、備份和恢復等功能讓企業輕鬆管理和維護基礎架構。
3. **高效運行**：Compute Engine 提供多種機器類型，從一般用途到高性能運算，適應不同的計算需求。

![image](https://hackmd.io/_uploads/r1QhkdSoC.png)
>https://cloud.google.com/products/compute

# 如何在 GCP 中將 VM 複製到另一個專案並保留相同固定 IP?

![image](https://hackmd.io/_uploads/BJpQkdBoR.png)
在企業的業務連續性和災難恢復計畫中，維持關鍵系統的高可用性至關重要。GCP 平台提供了靈活的虛擬機（VM）管理功能，允許用戶將 VM 複製到其他專案，同時保留相同的固定 IP，從而確保網路配置的穩定性與一致性。本文將介紹如何在 GCP 中完成這一操作，並適用於備援環境的準備。

## 準備工作

在開始複製 VM 之前，請確保以下幾點：

- **權限檢查**：確認你在源專案和目標專案中擁有足夠的權限，尤其是跨專案操作的權限。
- **資源準備**：目標專案中是否已配置好必要的網路、子網和防火牆規則，以適應複製後的 VM。
- **IP 地址確認**：確保目標專案中沒有其他資源占用你打算保留的固定 IP。

# 跨專案複製 VM 的步驟

## 創建 VM 映像
首先，我們需要將源 VM 打包成映像，以便在目標專案中創建新的 VM。

```bash
gcloud compute images create my-vm-image \
  --source-disk=my-source-vm \
  --source-disk-zone=us-central1-a \
  --family=my-vm-family
```

## 將映像複製到目標專案
接下來，我們需要將映像共享給目標專案，然後在目標專案中使用該映像創建 VM。

```bash
gcloud compute images add-iam-policy-binding my-vm-image \
  --member='user:target-project-user@example.com' \
  --role='roles/compute.imageUser'
```

## 在目標專案中創建新的 VM
使用複製的映像在目標專案中創建 VM：

```bash
gcloud compute instances create my-new-vm \
  --image=my-vm-image \
  --zone=us-central1-b \
  --project=target-project-id
```

# 保留與配置相同的固定 IP

## 釋放原專案中的固定 IP
在源專案中釋放該固定 IP，並將其設置為共享狀態，這樣在目標專案中可以重新綁定。

```bash
gcloud compute addresses delete my-vm-ip \
  --region=us-central1 \
  --project=source-project-id
```

## 在目標專案中重新分配固定 IP
將相同的 IP 地址分配給目標專案中的新 VM：

```bash
gcloud compute addresses create my-vm-ip \
  --addresses=EXTERNAL_IP_ADDRESS \
  --region=us-central1 \
  --project=target-project-id
```

# 測試與驗證

當所有配置完成後，務必進行測試以確保 VM 能夠正常運行並成功使用所保留的固定 IP。可以進行以下測試：

- **Ping 測試**：檢查新 VM 是否可以通過固定 IP 回應請求。
- **連線測試**：驗證服務端口是否能正常連接。

# 最佳實踐與注意事項

- **定期演練**：為了確保備援環境的有效性，建議定期演練整個流程並進行必要的調整。
- **監控和日誌**：利用 GCP 的監控和日誌工具，實時監控系統健康狀況並快速應對問題。

# 結語

通過在 GCP 中將 VM 複製到不同專案並保留相同的固定 IP，企業能夠更有效地管理備援環境，提升系統的容錯能力和業務連續性。這一流程不僅簡化了災難恢復的操作，還確保了網路配置的一致性，是確保高可用性的最佳選擇之一。
