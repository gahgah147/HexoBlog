---
title: 區塊鏈學習 - Day 1 區塊鏈錢包介紹與 Metamask小狐狸安裝方式
date: 2024-06-07 15:49:08
tags:
    - 區塊鏈
    - Metamask
    - ethereum
    - ETH
---
# 區塊鏈學習 - Day 1 區塊鏈錢包介紹與 Metamask小狐狸安裝方式

![image](https://hackmd.io/_uploads/SkSeMeeSR.png)
>https://ethereum.org/zh-tw/

今天想要來學習Web3 區塊鏈相關技術，另外在查詢的時候看到了etherum 這麼完整的教學文件，所以想來整理記錄一下這個學習的過程。

# 什麼是區塊鏈錢包?

區塊鏈錢包（Blockchain Wallet）是一種數位錢包，用於存儲、管理和交易加密貨幣，如比特幣、以太幣等。區塊鏈錢包的核心功能是讓用戶能夠安全地儲存和使用其加密貨幣。

## 區塊鏈錢包的基本特點

### 1. 公鑰與私鑰
區塊鏈錢包使用公鑰（Public Key）和私鑰（Private Key）來管理資產：
- **公鑰**：相當於你的銀行賬號，用來接收加密貨幣，可以公開分享。
- **私鑰**：相當於你的密碼，用來簽署交易和訪問你的資產，必須保密。

### 2. 熱錢包與冷錢包
區塊鏈錢包分為熱錢包和冷錢包：
- **熱錢包（Hot Wallet）**：連接互聯網，方便隨時交易，但相對較不安全，易受黑客攻擊。
- **冷錢包（Cold Wallet）**：不連接互聯網，通常以硬體錢包形式存在，如Trezor或Ledger，更安全但較不便捷。

### 3. 去中心化
區塊鏈錢包通常是去中心化的，不依賴於單一機構。這意味著用戶擁有對自己資產的完全控制權，無需經由第三方機構進行交易。

### 4. 多幣種支持
許多現代區塊鏈錢包支持多種加密貨幣，方便用戶管理不同的數位資產。

### 5. 智慧型合約型錢包
需要多重簽名來授權交易的錢包，若是多人使用的錢包可以用來加強錢包的安全性。

## 使用區塊鏈錢包的好處

### 1. 安全性
區塊鏈技術本身具有高度的安全性，加上錢包的加密保護，使得資產不易被盜。

### 2. 自主性
用戶完全掌控自己的資產和交易，不需要依賴銀行或支付平台。

### 3. 全球性
加密貨幣交易不受地理位置限制，可以在全球範圍內快速進行。

## 區塊鏈錢包的使用案例

### 1. 投資與交易
投資者使用區塊鏈錢包進行加密貨幣買賣，或長期持有以期望價值增長。

### 2. 支付與轉賬
使用加密貨幣進行線上購物或轉賬，特別是在國際支付中，可以避開高額手續費和匯率波動。

### 3. DApps互動
區塊鏈錢包可以用來與去中心化應用（DApps）互動，如去中心化交易所（DEX）、借貸平台等。

# 如何選擇合適的區塊鏈錢包?

其實現在的區塊鏈錢包越來越多了，如果想要選擇合適的區塊鏈錢包可以參考ethereum 官方的區塊鏈錢包選擇參考頁面。

![image](https://hackmd.io/_uploads/ByOJDJgBC.png)
>https://ethereum.org/zh-tw/wallets/find-wallet/

## 依照使用角色來選擇

![image](https://hackmd.io/_uploads/H1Rd5ylrC.png)

1.加密貨幣新手:初次使用者尋找適合新手的錢包。
2.非同質化代幣:專注於支援非同質化代幣的錢包。
3.長期:使用硬體錢包被動持有代幣。
4.金融:專為頻繁使用去中心化金融應用程式的使用者打造的錢包。
5.開發者:幫助開發並測試去中心化應用程式的錢包。

## 依照裝置支援性來選擇
![image](https://hackmd.io/_uploads/SJhPo1gS0.png)

1.行動裝置
2.桌上型電腦
3.瀏覽器
4.硬體

## 依照語言支援來選擇
![image](https://hackmd.io/_uploads/S1Zl2ylS0.png)

## 依照是否可以兌換加密貨幣/法定貨幣來選擇
![image](https://hackmd.io/_uploads/BJ4NTkxHA.png)

1.購買加密貨幣:在錢包中直接使用法定貨幣購買加密貨幣 
2.出售換取法定貨幣:直接在錢包中出售加密貨幣換取法定貨幣 

## 依照功能來選擇
![image](https://hackmd.io/_uploads/rJ-cpkxSA.png)

1.連結至去中心化應用程式:你可以連接至支援 WalletConnet 或替代協議的應用程式
2.支援非同質化代幣:支援檢視非同質化代幣並與之互動的錢包
3.質押:從錢包中直接質押以太幣
4.二層網路:支援以太坊二層網路的錢包
5.交換:在錢包中直接交換 ERC-20 代幣
6.支援硬體錢包:可連結至硬體錢包以增強安全性的錢包
7.支援以太坊名稱服務:支援以太坊名稱服務 (ENS) 的錢包

這邊開始出現很多新的名詞了像是質押、二層網路看到這些詞一開始看不懂先不用緊張，先從基礎的學習起來，後面會慢慢了解

## 依照安全性來選擇
![image](https://hackmd.io/_uploads/H1hWlggH0.png)

1.開放原始碼:讓任何人都可以稽核應用程式的完整性和安全性的開源軟體
2.個人擁有權:不控制使用者私密金鑰的錢包

## 依照是否是智能合約錢包來選擇
![image](https://hackmd.io/_uploads/SJILgglSA.png)
1.多簽:需要多重簽名來授權交易的錢包
2.社交恢復:允許監護人變更智慧型合約錢包簽署金鑰的錢包

## 進階更多條件來選擇
![image](https://hackmd.io/_uploads/SJmmZgerR.png)

1.遠端程序呼叫協定匯入:支援自訂遠端程序呼叫協定端點，以連結至不同節點或網路的錢包
2.代幣匯入:匯入任何 ERC-20 代幣以便於錢包內使用
3.燃料費自訂:自訂你的燃料用量（基本費用、優先費與最高費用）


# MetaMask 
![image](https://hackmd.io/_uploads/SkpIQeeSR.png)

這邊建議使用一開始學習的錢包MetaMask也叫做小狐狸錢包，是目前最多人使用的區塊鏈錢包，j最適合新手入門使用。

點選造訪網頁，會到MetaMask 官網
![image](https://hackmd.io/_uploads/BJ80VxxHC.png)
>https://metamask.io/

點選![image](https://hackmd.io/_uploads/rJMgBlxHR.png) 進入Chrome插件畫面

再來點選加到Chrome 開始安裝
![image](https://hackmd.io/_uploads/BkkHregB0.png)

點選新增擴充功能
![image](https://hackmd.io/_uploads/H12vSxeSA.png)

如果還沒有用過 Metamask 可以直接點選 Create a new Wallet ，若是有用過則可以點選Import an existing wallet 來匯入MetaMask錢包
![image](https://hackmd.io/_uploads/Hy9crgxr0.png)

接下來會顯示 MetaMask 詢問訊息，確認沒有問題可以點選I agree
![image](https://hackmd.io/_uploads/SJLwLeeS0.png)


>**幫助我們改進 MetaMask**
>
>MetaMask 希望收集使用數據，以更好地了解用戶如何使用 MetaMask。這些數據將用於改>進服務，包括基於您的使用情況進行改進。
>
>MetaMask 將會...
>
>- 永遠允許您通過設置選擇退出
>- 發送匿名化的點擊和頁面瀏覽事件
>- **絕不**收集我們不需要提供服務的信息（如密鑰、地址、交易哈希或餘額）
>- **絕不**收集您的完整 IP 地址
>- **絕不**出售數據
>
>這些數據是匯總的，因此根據《一般數據保護條例（EU）2016/679》對於數據是匿名的。
>
>*當您使用 Infura 作為 MetaMask 中的默認 RPC 提供商時，Infura 將會在您發送交易時收集您的 IP 地址和以太坊錢包地址。我們不會以使我們的系統能夠將這兩個數據關聯的方式存儲這些信息。更多關於 MetaMask 和 Infura 如何從數據收集的角度進行互動的信息，請參閱我們的更新。更多關於我們隱私實踐的一般信息，請參閱我們的[隱私政策](https://metamask.io/privacy.html)。*
>
>---

>這個窗口有兩個按鈕：
>- "I agree"（我同意）：表示您同意 MetaMask 收集和使用這些數據。
>- "No thanks"（不，謝謝）：表示您不願意參與數據收集。

再來會顯示設定密碼畫面，輸入密碼後點選Create a new wallet
![image](https://hackmd.io/_uploads/HJ7Fr4lHC.png)

接下來會介紹「助記詞」，並且詢問是否要備份註記詞
![image](https://hackmd.io/_uploads/SyOxUEgB0.png)

在來會顯示「助記詞」，要記得這個助記詞很重要，因為這些助記詞就代表你的MetaMask錢包，要妥善記錄下來保存在安全的地方。
![image](https://hackmd.io/_uploads/HJQYUVeSC.png)

再來正確輸入存起來的助記詞後點選下一步就完成創建錢包了
![image](https://hackmd.io/_uploads/HJKQO4lH0.png)

成功登入畫面
![image](https://hackmd.io/_uploads/HyS5dEgr0.png)

>以下是該介面的主要內容和功能說明：
> **帳戶信息**：
>   - 帳戶名稱：`Account 1`
>   - 錢包地址：`0x8753...1b2D4`（已部分隱藏）
>
> **以太幣餘額**：
>   - 餘額：`0 ETH`
>   - 美元價值：`$0.00 USD`
>
> **操作選項**：
>   - **Buy & Sell**（購買和出售）：購買和出售加密貨幣。
>   - **Swap**（交換）：在錢包中交換 ERC-20 代幣。
>   - **Bridge**（跨鏈橋）：將資產從一條鏈轉移到另一條鏈。
>   - **Portfolio**（投資組合）：查看和管理你的加密資產組合。
>
> **資金提示**：
>   - **Fund your wallet**：提示用戶為錢包添加資金，並提供購買以太幣（ETH）的選項。
>   - 按鈕：`Buy ETH`（購買 ETH）
>
> **代幣選項**：
>   - **ETH**（以太幣）：
>     - **Stake**（質押）：選項來質押以太幣。
>   - **Receive tokens**（接收代幣）：提供地址來接收其他人發送的代幣。
>   - **Import Tokens**（導入代幣）：添加和顯示其他代幣。
>   - **Refresh list**（刷新列表）：刷新代幣列表以顯示最新的餘額和代幣。
>
> **支持和幫助**：
>   - **MetaMask 支援**：連接到 MetaMask 支援服務，以獲得幫助和解答問題。
>
> **切換網域功能**：右上角顯示網域預設是以太坊（Ethereum），點進去可以看到不同的區塊鏈 
> 
> ![image](https://hackmd.io/_uploads/r1yRtEgS0.png)

# 結語
這篇文章介紹了區塊鏈錢包的基本功能和分類，並詳細說明了如何安裝和使用最受歡迎的 MetaMask 小狐狸錢包。隨著區塊鏈技術的發展，錢包的種類和功能也越來越多，官方文件也變得越來越詳細和友好。

希望這篇文章能夠幫助大家對區塊鏈錢包有一個初步的了解和掌握。如果有任何問題或需要進一步的幫助，歡迎在留言區提出。未來，我們將繼續探索更多區塊鏈技術的應用和實踐，讓我們一起在這條學習之路上不斷進步吧！

