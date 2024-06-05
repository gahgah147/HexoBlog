---
title: Node.js 學習筆記 - NVM 版本控制器介紹及其安裝步驟
date: 2024-06-05 10:52:13
tags:
    - Node.js
    - NVM
---
# Node.js 學習筆記 - NVM 版本控制器介紹及其安裝步驟

![image](https://hackmd.io/_uploads/r1jyf86EC.png)


## 什麼是 NVM？
NVM (Node Version Manager) 是一個管理 Node.js 版本的工具。它允許開發者在多個 Node.js 版本之間輕鬆切換，這對於需要同時維護多個專案或測試新版本功能的開發者來說非常方便。

以下是NVM 的官方Github連結

![image](https://hackmd.io/_uploads/SJVyWU640.png)
>https://github.com/nvm-sh/nvm


## NVM 的優點
1. **輕鬆管理多個 Node.js 版本**：可以隨時切換、安裝或移除不同的 Node.js 版本。
2. **環境隔離**：不同專案可以使用不同的 Node.js 版本，避免版本衝突。
3. **簡單易用**：安裝和使用都非常直觀，幾條命令即可完成操作。

## NVM 的安裝步驟

### 1. 安裝 NVM
要安裝 NVM，請執行以下步驟：

1. 打開終端機 (Terminal)。

![image](https://hackmd.io/_uploads/HyeuY0SaVR.png)

3. 使用 curl 或 wget 下載並安裝 NVM：

    ```sh
    # 使用 curl
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
    
    # 或使用 wget
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
    ```
    
![image](https://hackmd.io/_uploads/H1woRHTNA.png)


3. 安裝完成後，重新啟動終端機或運行以下命令來使 NVM 生效：

    ```sh
    source ~/.nvm/nvm.sh
    ```

因為我不想重新開機所以用這個指令
![image](https://hackmd.io/_uploads/SkECCBp4R.png)

### 2. 驗證安裝
要確認 NVM 是否安裝成功，可以運行以下命令：

```sh
nvm --version
```

如果安裝成功，會顯示 NVM 的版本號。

![image](https://hackmd.io/_uploads/ryAgy86NR.png)
>這邊成功顯示版本編號為0.39.2

### 3. 安裝 Node.js 版本
安裝 NVM 後，可以使用 NVM 來安裝和管理不同的 Node.js 版本。

1. 安裝最新的 LTS 版本：

    ```sh
    nvm install --lts
    ```

![image](https://hackmd.io/_uploads/BJnrJ8aER.png)
>目前安裝最新版本為20.14.0

2. 安裝特定版本，例如 14.17.0：

    ```sh
    nvm install 14.17.0
    ```
    
![image](https://hackmd.io/_uploads/SkEK1Up4R.png)
>成功安裝畫面

3. 切換到特定版本：

    ```sh
    nvm use 14.17.0
    ```

![image](https://hackmd.io/_uploads/B1-ikU6VR.png)
>成功切換版本畫面

4. 查看已安裝的所有 Node.js 版本：

    ```sh
    nvm ls
    ```
    
![image](https://hackmd.io/_uploads/HJfpyLa4C.png)
>成功列出所有版本的畫面

### 4. 設定默認版本
如果希望某個版本作為默認版本，可以使用以下命令：

```sh
nvm alias default 14.17.0
```

![image](https://hackmd.io/_uploads/BJBXeLaEA.png)
>設定預設版本成功畫面

### 結論
NVM 是一個非常實用的工具，尤其適合需要同時管理多個 Node.js 版本的開發者。通過簡單的幾條命令，我們可以輕鬆地安裝、移除或切換不同的 Node.js 版本，從而提高開發效率。

建議一開始安裝node.js 就這樣安裝比較簡單，更詳細的操作指令建議去官方的github網址查看(https://github.com/nvm-sh/nvm)。

希望這篇文章能幫助你了解 NVM 並順利安裝和使用它。如果你有任何問題或需要進一步的幫助，歡迎在留言區提出。

