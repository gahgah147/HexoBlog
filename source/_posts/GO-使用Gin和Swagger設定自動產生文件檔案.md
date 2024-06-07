---
title: GO 使用Gin和Swagger設定自動產生文件檔案
date: 2024-02-01 11:54:58
tags:
    - go
    - Gin
    - Swagger
    - OpenAPI
---

# 前言

當開發RESTful API時，有效的文檔是極其重要的，它可以幫助開發者快速理解和使用API。Swagger是一個強大的工具，用於自動生成和維護API文檔。

本文將指導你如何使用Swagger在Gin框架中自動生成API文檔，並提供一些維護的最佳實踐。

# 為什麼選擇Swagger？

1.標準化: Swagger遵循OpenAPI規範，這是一個業界標準。
2.交互性: Swagger UI允許用戶直接從文檔中測試API，無需其他工具。

# 安裝流程

安裝必要的套件
首先，我們需要安裝swag CLI工具和Gin的Swagger中間件。

swagger cmd: 用於生成介面文件的命令列工具。

```
go get -u github.com/swaggo/swag/cmd/swag
```
Starting in Go 1.17, installing executables with go get is deprecated. go install may be used instead:

```
go install github.com/swaggo/swag/cmd/swag@latest
```

gin-swagger: gin與swagger的中介軟體。
files: 幫助建立檔案
```
go get -u github.com/swaggo/gin-swagger
go get -u github.com/swaggo/files
```

在你的主要應用文件中執行以下命令：
```
swag init
```

:::warning
![image](https://hackmd.io/_uploads/S1QZb_O5T.png)
這邊實作遇到這個問題，後來看這篇文章
[[Golang] “swag: command not found”error handling](https://peggy-tsai.medium.com/golang-swag-command-not-found-error-handling-52e2cbc5240e)

[參考這個解法](https://github.com/swaggo/swag/issues/197?source=post_page-----52e2cbc5240e--------------------------------#issuecomment-585102353)

輸入以下指令以獲得 Go 的工作路徑
go env GOPATH

![image](https://hackmd.io/_uploads/BJ_ZV__9T.png)

找路徑後到 go/bin資料夾中，輸入下方command
```
PATH=$(go env GOPATH)/bin:$PATH
```
回到專案資料夾，即可正常使用
![image](https://hackmd.io/_uploads/BJ7PNdd5T.png)

:::

這將生成docs目錄，其中包含Swagger的文檔資料。

將Swagger UI加入Gin
在你的Gin應用中，導入必要的包並將Swagger中間件添加到路由。
```
import (
    swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
    "message/docs"
)

func main() {
    r := gin.Default()
    docs.SwaggerInfo.BasePath = "/api/v1"
    r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
    // other routes...
    r.Run()
}
```

這一步實作發現還要引入專案 docs 文件才行

# Swagger 註解

## 一般說明
```
// @title Gin swagger
// @version 1.0
// @description Gin swagger

// @contact.name nathan.lu
// @contact.url https://tedmax100.github.io/

// @license.name Apache 2.0
// @license.url http://www.apache.org/licenses/LICENSE-2.0.html

// @host localhost:8080
// schemes http
func main() { ... }
```

API Info

| 註解 | 描述 | 
| -------- | -------- | 
| title     | 必須簡單API專案的標題或主要的業務功能     | 
| version   | 必須目前這專案/API的版本     | 
| description     | 簡單描述     | 
| tersOfService     | 服務條款     | 
| contact.name     | 作者名稱     | 
| contact.url	     | 作者blog     | 
| contact.email     | 作者email    | 
| license.name     | 必須許可證名稱     | 
| license.url    | 許可證網址     | 
| host     | 服務名稱或者是ip     | 
| BasePath     | 基本URL路徑, (/api/v1, /v2...)     | 
| schemes     | 提供的協定, (http, https)     | 

## API 功能註解
API Operation

```
helloHandler.go

// @Summary 說Hello
// @Id 1
// @Tags Hello
// @version 1.0
// @produce text/plain
// @Success 200 string string 成功後返回的值
// @Router /hello [get]
func GetHello(ctx *gin.Context) {...}

// @Summary Delete Hello
// @Id 1
// @Tags Hello
// @version 1.0
// @produce text/plain
// @param id path int true "id"
// @Success 200 string string 成功後返回的值
// @Router /hello/{id} [delete]
func DeleteHello(ctx *gin.Context) { ... }
```


| 註解 | 描述 | 
| -------- | -------- | 
| summary     | 描述該API     |
| tags     | 歸屬同一類的API的tag     |
| accept     | request的context-type     |
| produce     | response的context-type     |
| param     | 參數按照 參數名 參數類型 參數的資料類型 是否必須 註解 (中間都要空一格) |
| header     | response header return code 參數類型 資料類型 註解 |
| router     | path httpMethod    |

#  最佳作法

1.保持文檔最新: 每次更新API時，確保運行swag init以更新文檔。
2.描述和詳細: 使用Swagger註釋提供充分的API描述和範例。
3.版本控制: 如果你的API有多個版本，確保在Swagger文檔中明確指出。

# 結論
利用Swagger與Gin結合，不僅可以自動生成API文檔，還可以提供一個交互式的界面，使其他開發者更容易理解和使用你的API。

但這邊目前看來還是要人工撰寫，感覺不夠自動化，我認為需要再進一找看看有沒有自動化工具

# swagger 註解自動化

# 參考資料:

https://peggy-tsai.medium.com/golang-swag-command-not-found-error-handling-52e2cbc5240e
https://vocus.cc/article/650d7ee8fd89780001aa431a
https://github.com/swaggo/swag/issues/197?source=post_page-----52e2cbc5240e--------------------------------#issuecomment-585102353

https://ithelp.ithome.com.tw/articles/10224472?sc=rss.iron