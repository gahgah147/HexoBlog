---
title: 使用 SSH Key 與 GitHub 連線教學
date: 2024-11-15 16:06:49
tags:
    - SSH
    - Git
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/rJ1AkKNMkl.jpg
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---


![SSH Key 與 GitHub 連線教學](https://hackmd.io/_uploads/rJ1AkKNMkl.jpg)

## 前言

對於每位軟體工程師來說，**Git** 是日常工作中不可或缺的工具之一。無論是軟體開發中的團隊協作，還是程式碼的維護與更新，Git 都能有效地幫助我們管理版本並保持團隊同步。

然而，經常使用 Git 的你是否遇過這樣的情況：  
每次執行 `git push` 或 `git pull` 時，總是需要輸入帳號密碼，既耗時又不方便。其實，這些問題都可以透過 **SSH Key** 來解決。不僅能讓操作更高效，也能提升安全性。

除此之外，當我們在團隊合作中，需要快速抓取程式碼進行開發時，使用 SSH Key 更是非常實用且推薦的做法！  
如下圖所示，設定好 SSH 後，團隊開發的效率將更進一步：  
![團隊合作使用 SSH key](https://hackmd.io/_uploads/rkgu2dNzJx.png)

接下來，就讓我們一起學習如何設定 SSH Key 並與 **GitHub** 建立安全連線吧！

---

## SSH Key 是什麼？

**SSH Key** 是一組用於身份驗證的加密金鑰對，常用於安全地連接伺服器、版本控制系統（如 GitHub）或其他需要安全性驗證的服務。它是實現 **SSH（Secure Shell）協議**的重要部分，能夠在不使用密碼的情況下實現高安全性的加密連線。

---

### SSH Key 的結構
SSH Key 包含兩部分：
1. **公鑰（Public Key）**  
   - 這部分可公開分享，例如上傳到 GitHub 或伺服器。
   - 公鑰會用於加密資料。

2. **私鑰（Private Key）**  
   - 這部分必須妥善保管，不能外洩。
   - 私鑰會用於解密資料並證明你的身份。

當伺服器收到你的公鑰並匹配到你的私鑰時，就可以確定是你本人在進行連線。

---

### 為什麼要使用 SSH Key？

1. **更安全**  
   相比使用帳號密碼，SSH Key 基於加密技術，比密碼更難破解。

2. **免密碼登入**  
   設定好 SSH Key 後，連線時不再需要手動輸入密碼，節省時間且方便。

3. **防範中間人攻擊**  
   SSH Key 的加密機制可以有效防止中間人攔截與破解。

---

### 使用 SSH Key 的場景
1. **遠端伺服器連線**  
   例如使用 SSH 登入 Linux 伺服器進行管理。

2. **版本控制系統（如 GitHub/GitLab）**  
   用於身份驗證，避免每次 `git push` 或 `git pull` 時都需要輸入帳號密碼。

3. **自動化部署**  
   在 CI/CD 系統中，使用 SSH Key 無需手動干預即可進行自動部署。

---

## 操作流程

### 1. 產生 SSH Key

我們首先需要在本地端生成 SSH Key，這是一組用於身份驗證的加密金鑰對（包含私鑰與公鑰）。

執行以下指令來產生金鑰：  
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

以下是指令的參數解釋：
- **`-t rsa`**：指定金鑰類型為 RSA。
- **`-b 4096`**：設定金鑰長度為 4096 位元，以提高安全性。
- **`-C "your_email@example.com"`**：附加你的電子郵件地址作為標識，方便管理。

執行後，系統會要求指定存放金鑰的路徑與名稱（預設為 `~/.ssh/id_rsa`），以及是否設定密碼（可自行選擇）。

---

### 2. 將公鑰上傳至 GitHub

生成完金鑰後，下一步是將公鑰上傳至 GitHub：

1. 使用以下指令查看生成的公鑰內容：  
   ```bash
   cat ~/.ssh/id_rsa.pub
   ```
   結果會是一串以 **`ssh-rsa`** 開頭的長字符串。

2. 登入你的 GitHub 帳戶，前往 **Settings** > **SSH and GPG keys**，點擊 **New SSH Key** 按鈕。

3. 在 **Key** 欄位中，將剛剛複製的公鑰內容貼上，並為該金鑰設定一個描述性名稱（例如 "My Laptop SSH Key"）。  
   完成後點擊 **Add SSH Key** 儲存。  
   參考下圖操作：  
   ![GitHub SSH Key 設定畫面](https://hackmd.io/_uploads/SyWdLHEzkl.png)

---

## 結語

透過 SSH Key，不僅可以省去每次輸入帳號密碼的麻煩，也能讓連線更加安全且高效。無論是個人專案開發還是團隊合作，這都是一個實用且推薦的最佳實踐。

希望這篇教學對你有所幫助！如果在設定過程中遇到問題，歡迎留言討論 😊

--- 
