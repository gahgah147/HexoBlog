---
title: 在Codespace 上運行Python
date: 2023-09-12 15:30:48
tags: GitHub Codespace Python 
---

# 在Codespace 上運行Python

範例原始碼放在 GitHub Repo: [vscode-remote-try-python](https://github.com/gahgah147/vscode-remote-try-python)

參考文章:[Setting up a Python project for GitHub Codespaces](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/setting-up-your-python-project-for-codespaces)


# 1. 在 codespace 上開啟 project
Go to https://github.com/microsoft/vscode-remote-try-python.
Click Use this template, then 

![](https://hackmd.io/_uploads/Hy2vkS6C3.png)
> 點擊 Open in a codespace.

# 2: 新增 dev container 設定檔案

1.使用 Visual Studio Code 指令 (Ctrl+Shift+P/Shift+Command+P)，
然後輸入 add dev 

![](https://hackmd.io/_uploads/SyuKutTC2.png)
>點擊 Codespaces: Add Dev Container Configuration Files.

2. 點擊 Create a new configuration.

3. 因為已經存在'.devcontainer/devcontainer.json' 檔案所以未出現這個提示，這邊選擇 Continue 
![](https://hackmd.io/_uploads/r1KsOYaC2.png)

4. 選擇 Show All Definitions.
![](https://hackmd.io/_uploads/B1a7KKTA3.png)

5. 輸入 python 然後選擇 Python 3
![](https://hackmd.io/_uploads/BJxOtK6Cn.png)

6. 選擇 python 版本 這邊我們選擇預設值
![](https://hackmd.io/_uploads/Skj2KtTRh.png)

7. 輸入 py 選擇 Coverage.py (via pipx) 然後點 OK
![](https://hackmd.io/_uploads/rynr9FpA2.png)

# 3. 修改 devcontainer.json 檔案

1. 修改 devcontainer.json 檔案
```
// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/python
{
  "name": "Python 3",
  // Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
  "image": "mcr.microsoft.com/devcontainers/python:0-3.11-bullseye",
  "features": {
    "ghcr.io/devcontainers-contrib/features/coverage-py:2": {}
  },

  // Use 'forwardPorts' to make a list of ports inside the container available locally.
  // "forwardPorts": [],

  // Use 'postCreateCommand' to run commands after the container is created.
  "postCreateCommand": "pip3 install --user -r requirements.txt",

  // Configure tool-specific properties.
  "customizations": {
    // Configure properties specific to VS Code.
    "vscode": {
      // Add the IDs of extensions you want installed when the container is created.
      "extensions": [
        "streetsidesoftware.code-spell-checker"
      ]
    }
  }

  // Uncomment to connect as root instead. More info: https://aka.ms/dev-containers-non-root.
  // "remoteUser": "root"
}

```

2. (Ctrl+Shift+P) 輸入 rebuild
![](https://hackmd.io/_uploads/Hk11hFaC3.png)
選擇 Codespaces: Rebuild Container.

# 4. 接下來就能運行 python 了

測試輸入指令: 
```
python -m flask run
```

![](https://hackmd.io/_uploads/Hyl83FTA3.png)
> 選擇  Open in Browser 

會看到以下畫面
![](https://hackmd.io/_uploads/HJ0DhYp03.png)


# 5. 可以把修改結果 Commit 上去