---
title: Gnosis Safe 多簽核錢包使用紀錄
date: 2024-05-17 15:08:07
tags:
    - Gnosis Safe
    - 多簽核
    - 區塊練
    - MetaMask
---

# Gnosis Safe 多簽核錢包使用紀錄

![image](https://hackmd.io/_uploads/BJLUKwNmA.png)


## 什麼是 多簽核錢包 - Multi-sig Wallet
多簽核錢包（Multi-sig Wallet）是一種加密貨幣錢包，它需要多個簽名（多個人或設備的授權）才能執行交易。
這樣的設計提高了資金的安全性和管理的靈活性。簡單來說，這種錢包類似於銀行的聯名帳戶，需要多方同意(例如公司老闆、會計同意後)才能使用資金。


### 特性
* 多重簽名：交易需要多個授權（如2個或3個）才能完成，而不是單一的私鑰。
* 增加安全性：即使某一個私鑰被盜，黑客無法單獨轉移資金。
* 協作管理：適合團隊或公司共同管理資金，防止單人濫用權力。

### 應用情境

* 家庭理財：夫妻共同管理，避免單方面亂花錢。
* 公司財務：需要多個主管批准，確保每筆開支都經過審核。
* 合作投資：投資者共同管理資金，確保透明和安全。


## Multi-sig Wallet 的用途
多簽核錢包（Multi-sig Wallet）的用途主要是提高資金的安全性和管理的靈活性。這種錢包需要多個簽名（多方授權）才能執行交易，確保資金不會被單一個人或設備濫用。

這樣的設計讓資金管理更安全、更透明，同時也降低了單一個人私鑰洩漏的風險。

### 提高安全性
* 防止盜竊：即使黑客獲得了一個私鑰，也無法單獨轉移資金，因為需要多個簽名。
* 分散風險：多個私鑰存放在不同地方或由不同人管理，減少單點故障風險。

### 團隊管理
* 公司財務：公司可以設置多個主管需要共同批准才能執行資金轉移，確保每筆開支都經過審核。
* 合作投資：投資者可以共同管理投資資金，確保每筆交易都透明且經過多方同意。

### 家庭理財
* 聯名帳戶：夫妻或家庭成員共同管理家庭資金，防止單方濫用。

### 智能合約
* 去中心化應用：在區塊鏈上的智能合約可以利用多簽核機制來確保合約執行的安全性和可靠性。

## 什麼是 Gnosis Safe

Gnosis Safe 是支援多條 EVM chains，也是目前市佔率最大，最受信任的一款智能合約錢包。
![image](https://hackmd.io/_uploads/BkgjKwEmR.png)

![image](https://hackmd.io/_uploads/B1KjYDN7A.png)
>參考來源:https://johnny-chuang.medium.com/gnosis-safe-%E5%A4%9A%E7%B0%BD%E9%8C%A2%E5%8C%85%E4%BD%BF%E7%94%A8%E6%95%99%E5%AD%B8-aeed1b9b36bd

Gnosis Safe 是一種多簽錢包，提供高安全性並與多種硬件錢包和熱錢包相容。其核心功能之一是使用多簽名機制，例如常見的 2/3 簽名機制。

這意味著在三個錢包中，至少需要兩個簽名才能執行交易。

這種設置顯著提高了安全性，即使其中一個熱錢包的私鑰被盜，駭客仍需要再取得一個冷錢包的私鑰才能完成交易，增加了攻擊難度。

此外，Gnosis Safe 可以輕鬆與 DeFi 協議交互，支援 ERC-721 和 ERC-1155 標準的 NFT tokens，使用戶在享有高安全性的同時，能順暢地進行鏈上交互和資產儲存。

這樣的設計確保了用戶資產的安全性和靈活性，非常適合需要高安全性的個人和團體使用。

## 實際操作

### 創建 Gnosis Safe Wallet

首先，先到 Gnosis Safe 的網站
![image](https://hackmd.io/_uploads/HyvpFv4QC.png)
>https://safe.global/wallet

點選 Launch Wallet
![image](https://hackmd.io/_uploads/SkKCFP4XR.png)

點選 Connect wallet
![image](https://hackmd.io/_uploads/B1SJcv4XA.png)

選擇 MetaMask
![image](https://hackmd.io/_uploads/rJpe9vE7A.png)

接下來小狐狸會跳出來
![image](https://hackmd.io/_uploads/ryc5qDEQA.png)
>點選下一頁


選擇連線
![image](https://hackmd.io/_uploads/HkOJjPE70.png)

![image](https://hackmd.io/_uploads/B1BuiDNmR.png)

這邊選擇好錢包名稱後按 Next
![image](https://hackmd.io/_uploads/HJX2iP4XA.png)

這邊的 Signer 代表多簽核人員
Threshold 代表設定一筆交易需要多少個 confirmation 才會上到鏈上

![image](https://hackmd.io/_uploads/BkG_hw4m0.png)


![image](https://hackmd.io/_uploads/H1y0hP4Q0.png)
>小狐狸連動確認畫面

![image](https://hackmd.io/_uploads/H1V-avE7C.png)
> 創建成功的畫面


# 這邊就是一個多簽核錢包
![image](https://hackmd.io/_uploads/SyP8aPEQA.png)


# 測試出金
![image](https://hackmd.io/_uploads/r1DeetEX0.png)
>點選 Send 發起一筆出金

![image](https://hackmd.io/_uploads/HyGNeYN7R.png)
>這邊選擇Send Tokens

![image](https://hackmd.io/_uploads/S19PeKVXA.png)
>輸入地址與金額後點擊Sign發起出金

![image](https://hackmd.io/_uploads/H1XaeKE70.png)
> 會跳出小狐狸確認畫面，選擇簽屬

![image](https://hackmd.io/_uploads/HkVM-KE7C.png)
>這邊可以看到簽核過程

![image](https://hackmd.io/_uploads/r1_Bbt4mA.png)
>滿足簽核條件後會進入交易流程

![image](https://hackmd.io/_uploads/B1BFbFEXA.png)
>交易成功可以瀏覽當時的交易紀錄

# 參考資料 
- [Gnosis Safe 多簽錢包使用教學](https://johnny-chuang.medium.com/gnosis-safe-%E5%A4%9A%E7%B0%BD%E9%8C%A2%E5%8C%85%E4%BD%BF%E7%94%A8%E6%95%99%E5%AD%B8-aeed1b9b36bd)
- [Gnosis Safe 教程](https://nextrope.com/how-to-create-a-multisig-wallet-using-gnosis-safe/)
- [Gnosis Safe 官方網站](https://safe.global)
- [CoinGecko 關於 Gnosis Safe 的介紹](https://www.coingecko.com)