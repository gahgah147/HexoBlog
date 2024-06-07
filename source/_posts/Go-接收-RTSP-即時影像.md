---
title: Go 接收 RTSP 即時影像
date: 2024-03-29 11:19:44
tags:
    - GO
    - RTSP
    - 即時影像
---

# Go 接收 RTSP 即時影像

# 前言
目前因為工作需求要接收RTSP即時影像，並且顯示在前端網頁

# 使用工具
RTSPtoWebRTC:
https://github.com/deepch/RTSPtoWebRTC

# RTSP 測試地址

| 來源 | RTSP | 延遲 |
| -------- | -------- | -------- |
| Nordland     | rtsp://77.110.228.219/axis-media/media.amp     | 200ms     |
| Norwich     | rtsp://37.157.51.30/axis-media/media.amp     | 250ms     |
| Orlando     | rtsp://97.68.104.34/axis-media/media.amp     | 350ms     |
| PriceCenterPlaza     | rtsp://132.239.12.145:554/axis-media/media.amp     | 280ms |
| Vaison-La-Romaine | rtsp://176.139.87.16/axis-media/media.amp   | 差 |
| VyhladJazero | rtsp://stream.strba.sk:1935/strba/VYHLAD_JAZERO.stream   | 160ms |
| Western Cape | rtsp://196.21.92.82/axis-media/media.amp   | 450ms |
| Zeeland | rtsp://213.34.225.97/axis-media/media.amp  | 270ms |
| Allendale | rtsp://71.83.5.156/axis-media/media.amp  | 270ms |
| Bedford Hills | rtsp://73.114.177.111/axis-media/media.amp  | 340ms |
		
> 也可以參考 https://timetickme.com/stream-a-video-over-rtsp-using-live555mediaserver 本地搭建RTSP服務器進行測試

# 測試流程

## 下載程式碼
```
git clone https://github.com/deepch/RTSPtoWebRTC  
```

## 到資料夾底下
```
cd RTSPtoWebRTC/
```

# 調整config.json
```
{
  "server": {
    "http_port": ":8083",
    "ice_servers": ["stun:stun.l.google.com:19302"]
  },
  "streams": {
      "01": {
        "on_demand" : false,
        "disable_audio": true,
        "url": "rtsp://77.110.228.219/axis-media/media.amp"
      },
      "02": {
        "on_demand" : true,
        "disable_audio": true,
        "url": "rtsp://37.157.51.30/axis-media/media.amp"
      },
      "03": {
        "on_demand" : false,
        "disable_audio": true,
        "url": "rtsp://97.68.104.34/axis-media/media.amp"
      },
      "04": {
        "on_demand" : false,
        "disable_audio": true,
        "url": "rtsp://132.239.12.145:554/axis-media/media.amp"
      },
      "05": {
        "on_demand" : false,
        "disable_audio": true,
        "url": "rtsp://176.139.87.16/axis-media/media.amp"
      },
      "06": {
        "on_demand" : false,
        "disable_audio": true,
        "url": "rtsp://stream.strba.sk:1935/strba/VYHLAD_JAZERO.stream"
      }
  }
}

```

## 測試部屬
```
GO111MODULE=on go run *.go
```

# 透過瀏覽器打開網頁
```
http://127.0.0.1:8083
```

![image](https://hackmd.io/_uploads/ByLZznQk0.png)
> 這邊找到測試用RTSP 就可以看到攝影機畫面


參考資料:https://timetickme.com/rtsp%E6%B5%8B%E8%AF%95%E5%9C%B0%E5%9D%80/

