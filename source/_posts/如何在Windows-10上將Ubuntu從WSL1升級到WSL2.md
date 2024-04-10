---
title: 如何在Windows 10上將Ubuntu從WSL1升級到WSL2
date: 2024-04-10 11:05:22
tags:
    - Windows 10
    - WSL
    - Ubuntu
    - Docker
---
# 如何在Windows 10上將Ubuntu從WSL1升級到WSL2

我是使用 win10 的 ubuntu  出現這個問題 
```
sudo systemctl status docker
System has not been booted with systemd as init system (PID 1). Can't operate.
Failed to connect to bus: Host is down
```

win 10 舊版本電腦在使用WSL 上會遇到比較多問題需要排除

# 原因
在Windows 10上，Windows Subsystem for Linux (WSL) 提供了一個運行Linux二進制執行檔案的兼容層，無需使用傳統的虛擬機或雙重啟動設置。WSL有兩個版本：WSL1和WSL2。WSL2相較於WSL1提供了更完整的Linux內核支持和改進的性能。本教程將指導您如何將Ubuntu從WSL1升級到WSL2。

# 前提條件

* 確保您的Windows 10版本至少是2004（組建號19041）或更高版本。
* 確保您已安裝了Windows Subsystem for Linux (WSL)。

# 操作步驟

## 步驟1：檢查您的WSL版本

1.打開Windows的命令提示符或PowerShell。
2.輸入以下命令，然後按下Enter鍵：
```
wsl -l -v
```

3.檢查您的Ubuntu發行版旁邊的版本號。如果它顯示的是1，那麼您需要進行升級。

## 步驟2：啟用WSL2功能

1.打開PowerShell作為管理員。
2.執行以下命令來啟用WSL2功能：
```
wsl --set-version Ubuntu 2
```
請確保將Ubuntu替換成您的實際發行版名稱，如果它與顯示的不同。

等待升級過程完成。這可能需要一些時間，具體取決於您的系統配置和存儲的文件量。

## 步驟3：驗證升級
再次執行步驟1中的命令來檢查WSL版本：
```
wsl -l -v
```

