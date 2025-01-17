---
title: 在 *Grafana* 中查詢 *InfluxDB* 資料庫中的 table（資料表）
date: 2025-01-17 09:53:34
tags:
    - Grafana
    - InfluxDB
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

在 **Grafana** 中查詢 **InfluxDB** 資料庫中的 table（資料表）需要先完成數據源的設定，然後使用正確的查詢語法來檢索資料。以下是詳細的步驟說明：

---

## **為什麼選擇 Grafana 與 InfluxDB？**
Grafana 是一款強大的開源數據可視化工具，InfluxDB 則是專門為時序數據設計的資料庫。兩者結合可以實現：
- 系統與應用的性能監控。
- 即時數據的可視化分析。
- 快速部署與靈活查詢。

無論是 DevOps、IoT，還是數據分析，這套組合都能滿足需求。

---

## **步驟 1：添加 InfluxDB 作為數據源**
1. **進入 Grafana 的設定頁面**：
   - 點擊左側的齒輪圖標（⚙️），選擇 **Data Sources**。

   ![Data Sources 設定頁面](https://hackmd.io/_uploads/BJMtZ4Pw1l.png)

2. **新增資料源**：
   - 點擊 **Add data source**，選擇 **InfluxDB**。

   ![選擇 InfluxDB 資料源](https://hackmd.io/_uploads/Hy9cb4Dvkl.png)

   ![選擇後的設定頁面](https://hackmd.io/_uploads/HkhjbVDDyg.png)

3. **設定資料源參數**：
   - **URL**：填寫 InfluxDB 的 HTTP API 位址（如 `http://localhost:8086`）。
   - **Database**：指定要查詢的 InfluxDB 資料庫名稱。
   - **Auth**：若使用者名稱與密碼已啟用，填寫相應的認證資訊。
   - **Query Language**：選擇正確的查詢語言：
     - **InfluxQL**（InfluxDB 1.x）。
     - **Flux**（InfluxDB 2.x）。
   - 點擊 **Save & Test** 確認連線成功。

   ![設定並測試連線](https://hackmd.io/_uploads/SyApZNvP1x.png)

**小提示**：確保 InfluxDB 服務正在運行，且 Grafana 能夠訪問正確的 URL。

---

## **步驟 2：建立面板並查詢資料**
1. **新增面板**：
   - 返回 Grafana 主頁，點擊 **Create → Dashboard → Add a new panel**。

   ![新增面板步驟](https://hackmd.io/_uploads/r1eefEvDkx.png)

   ![面板編輯畫面](https://hackmd.io/_uploads/rJk-fEDDkl.png)

2. **選擇資料源**：
   - 在面板的查詢設定區域，選擇剛剛新增的 **InfluxDB** 資料源。

   ![選擇資料源](https://hackmd.io/_uploads/BkcQMNvD1e.png)

3. **撰寫查詢語法**：
   - 根據 InfluxDB 的版本選擇合適的語法。

---

## **InfluxQL 查詢（InfluxDB 1.x）**
InfluxQL 是類似 SQL 的查詢語言，用於檢索時序數據。

### **基本查詢範例**
```sql
SELECT field1, field2 FROM measurement WHERE time > now() - 1h
```

#### **常用語法說明**
- `field1, field2`：要查詢的欄位名稱。
- `measurement`：資料表名稱（類似 SQL 的 table）。
- `time > now() - 1h`：篩選最近一小時內的資料。

#### **顯示所有 measurement 名稱**
```sql
SHOW MEASUREMENTS
```

#### **顯示某個 measurement 的欄位結構**
```sql
SHOW FIELD KEYS FROM measurement
```

#### **顯示資料庫中所有標籤（tags）**
```sql
SHOW TAG KEYS
```

**小提示**：在撰寫查詢語法時，可利用測試功能檢查語法是否正確。

---

## **Flux 查詢（InfluxDB 2.x）**
Flux 是功能更強大的查詢語言，適用於 InfluxDB 2.x。

### **基本查詢範例**
```flux
from(bucket: "example_bucket")
  |> range(start: -1h)
  |> filter(fn: (r) => r._measurement == "measurement")
  |> filter(fn: (r) => r._field == "field1" or r._field == "field2")
```

#### **常用語法說明**
- `bucket`：資料表所屬的 bucket 名稱。
- `range(start: -1h)`：篩選時間範圍（最近一小時）。
- `filter`：篩選條件，例如特定 measurement 或 field。

#### **顯示所有 bucket 名稱**
```flux
buckets()
```

#### **列出特定 bucket 的 schema**
```flux
import "influxdata/influxdb/schema"
schema.measurements(bucket: "example_bucket")
```

**小提示**：Flux 語法支援高度客製化，可針對複雜的需求進行數據處理。

---

## **步驟 3：調整面板設定**
1. **數據可視化**：
   - 選擇合適的圖表類型（如折線圖、柱狀圖）。
   
2. **格式化數據**：
   - 在 **Field** 區域調整資料格式，例如時間戳、單位等。

3. **應用並保存**：
   - 點擊 **Apply** 儲存面板設定。

**注意**：根據不同數據類型，選擇適合的可視化類型，能讓圖表更具可讀性。

---

## **結語**
在 Grafana 中查詢 InfluxDB table 主要是通過撰寫合適的查詢語法（InfluxQL 或 Flux）來檢索資料。根據 InfluxDB 的版本選擇語言，然後結合 Grafana 的可視化工具即可輕鬆展示資料。 

**小總結**：
- InfluxQL 適合簡單查詢，學習成本低。
- Flux 功能強大，適用於更複雜的數據處理需求。

希望這篇指南能幫助你更快上手！如有其他問題，請隨時聯繫我。

