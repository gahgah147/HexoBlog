---
title: Docker 學習筆記 Day1 - Docker 介紹與安裝步驟
date: 2024-06-07 09:34:24
tags:
    - Docker
    - Docker Desktop
---
# Docker 學習筆記 Day1 - Docker 介紹與安裝步驟

Docker官網
![image](https://hackmd.io/_uploads/Sk6e3xJrR.png)
>https://www.docker.com/

docker官方教學文件
![image](https://hackmd.io/_uploads/SJwtCgkSA.png)
https://docs.docker.com/


## 引言

我是在看這本書 跟著 Docker 隊長，修練 22 天就精通([這邊是購書連結](https://www.books.com.tw/products/0010903691))

來學習Docker 的，另外還有以下資源可以參考

1.書本中提供的練習專案程式碼:https://github.com/sixeyed/diamol 
2.書籍作者提供的Youtube 系列影片: https://www.youtube.com/playlist?list=PLXl_isu8qxvmDOAnUkG5x16LzBzGzY_Ww
我覺得書的內容很紮實，但是有時候沒有紀錄很快就會忘記了，所以我就練習寫下操作紀錄跟重點，更多詳細的細節可以直接去查看這本書的內容。


## 什麼是 Docker？

Docker 是一個開源的應用程式打包和部署工具，它允許您在容器中打包應用程式及其所有相依性，並確保其將在任何環境中都能運行。這使得應用程式的部署變得更加容易且可靠。

簡單來說有了Docker很多專案部屬的步驟就能夠簡化，且在windows、Linux等系統都能夠快速運行。所以現在很多的github 專案都有dockerfile 且部署流程都會很簡單

## Docker 的優點

- **輕量級**：容器共享主機的核心，並運行於一個單獨的進程中，因此比虛擬機更輕量級。
- **快速啟動**：容器可以快速啟動，因為它們不需要像虛擬機一樣啟動整個作業系統。
- **跨平台**：Docker 容器可以在任何支援 Docker 的平台上運行，而不用擔心環境的不同。

# Docker 的使用情境

**應用程式開發與測試**：開發人員可以使用 Docker 將應用程式及其相依性打包成容器，在開發環境中運行，確保開發環境與生產環境一致性。同時，測試人員也可以使用相同的容器運行測試，確保程式碼的正常運作。

**微服務架構**：Docker 可以幫助組織實現微服務架構，將應用程式拆分為多個獨立的服務，每個服務運行在自己的容器中。這樣可以提高應用程式的彈性和可擴展性。

**持續集成和持續部署**：Docker 可以與持續集成和持續部署（CI/CD）工具集成，幫助自動化構建、測試和部署流程，加快軟體交付速度。

**多雲端部署**：Docker 可以在不同的雲端平台上運行，並提供一致的運行環境，從而實現跨雲端的應用程式部署和移植。

**快速擴展**：使用 Docker 可以快速擴展應用程式，只需在需要時啟動新的容器即可，無需等待長時間的部署和配置。

## 在 Windows 上安裝 Docker

因為我目前使用的是Windows，所以我這邊示範Windows安裝的流程，另外我嘗試安裝的經驗來看建議最少都要有 Win11 使用docker起來才不會有問題，因為docker 要求要使用到WSL2。 一般來說電腦太老舊不能升級到win11 的跑docker都會容易出錯。

### 安裝Docker Desktop。

![image](https://hackmd.io/_uploads/HydWxZySC.png)
>https://www.docker.com/products/docker-desktop/

點選Docker Desktop for Windows 開始安裝
![image](https://hackmd.io/_uploads/BJbEg-JBR.png)

安裝完成後，啟動 Docker Desktop Installer
![image](https://hackmd.io/_uploads/r1QLWWkrC.png)

點選OK
![image](https://hackmd.io/_uploads/H1SRZZ1rC.png)

開始安裝
![image](https://hackmd.io/_uploads/BJTZGbJrR.png)

安裝成功
![image](https://hackmd.io/_uploads/Hyo97-1HC.png)

接下來會重新開機，開機完成後會看到以下畫面
![image](https://hackmd.io/_uploads/Bkq8_AkHA.png)

>這是 Docker 的訂閱服務協議。當你選擇接受時，你同意了以下幾個條款：
>
>1. **Subscription Service Agreement** (訂閱服務協議): 這是你與 Docker 之間的主要協議，規範了你如何使用 Docker 的訂閱服務。
>2. **Docker Data Processing Agreement** (數據處理協議): 這個協議涉及 Docker 如何處理和保護你的數據。
>3. **Data Privacy Policy** (數據隱私政策): 這個政策描述了 Docker 如何收集、使用、分享和保護你的個人數據。
>
>另外，這段文字還提到了一些關於 Docker Desktop 使用條件的資訊：
>
>- Docker Desktop 對於小型企業（少於 250 名員工且年收入少於 1000 萬美元）、個人使用、教育和非商業的開源項目是免費的。
>- 對於專業用途，需要付費訂閱。
>- 政府機構也需要付費訂閱。
>
>你可以閱讀 FAQ 以了解更多詳細資訊。

確認沒有問題後按 "Accept" 同意訂閱服務協議

接下來是 Docker Desktop 的歡迎畫面，提示你登錄以連接你的 Docker Desktop 訂閱或訪問在線功能。
![image](https://hackmd.io/_uploads/HJvitAkSC.png)

這裡有三個選項：

1. **Sign up** (註冊): 如果你還沒有帳戶，可以點擊這裡註冊一個新的 Docker 帳戶。
2. **Sign in** (登入): 如果你已經有帳戶，可以點擊這裡登入。
3. **Continue without signing in** (繼續無需登入): 如果你不想登入，可以選擇這個選項繼續使用 Docker Desktop。

這個畫面主要是讓你選擇是否要使用 Docker 的訂閱服務和在線功能。

接下來填完相關問卷後會進入Docker desktop 的畫面
![image](https://hackmd.io/_uploads/rycR5AJHA.png)

這樣就成功安裝並啟動了 Docker Desktop

## 結尾

以上就是第一天學習Docker的內容，今天介紹了Docker還有使用情境跟安裝步驟，如果有任何問題或需要進一步的幫助，歡迎在留言區提出。
