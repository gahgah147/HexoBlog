---
title: 使用Go與Gin框架串接Modbus TCP的完整指南
date: 2024-04-02 14:27:48
tags:
    - Go
    - Modbus TCP
---
# 使用Go與Gin框架串接Modbus TCP的完整指南

最近在著手開發一個跟漁農業相關的專案，需要透過 Modbus TCP 協定來取得設備上的資訊，這篇文章會紀錄一下 Modbus TCP 的基本概念及協定規格。

我們將探討如何使用Go語言和Gin框架來實現與Modbus TCP裝置的通信。這個主題對於需要在網頁應用中集成實時裝置控制和監控的開發者特別有用。我們會從基本原理開始，介紹測試工具，提供程式碼示例，並探討如何以MVC架構進行切分，以實現更好的代碼組織和維護性。

# 什麼是Modbus TCP?

![image](https://hackmd.io/_uploads/SJcatxFyR.png)

Modbus 是在工業領域中廣泛使用的訊息交換規範，而 Modbus TCP 則是 Modbus 的一種實現，它使用 TCP/IP 作為傳輸層協定，因此可以透過網路傳輸。

Modbus是一種廣泛使用的串行通信協議，被用於連接工業電子裝置。Modbus TCP則是其基於TCP/IP的變種，允許這些裝置通過網路進行通信。Go語言擁有出色的網路處理能力，配合Gin框架的高效率和簡潔性，可以輕鬆搭建出一個用於與Modbus裝置通信的後端服務。

# 關於 Modbus
Modbus 本身就是一種訊息交換的規範，而 Modbus TCP 則是透過 TCP/IP 來實現 Modbus 的一種方式，因此所有的訊息都是透過 TCP/IP 來傳輸。

Modbus 屬於 Client/Server 架構，在工業上會有一個 Server 來存放所有要被讀取的工業設備數據，如溫度、濕度、距離等資料；而 Client 則會傳送一定的訊息格式當做指令，來讀取設備資料（讀），或是叫設備去做些什麼事情（寫）。

無論是對 Modbus Server 發送讀或寫的指令，Server 都會回傳一個確認訊息，讓 Client 知道指令是否成功。整個 Modbus 的溝通就是建構在這個一來一回的訊息交換上。

![image](https://hackmd.io/_uploads/SJi89etyR.png)
>https://fullstackladder.dev/blog/2022/11/07/introduction-modbustcp/

在傳輸過程中，Client 與 Server 的訊息最少會有「Function Code」與「Data」兩個部分：

Function Code：代表要執行的動作代碼，如讀取或寫入。
Data：代表執行動作代碼的相關參數，例如讀取某個位址上的資料，或是回傳某個位址上的資料作為結果。
Function Code 和 Data 是整個 Modbus 溝通最基本的單元，也稱為 Protocol Data Unit (PDU)。

除此之外，根據傳輸方式不同可能還會再頭尾加上一些附加資訊，附加後的整個訊息稱為 Application Data Unit (ADU)。

![image](https://hackmd.io/_uploads/ByEFqlF1C.png)
>https://fullstackladder.dev/blog/2022/11/07/introduction-modbustcp/

Modbus 定義了許多的內建的 Function Code，每個 Function Code 伴隨著特定規則的 Data，在閱讀文件時，可以跟具我們要處理的 Function Code 找到對應的 Data 規則。

![image](https://hackmd.io/_uploads/H1V59etJA.png)
>https://fullstackladder.dev/blog/2022/11/07/introduction-modbustcp/


# 測試工具
在開發和測試Modbus TCP通信過程中，你可能會需要以下工具：

* Modbus模擬器（如Modsim）：模擬Modbus服務器（Slave），方便開發和測試。
* Modbus客戶端測試工具（如Modscan或QModMaster）：用於測試和調試與Modbus裝置的通信。


這些工具可以幫助你模擬實際的Modbus環境，進行開發和測試，無需實際的硬件裝置。

## Modbus Slave模擬器
![image](https://hackmd.io/_uploads/Sy0LoxF1C.png)
>https://www.azofreeware.com/2019/12/modbus-slave.html

## MODSCAN
![image](https://hackmd.io/_uploads/H1w6sxF1C.png)
>https://kknews.cc/zh-tw/news/ga4b86l.html

## QModMaster
![image](https://hackmd.io/_uploads/SyyGngYkA.png)
>https://sourceforge.net/projects/qmodmaster/

## Modbus/TCP Master
![image](https://hackmd.io/_uploads/H1zUheYkC.png)


# 程式實作
以下是使用Go語言和Gin框架來實現Modbus TCP通信的簡單示例。首先，我們需要安裝必要的Go包：
```
go get github.com/gin-gonic/gin
go get github.com/goburrow/modbus
```

然後，我們可以創建一個簡單的Gin後端服務，用於處理Modbus TCP請求：
```
package main

import (
    "github.com/gin-gonic/gin"
    "github.com/goburrow/modbus"
)

func main() {
    r := gin.Default()
    
    r.GET("/read", func(c *gin.Context) {
        handler := modbus.NewTCPClientHandler("192.168.1.1:502")
        defer handler.Close()
        client := modbus.NewClient(handler)
        
        results, err := client.ReadHoldingRegisters(1, 1)
        if err != nil {
            c.JSON(500, gin.H{"error": err.Error()})
            return
        }
        c.JSON(200, gin.H{"data": results})
    })

    r.Run() // listen and serve on 0.0.0.0:8080
}

```

# 進階MVC架構切分

在一個較大的項目中，為了保持代碼的清晰和可維護性，我們可以將應用劃分為模型（Model）、視圖（View）和控制器（Controller）三個部分，即所謂的MVC架構。

模型（Model）：與Modbus裝置的通信邏輯，例如讀寫寄存器的功能。
視圖（View）：在這個上下文中，視圖可以是返回給客戶端的JSON數據格式。
控制器（Controller）：處理HTTP請求，調用模型執行操作，並決定返回哪個視圖。
這樣的結構使得代碼更加模組化，易於測試和維護。控制器負責路由和請求處理，模型實現具體的業務邏輯，視圖則是數據的表示。

## 模型 (Model)
模型層封裝了與Modbus裝置通信的邏輯。這裡，我們定義一個ModbusService來處理與Modbus裝置的通信：

```
// modbusService.go
package service

import (
    "github.com/goburrow/modbus"
)

type ModbusService struct {
    Client modbus.Client
}

func NewModbusService(address string) *ModbusService {
    handler := modbus.NewTCPClientHandler(address)
    handler.Connect()
    return &ModbusService{
        Client: modbus.NewClient(handler),
    }
}

func (m *ModbusService) ReadRegister(address, quantity uint16) ([]byte, error) {
    return m.Client.ReadHoldingRegisters(address-1, quantity)
}

```

## 控制器 (Controller)
控制器層負責處理HTTP請求，調用模型來執行操作，並返回視圖。在這個例子中，我們創建一個控制器來處理讀取請求：

```
// modbusController.go
package controller

import (
    "net/http"
    "strconv"

    "github.com/gin-gonic/gin"
    "your_project/service" // 替換成你的專案名稱
)

type ModbusController struct {
    Service *service.ModbusService
}

func NewModbusController(service *service.ModbusService) *ModbusController {
    return &ModbusController{
        Service: service,
    }
}

func (mc *ModbusController) ReadRegister(c *gin.Context) {
    address, _ := strconv.ParseUint(c.Query("address"), 10, 16)
    quantity, _ := strconv.ParseUint(c.Query("quantity"), 10, 16)

    data, err := mc.Service.ReadRegister(uint16(address), uint16(quantity))
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }

    c.JSON(http.StatusOK, gin.H{"data": data})
}

```

## 路由設定 (Routing)
最後，在main.go中設定路由並初始化控制器和模型。這裡我們將路由、控制器和模型結合起來：

```
// main.go
package main

import (
    "github.com/gin-gonic/gin"
    "your_project/controller" // 替換成你的專案名稱
    "your_project/service"    // 替換成你的專案名稱
)

func main() {
    r := gin.Default()
    modbusService := service.NewModbusService("192.168.1.1:502")
    modbusController := controller.NewModbusController(modbusService)

    r.GET("/read", modbusController.ReadRegister)

    r.Run() // listen and serve on 0.0.0.0:8080
}
```

這樣，我們就完成了一個基於MVC架構的應用，這個應用可以通過Gin框架處理HTTP請求，並通過Modbus TCP與裝置進行通信。這個架構使得代碼更加清晰且易於維護，特別適合於較大型的項目。

# 結論
通過使用Go語言和Gin框架，我們可以構建一個強大的後端應用，用於實現與Modbus TCP裝置的通信。這篇指南僅僅是一個起點，Modbus TCP的實際應用場景非常廣泛，從簡單的數據讀取到復雜的自動化控制系統都有可能。希望這篇文章能夠幫助你開始這樣的項目，並為你提供一些有用的工具和概念。