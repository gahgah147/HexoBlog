---
title: 使用 Go 來寫一個 Repository Restful API 的留言板
date: 2024-01-29 10:04:45
tags:
  - 後端
  - Go
  - Gin
  - Mysql
  - Docker
---


# 前言
這篇是我看到這篇文章
https://github.com/880831ian/go-restful-api-repository-messageboard?tab=readme-ov-file
跟著實作練習的紀錄，是使用 Go 來寫一個 Repository Restful API 的留言板，並且會使用 gin 以及 gorm (使用 Mysql)套件。
另外有加入 docker-compose設定跟mysql 連線調整。

# 開發環境
## Go
![image](https://hackmd.io/_uploads/Hy_t7sx5a.png)
>https://go.dev/

## GIN框架
![image](https://hackmd.io/_uploads/B1ZiXjl5p.png)
>https://gin-gonic.com/

## Mysql 
![image](https://hackmd.io/_uploads/Sks3mogcT.png)
![image](https://hackmd.io/_uploads/SJXmVogc6.png)

## Docker
![image](https://hackmd.io/_uploads/SyXkVjl56.png)

# 檔案結構
```
.
├── controller
│   └── controller.go
├── go.mod
├── go.sum
├── main.go
├── model
│   └── model.go
├── repository
│   └── repository.go
├── router
│   └── router.go
└── sql
    ├── connect.yaml
    └── sql.go
```

資料夾個別功能與作用:
sql：放置連線資料庫檔案。
controller：商用邏輯控制。
model：定義資料表資料型態。
repository：處理與資料庫進行交握。
router：設定網站網址路由。

## 設定 go.mod
到開發資料夾底下
```
cd message_board
```
初始化設定 go.mod 的 module
```
go mod init message
```

接著使用 go get 來引入 gin、gorm、mysql、yaml 套件

```
$ go get -u github.com/gin-gonic/gin
$ go get -u gorm.io/gorm
$ go get -u gorm.io/driver/mysql
$ go get -u gopkg.in/yaml.v2
```

## main.go
```
package main

import (
	"fmt"
	"message/model"
	"message/router"
	"message/sql"
)

func main() {
	//連線資料庫
	if err := sql.InitMySql(); err != nil {
		panic(err)
	}
	
	//連結模型
	sql.Connect.AutoMigrate(&model.Message{})
	//sql.Connect.Table("message") //也可以使用連線已有資料表方式
	
	//註冊路由
	r := router.SetRouter()
	
	//啟動埠為8082的專案
	fmt.Println("開啟127.0.0.0.1:8082...")
	r.Run("127.0.0.1:8082")
}
```

引入我們 Repository 架構，將 config、model、router 導入，先測試是否可以連線資料庫，使用 AutoMigrate 來新增資料表(如果沒有才新增)，或是使用 Table 來連線已有資料表，註冊網址路由，最後啟動專案，我們將 Port 設定成 8082。

## sql 設定
connect.yaml
```
host: 127.0.0.1
username: root
password: "密碼"
dbname: "資料庫名稱"
port: 3306
```
我們把 mysql 連線的資訊寫在此處。  (專案正式環境可能要加入gitignore 比較安全)

sql.go (下面為一個檔案，但長度有點長，分開說明)
```
package sql

import (
	"io/ioutil"
	"fmt"
	"gopkg.in/yaml.v2"
	"gorm.io/gorm"
	"gorm.io/driver/mysql"
)

```

import 會使用到的套件。
```
var Connect *gorm.DB

type conf struct {
	Host     string `yaml:"host"`
	UserName string `yaml:"username"`
	Password string `yaml:"password"`
	DbName   string `yaml:"dbname"`
	Port     string `yaml:"port"`
}

func (c *conf) getConf() *conf {
	//讀取config/connect.yaml檔案
	yamlFile, err := ioutil.ReadFile("sql/connect.yaml")
	
	//若出現錯誤，列印錯誤訊息
	if err != nil {
		fmt.Println(err.Error())
	}
	
	//將讀取的字串轉換成結構體conf
	err = yaml.Unmarshal(yamlFile, c)
	if err != nil {
		fmt.Println(err.Error())
	}
	return c
}
```
設定資料庫連線的 conf 來讀取 yaml 檔案。

```
//初始化連線資料庫
func InitMySql() (err error) {
	var c conf
	
	//獲取yaml配置引數
	conf := c.getConf()
	
	//將yaml配置引數拼接成連線資料庫的url
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		conf.UserName,
		conf.Password,
		conf.Host,
		conf.Port,
		conf.DbName,
	)
	
	//連線資料庫
	Connect, err = gorm.Open(mysql.New(mysql.Config{DSN: dsn}), &gorm.Config{})
	return
}
```
 
初始化資料庫，會把剛剛讀取 yaml 的 conf 串接成可以連接資料庫的 url ，最後連線資料庫。

## 路由設定
router.go
```
package router

import (
	"message/controller"
	"github.com/gin-gonic/gin"
)

func SetRouter() *gin.Engine {
	//顯示 debug 模式
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()

	v1 := r.Group("api/v1")
	{
		//新增留言
		v1.POST("/message", controller.Create)
		//查詢全部留言
		v1.GET("/message", controller.GetAll)
		//查詢 {id} 留言
		v1.GET("/message/:id", controller.Get)
		//修改 {id} 留言
		v1.PATCH("/message/:id", controller.Update)
		//刪除 {id} 留言
		v1.DELETE("/message/:id", controller.Delete)
	}
	return r
}
```
設定路由，版本 v1 網址是 api/v1 ，分別是新增留言、查詢全部留言、查詢 {id} 留言、修改 {id} 留言、刪除 {id} 留言，連接到不同的 controller function 。

## 資料表設定
model.go
```
package model

import 	"gorm.io/gorm"

func (Message) TableName() string {
	return "message"
}

type Message struct {
	Id        int    `gorm:"primary_key,type:INT;not null;AUTO_INCREMENT"`
	User_Id   int    `json:"User_Id"  binding:"required"`
	Content   string `json:"Content"  binding:"required"`
	Version   int    `gorm:"default:0"`
	// 包含 CreatedAt 和 UpdatedAt 和 DeletedAt 欄位
    gorm.Model
}
```
設定資料表的結構，使用 gorm.Model 預設裡面會包含 CreatedAt 和 UpdatedAt 和 DeletedAt 欄位。

## controller 設定
controller.go
(下面為一個檔案，但長度有點長，分開說明)

```
package controller

import (
	"message/model"
	"message/repository"
	"net/http"
	"unicode/utf8"

	"github.com/gin-gonic/gin"
)
```
import 會使用到的套件。

查詢留言功能
```
func GetAll(c *gin.Context) {
	message, err := repository.GetAllMessage()

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": message})
}

func Get(c *gin.Context) {
	var message model.Message

	if err := repository.GetMessage(&message, c.Param("id")); err != nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "找不到留言"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": message})
}
```

GetAll() 會使用到 repository.GetAllMessage() 查詢並回傳顯示查詢的資料。

c.Param("id") 是網址讀入後的 id，網址是http://127.0.0.1:8081/api/v1/message/{id} ，將輸入的 id 透過 repository.GetMessage() 查詢並回傳顯示查詢的資料。

新增留言功能
```
func Create(c *gin.Context) {
	var message model.Message

	if c.PostForm("Content") == "" || utf8.RuneCountInString(c.PostForm("Content")) >= 20 {
		c.JSON(http.StatusBadRequest, gin.H{"message": "沒有輸入內容或長度超過20個字元"})
		return
	}

	c.Bind(&message)
	repository.CreateMessage(&message)
	c.JSON(http.StatusCreated, gin.H{"message": message})
}
```
使用 Gin 框架中的 Bind 函數，可以將 url 的查詢參數 query parameter，http 的 Header、body 中提交的數據給取出，透過 repository.CreateMessage() 將要新增的資料帶入，如果失敗就顯示 http.StatusBadRequest，如果成功就顯示 http.StatusCreated 以及新增的資料。

修改留言功能
```
func Update(c *gin.Context) {
	var message model.Message

	if c.PostForm("Content") == "" || utf8.RuneCountInString(c.PostForm("Content")) >= 20 {
		c.JSON(http.StatusBadRequest, gin.H{"message": "沒有輸入內容或長度超過20個字元"})
		return
	}

	if err := repository.UpdateMessage(&message, c.PostForm("Content"), c.Param("id")); err != nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "找不到留言"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": message})
}
```
先使用 repository.GetMessage() 以及 c.Param("id") 來查詢此 id 是否存在，再帶入要修改的 Content ，透過 repository.UpdateMessage() 將資料修改，，如果失敗就顯示 http.StatusNotFound 以及找不到留言，如果成功就顯示 http.StatusOK 以及修改的資料。

刪除留言功能
```
func Delete(c *gin.Context) {
	var message model.Message

	if err := repository.DeleteMessage(&message, c.Param("id")); err != nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "找不到留言"})
		return
	}
	c.JSON(http.StatusNoContent, gin.H{"message": "刪除留言成功"})
}
```
透過 repository.DeleteMessage() 將資料刪除，如果失敗就顯示 http.StatusNotFound  以及找不到留言，如果成功就顯示 http.StatusNoContent。


## repository.go
(下面為一個檔案，但長度有點長，分開說明)

所有的邏輯判斷都要在 controller 處理，所以 repository.go 就單純對資料庫就 CRUD：
```
package repository

import (
	"message/model"
	"message/sql"
)
```
import 會使用到的套件。

查詢留言資料讀取
```
//查詢全部留言
func GetAllMessage() (message []*model.Message, err error) {
	err = sql.Connect.Find(&message).Error
	return
}

//查詢 {id} 留言
func GetMessage(message *model.Message, id string) (err error) {
	err = sql.Connect.Where("id=?", id).First(&message).Error
	return
}
```

新增留言資料讀取

```
//新增留言
func CreateMessage(message *model.Message) (err error) {
	err = sql.Connect.Create(&message).Error
	return
}
```
修改留言資料讀取

```
//更新 {id} 留言
func UpdateMessage(message *model.Message, content, id string) (err error) {
	err = sql.Connect.Where("id=?", id).First(&message).Update("content", content).Error
	return
}
```

刪除留言資料讀取
```
//刪除 {id} 留言
func DeleteMessage(message *model.Message, id string) (err error) {
	err = sql.Connect.Where("id=?", id).First(&message).Delete(&message).Error
	return
}
```

# Mysql docker-compose 設定
因為我在實作時發現沒有做 mysql server的設定，我這邊作了以下調整

## Dockerfile
```
# 使用 Go 官方映像作為基礎映像
FROM golang:latest

# 設定工作目錄
WORKDIR /app

# 複製 go.mod 和 go.sum 文件
COPY go.mod go.sum ./

# 下載依賴
RUN go mod download

# 複製源代碼文件到工作目錄
COPY . .

# 構建應用程序
RUN go build -o main .

# 暴露端口
EXPOSE 8082

# 執行應用程序
CMD ["./main"]
```

## docker-compose.yml
```
version: "2.1"

services:
    db:
        image: mysql:5.7
        command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
        environment:
            MYSQL_ROOT_PASSWORD: root
            MYSQL_DATABASE: go
        ports:
            - "3306:3306"
        restart: always

    phpmyadmin:
        image: phpmyadmin/phpmyadmin
        environment:
            PMA_HOST: db
            PMA_PORT: 3306
        ports:
            - "8084:80"
        depends_on:
            - db

    go-app:
        build: .
        ports:
            - "8082:8082"
        depends_on:
            - db
```

這邊設定了 phpmyadmin跟 mysql 服務，另外有一個go-app 的服務運行這個專案

## 啟用docker-compose
```
docker-compose up -d
```
![image](https://hackmd.io/_uploads/HkpcFix56.png)
>運行結果

![image](https://hackmd.io/_uploads/ByzLhixca.png)
>phpmyadmin連線

# Postman 測試

## 查詢全部留言 - 成功(無資料)
![image](https://hackmd.io/_uploads/Hy_Ja5x96.png)

## 查詢全部留言 - 成功(有資料)
![image](https://hackmd.io/_uploads/HkqgWig5T.png)

## 查詢{id}留言 - 成功
![image](https://hackmd.io/_uploads/rkPUWig56.png)

## 查詢{id}留言 - 失敗
![image](https://hackmd.io/_uploads/rJeKWilqp.png)

## 新增留言 - 成功
![image](https://hackmd.io/_uploads/By2w1jxqT.png)

## 修改{id}留言 - 成功
![image](https://hackmd.io/_uploads/SyYGejec6.png)

## 刪除{id}留言 - 成功
![image](https://hackmd.io/_uploads/ByDofsxcp.png)

## 執行結果
![image](https://hackmd.io/_uploads/SJv2GoxcT.png)

## 練習結果Repo
https://github.com/gahgah147/go-restful-api-repository-messageboard

## 測試postmain 內容 export
```
{
	"info": {
		"_postman_id": "957a0737-049b-4605-b718-07ca8e13d683",
		"name": "GO Repository Restful API  留言板",
		"schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
		"_exporter_id": "4951341",
		"_collection_link": "https://martian-escape-400870.postman.co/workspace/GO-Repository-Restful-API-%25E7%259A%2584%25E7%2595%2599%25E8%25A8%2580%25E6%259D%25BF~4f66f5ef-49b8-47c3-918f-cf7a14414aa4/collection/4951341-957a0737-049b-4605-b718-07ca8e13d683?action=share&source=collection_link&creator=4951341"
	},
	"item": [
		{
			"name": "查詢全部留言",
			"request": {
				"method": "GET",
				"header": [],
				"url": {
					"raw": "http://127.0.0.1:8082/api/v1/message/",
					"protocol": "http",
					"host": [
						"127",
						"0",
						"0",
						"1"
					],
					"port": "8082",
					"path": [
						"api",
						"v1",
						"message",
						""
					]
				}
			},
			"response": []
		},
		{
			"name": "查詢留言",
			"request": {
				"method": "GET",
				"header": [],
				"url": {
					"raw": "http://127.0.0.1:8082/api/v1/message/",
					"protocol": "http",
					"host": [
						"127",
						"0",
						"0",
						"1"
					],
					"port": "8082",
					"path": [
						"api",
						"v1",
						"message",
						""
					]
				}
			},
			"response": []
		},
		{
			"name": "新增留言",
			"request": {
				"method": "POST",
				"header": [],
				"body": {
					"mode": "raw",
					"raw": "{\r\n    \"message\":{\r\n        \"id\":1,\r\n        \"User_Id\": 2,\r\n        \"Content\": \"早安\",\r\n        \"Version\": 0,\r\n        \"ID\": 0,\r\n        \"CreatedAt\": \"2022-03-29T17:39:33.014+08:00\",\r\n        \"UpdatedAt\": \"2022-03-29T17:39:33.014+08:00\",\r\n        \"DeletedAt\": null\r\n    }\r\n}",
					"options": {
						"raw": {
							"language": "json"
						}
					}
				},
				"url": {
					"raw": "http://127.0.0.1:8082/api/v1/message",
					"protocol": "http",
					"host": [
						"127",
						"0",
						"0",
						"1"
					],
					"port": "8082",
					"path": [
						"api",
						"v1",
						"message"
					]
				}
			},
			"response": []
		},
		{
			"name": "修改留言",
			"request": {
				"method": "POST",
				"header": [],
				"body": {
					"mode": "raw",
					"raw": "{\r\n    \"message\":{\r\n        \"id\":1,\r\n        \"User_Id\": 2,\r\n        \"Content\": \"早安\",\r\n        \"Version\": 0,\r\n        \"ID\": 0,\r\n        \"CreatedAt\": \"2022-03-29T17:39:33.014+08:00\",\r\n        \"UpdatedAt\": \"2022-03-29T17:39:33.014+08:00\",\r\n        \"DeletedAt\": null\r\n    }\r\n}",
					"options": {
						"raw": {
							"language": "json"
						}
					}
				},
				"url": {
					"raw": "http://127.0.0.1:8082/api/v1/message",
					"protocol": "http",
					"host": [
						"127",
						"0",
						"0",
						"1"
					],
					"port": "8082",
					"path": [
						"api",
						"v1",
						"message"
					]
				}
			},
			"response": []
		},
		{
			"name": "刪除留言",
			"request": {
				"method": "DELETE",
				"header": [],
				"body": {
					"mode": "raw",
					"raw": "{\r\n    \"message\":{\r\n        \"id\":1,\r\n        \"User_Id\": 2,\r\n        \"Content\": \"早安\",\r\n        \"Version\": 0,\r\n        \"ID\": 0,\r\n        \"CreatedAt\": \"2022-03-29T17:39:33.014+08:00\",\r\n        \"UpdatedAt\": \"2022-03-29T17:39:33.014+08:00\",\r\n        \"DeletedAt\": null\r\n    }\r\n}",
					"options": {
						"raw": {
							"language": "json"
						}
					}
				},
				"url": {
					"raw": "http://127.0.0.1:8082/api/v1/message/1",
					"protocol": "http",
					"host": [
						"127",
						"0",
						"0",
						"1"
					],
					"port": "8082",
					"path": [
						"api",
						"v1",
						"message",
						"1"
					]
				}
			},
			"response": []
		}
	]
}
```

# 加入Container 內容持久化設定
```
volumes:
            - ./db_data:/var/lib/mysql
```
在 yaml 中新增 Volumes，Volumes 會將資料存放於 Container 之外，範例中就是會把資料存放於 db_data 這個資料夾

```
db:
        image: mysql:5.7
        container_name: db
        command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
        environment:
            MYSQL_ROOT_PASSWORD: root
            MYSQL_DATABASE: go
        volumes:
            - ./db_data:/var/lib/mysql
        ports:
            - "3306:3306"
        restart: always
        networks:
          - default
```

# 設定container之間的連線

加入network設定
```
networks:
  default:
```

並調整 docker-compose 檔案
```
version: "2.1"

services:
    db:
        image: mysql:5.7
        container_name: db
        command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
        environment:
            MYSQL_ROOT_PASSWORD: root
            MYSQL_DATABASE: go
        volumes:
            - ./db_data:/var/lib/mysql
        ports:
            - "3306:3306"
        restart: always
        networks:
          - default
    phpmyadmin:
        image: phpmyadmin/phpmyadmin
        container_name: phpmyadmin
        environment:
            PMA_HOST: db
            PMA_PORT: 3306
        ports:
            - "8084:80"
        depends_on:
            - db
        networks:
          - default
    go-app:
        build: .
        container_name: go-app
        ports:
            - "8082:8082"
        depends_on:
            - db
        networks:
          - default

networks:
  default:
```

調整 connect.yaml
```
host: db
username: root
password: root
dbname: go
port: 3306
```

這邊設定 db連線到db這個 container

# 專案練習 Repo
https://github.com/gahgah147/go-restful-api-repository-messageboard

# 參考資料
https://github.com/880831ian/go-restful-api-repository-messageboard?tab=readme-ov-file

