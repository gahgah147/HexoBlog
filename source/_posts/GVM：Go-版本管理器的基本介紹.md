---
title: GVM：Go 版本管理器的基本介紹
date: 2024-03-27 17:07:18
tags:
    - GO 
    - GVM
---

# GVM：Go 版本管理器的基本介紹

# GVM 是什麼?
![image](https://hackmd.io/_uploads/B1I3TIZJR.png)
>https://github.com/moovweb/gvm
GVM 是 Go 版本管理器，是一個用於管理多個 Go 版本的命令行工具。允許開發者輕鬆切換、安裝和使用不同版本的 Go，從而提高了開發效率並幫助保持項目環境的一致性。

# GVM 的特點
版本切換：GVM 允許您在不同版本的 Go 之間快速切換，方便您在多個項目間工作，每個可能需要不同版本的 Go。
易於安裝：通過 GVM，安裝新版本的 Go 變得非常容易，只需一條簡單的命令。
版本隔離：GVM 為每個版本的 Go 提供了隔離的環境，確保了不同項目的依賴和配置不會互相干擾。

# 如何安裝 GVM
在大多數 Unix-like 系統（如 Linux 和 macOS）上，可以使用以下命令安裝 GVM：
```
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
```
安裝完成後，可能需要重啟您的終端或者重新加載配置檔案（例如 .bashrc 或 .bash_profile）來使 GVM 的設定生效。

# 使用 GVM 管理 Go 版本
以下是使用 GVM 的一些基本命令：

列出可用的 Go 版本：
```
gvm listall
```

安裝特定版本的 Go：
```
gvm install go1.18.1 -B
```

使用特定版本的 Go：
```
gvm use go1.18.1
```

設定預設使用的 Go 版本：
```
gvm use go1.18.1 --default
```

# 總結

GVM 是一個強大的工具，對於需要在多個 Go 項目中工作的開發者來說，它提供了極大的便利。通過使用 GVM，開發者可以輕鬆切換 Go 版本，保持項目間的環境一致性，從而提升開發效率。無論您是 Go 語言的新手還是有經驗的開發者，GVM 都是您工具箱中不可或缺的一部分。