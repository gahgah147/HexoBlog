---
title: 在Windows上安裝 pnpm
date: 2023-09-26 09:13:46
tags: pnpm windows
---

# 前言

因為練習Next.js 開發blog 需要安裝 pnpm 紀錄一下 windows 上如何安裝pnpm 

後來在[這篇文章](https://stackoverflow.com/questions/75365692/how-to-install-pnpm-on-windows)找到解決方法

參考影片: https://www.youtube.com/watch?v=q5iDjNR1O7Y&ab_channel=GeekyScript

# 打開CMD執行以下指令

```
set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```
以上是一個 PowerShell 命令
set-ExecutionPolicy：這是 用於設置執行策略。

RemoteSigned：這是一個執行策略的值。在這種情況下，它表示允許執行本地（在本機計算機上）簽名過的腳本，但來自遠程位置（例如網絡上的腳本）的腳本需要經過簽名才能執行。這有助於提高安全性，因為它可以防止遠程未經信任的腳本在你的系統上運行。

-Scope CurrentUser：這部分指定了執行策略的作用範圍。在這種情況下，它設置執行策略只對當前使用者（CurrentUser）生效，而不會影響其他使用者。這是一種局部的設置，只影響當前使用者的 PowerShell 會話。

總結起來，這個命令的含義是：將當前使用者的 PowerShell 執行策略設置為 RemoteSigned，這意味著他們可以執行本地簽名過的腳本，但需要簽名的遠程腳本才能運行。這是一種安全的默認策略，可防止未經信任的遠程腳本在系統上執行。
# 執行 Get-ExecutionPolicy
```
Get-ExecutionPolicy
```

Get-ExecutionPolicy 是 PowerShell 中的一個 cmdlet（命令），它用於檢索當前的執行策略。執行策略指定了哪些 PowerShell 腳本可以在系統上執行，以及它們如何被允許執行。當你運行 Get-ExecutionPolicy 命令時，它會返回當前使用者或系統的執行策略設置。


# 查看所有的 Policy 可以執行以下指令
```
Get-ExecutionPolicy -list
```


執行策略有不同的級別，包括：

Restricted：這是最嚴格的策略，它禁止執行所有腳本，包括本地和遠程腳本。這通常是預設的策略，以確保系統的安全性。

AllSigned：這個策略要求所有腳本都必須經過數位簽名，無論是本地還是遠程的。只有經過簽名的腳本才能執行。

RemoteSigned：這個策略要求遠程腳本必須經過數位簽名，但本地腳本可以自由執行，不需要簽名。

Unrestricted：這個策略允許所有腳本在系統上執行，不需要簽名。這是最不安全的策略，應謹慎使用。

Bypass：這個策略完全禁用執行策略，允許所有腳本自由執行。這是一個非常不安全的設置，應該極少使用，如果需要請謹慎使用


#  安裝 pnpm
```
npm i -g pnpm
```