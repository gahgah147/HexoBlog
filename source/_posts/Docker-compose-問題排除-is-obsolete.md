---
title: 'Docker-compose 問題排除: version is obsolete '
date: 2024-04-19 11:43:09
tags:
    - Docker-compose 
    - version is obsolete 
---

# Docker-compose 問題排除:  `version` is obsolete 

我在使用 docker-compose build 時遇到以下問題

WARN[0000] /home/docker-compose.yml: `version` is obsolete 

# 問題原因:

從提供的錯誤訊息來看，表示使用的 docker-compose.yml 文件中的 version 字段已經過時。

這通常表示您正在使用的 Docker Compose CLI (Command Line Interface) 已經升級到更高版本，而該版本可能不再需要或不支持 version 字段。

# 解決方法:
移除 version 行
編輯您的 docker-compose.yml 文件，刪除或註釋掉 version: '3' 這一行。

```
# version: '3'
```