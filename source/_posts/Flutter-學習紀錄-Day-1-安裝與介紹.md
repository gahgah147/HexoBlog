---
title: Flutter 學習紀錄 - Day 1 安裝與介紹
date: 2024-07-30 10:09:49
tags:
 - Flutter
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/SJY_aRlKA.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---
# Flutter 學習紀錄 - Day 1 安裝與介紹

# 什麼是Flutter
![image](https://hackmd.io/_uploads/SJY_aRlKA.png)
>https://flutter.dev/

Flutter 是由 Google 開發的一個開源框架，使用 Dart 程式語言寫一份Code可以同時讓iOS與Android平台使用，也支援Web以及桌面應用程式。

主要特點如下：

## 主要特點
### 跨平台：
Flutter 允許開發者使用單一代碼庫同時構建 Android 和 iOS 應用，甚至可以用於網頁和桌面應用的開發。

### 高性能：
由於 Flutter 直接編譯成原生代碼，因此性能優越，可以達到原生應用的流暢度。

### 豐富的組件庫：
提供了大量的預製組件（Widgets），這些組件可以高度定制，滿足不同設計需求。

### 熱重載：
Flutter 支持熱重載（Hot Reload），使得開發者可以快速查看代碼修改結果，大幅提升開發效率。

### 單一代碼語言：
使用 Dart 編程語言，簡化了開發過程，特別是對於那些需要同時支持多個平台的應用。

## 優點 
### 快速開發：
由於熱重載功能和豐富的組件庫，開發者可以更快更新和測試應用。

### 一致的 UI 表現:
Flutter 的組件是基於自己繪製的，因此無論在什麼平台上，UI 表現都一致。

### 強大的社群支持：
Flutter 擁有一個活躍且不斷增長的社群，提供了大量的資源和插件，幫助開發者解決各種問題。

## Fltter檔案構造


```
flutter_project/
│
├── lib/
├── test/
│   └── widget_test.dart
├── android/
├── ios/
├── assets/
└── pubspec.yaml
```

### lib
主要的 Dart 代碼存放處，包含應用程式的主要邏輯和功能。

### test
用於存放測試代碼的地方。在這個資料夾中，你可以編寫單元測試和集成測試。

### android
Android 平台的原生代碼存放處。通常你不太需要直接操作這個資料夾，除非你有特定的 Android 平台需求。
### ios
iOS 平台的原生代碼存放處。與 android 資料夾一樣，大多數情況下你不需要直接處理這個資料夾。

### assets
存放應用程式資源檔案的地方，如圖片、字體文件等。在 Dart 代碼中，你可以使用 AssetImage 或類似的類來訪問這些資源。
### test中的 widget_test.dart 文件（可選）
默認的測試文件，用於測試應用程式的 Widget。你可以在這裡添加和擴展測試。

# Fltter教學資源

以下是網路上參考的學習資源

## HKT 線上教室 Flutter 程式設計入門實戰 30 天
![image](https://hackmd.io/_uploads/ByjVuYEFA.png)
>https://ithelp.ithome.com.tw/users/20096484/ironman/2699

## 猫哥 — Flutter 零基础入门中文教学
![image](https://hackmd.io/_uploads/ry2zdKEFA.png)
>https://www.youtube.com/watch?v=C1emOeteMmc&list=PL274L1n86T839P6Bqd3M2knHhLjU0wRMG

## Flutter中文网
![image](https://hackmd.io/_uploads/HJBy_tNF0.png)
>https://doc.flutterchina.club/tutorials/

## Flutter---Google推出的跨平台框架，Android、iOS一起搞定
![image](https://hackmd.io/_uploads/Skp73p4tA.png)
>https://ithelp.ithome.com.tw/users/20119550/ironman/2221

# 下載 Flutter

## 方法一 (推薦)
### 安裝Git for Windows(https://git-scm.com/download/win)
### 下載Flutter SDK
在C槽點滑鼠右鍵「Git bash here」，便會開啟git bash，你就可以在裡面下git command。
![image](https://hackmd.io/_uploads/rJhvkyZFC.png)


接著輸入git clone -b stable https://github.com/flutter/flutter.git
電腦就會自己去找Flutter官方發布的最新穩定版本並下載到當前資料夾。

# 安裝Flutter
## 進到flutter資料夾，執行flutter_console.bat

![image](https://hackmd.io/_uploads/HJ7XeJbF0.png)

執行後會跳出以下畫面
![image](https://hackmd.io/_uploads/B1V8lkWtR.png)

輸入以下指令 檢查電腦環境，並下載Dart的SDK
```
flutter doctor
```
![image](https://hackmd.io/_uploads/BkojgJ-FC.png)


![image](https://hackmd.io/_uploads/rkY1Q1WK0.png)

{% note warning simple %}
最後會產生一個簡易的報表，這時會看到一些錯誤或警告。
別緊張，後面的步驟會一步一步處理它們。

先看一下有哪些錯誤

[X] Android toolchain - develop for Android devices
    X Unable to locate Android SDK.
    
[X] Visual Studio - develop Windows apps
    X Visual Studio not installed; this is necessary to develop Windows apps.
    
[!] Android Studio (not installed) 
{% endnote %}

## 設定安裝 
```
bin/sdkmanager --sdk_root="C:\Android\Sdk" --install "cmdline-tools;latest"
```
## 接受 Android SDK 授權協議

```
flutter doctor --android-licenses
```

## 設定環境變數

搜尋環境變數
![image](https://hackmd.io/_uploads/HkflEkWYR.png)

點選環境變數
![image](https://hackmd.io/_uploads/HyqNE1-FC.png)

在使用者變數區域找到「path」變數
![image](https://hackmd.io/_uploads/HyVIVy-FC.png)

新增一個路徑到C:\flutter\bin
![image](https://hackmd.io/_uploads/H1ytVybYR.png)


完成這個步驟之後就可以直接在cmd或powershell使用flutter commands，

## 下載安裝Android Studio

![image](https://hackmd.io/_uploads/ByVdrk-FC.png)
>https://developer.android.com/studio?hl=zh-tw#get-android-studio

這邊發現好像改版成 Android Studio Koala了

![image](https://hackmd.io/_uploads/ryySFFNY0.png)

![image](https://hackmd.io/_uploads/SJ3UFF4YC.png)

![image](https://hackmd.io/_uploads/rJYutYEFC.png)

![image](https://hackmd.io/_uploads/HJO5tKEYA.png)

![image](https://hackmd.io/_uploads/r15Q9FVFC.png)

![image](https://hackmd.io/_uploads/HJPV5FEYC.png)

![image](https://hackmd.io/_uploads/BkIDctNFC.png)

![image](https://hackmd.io/_uploads/Sk7FcY4tA.png)

![image](https://hackmd.io/_uploads/H1ljqYEY0.png)

![image](https://hackmd.io/_uploads/SJLC5FNKR.png)

### 設定模擬器


### 設定 C/C++ for Visual Studio Code
參考文件:https://code.visualstudio.com/docs/languages/cpp

![image](https://hackmd.io/_uploads/S1jkS9NY0.png)

![image](https://hackmd.io/_uploads/ryMWr9EYR.png)

後來發現這個操作沒有效，還是要直接安裝 Visual Studio

## 安裝visual studio
選擇 Desktop development with C++
![image](https://hackmd.io/_uploads/BySy66VK0.png)
因為以上這個問題，所以需要安裝visual studio 的 C++  workload


![image](https://hackmd.io/_uploads/SJkcYarYC.png)
>目前遇到這個問題，不知道如何處理，暫時忽略

## 安裝 cmdline-tools 組件

1.使用 SDK Manager 安裝 cmdline-tools
打開命令提示符或 PowerShell。

2.導航到你的 Android SDK 安裝目錄下的 cmdline-tools/bin 目錄。例如，如果你的 SDK 安裝在 C:\Users\<你的用戶名>\AppData\Local\Android\Sdk，那麼命令應該是：

```
cd C:\Users\<你的用戶名>\AppData\Local\Android\Sdk\cmdline-tools\latest\bin

```

3.執行以下命令來安裝最新的 cmdline-tools：
```
sdkmanager --install "cmdline-tools;latest"
```

接受 Android SDK 許可
在命令提示符中輸入以下命令來接受所有 Android SDK 許可：
```
flutter doctor --android-licenses
```

![image](https://hackmd.io/_uploads/SJGTw5EtC.png)


### 安裝Flutter和dart plugin
![image](https://hackmd.io/_uploads/HyYgAKEKR.png)


## 目前實測操作結果如下
![image](https://hackmd.io/_uploads/r1oEYpBtC.png)


## 結尾
今天實際操作了 Flutter 的安裝，後續的Java 需要設定環境變數跟 android studio 安裝都花了比較多的時間，另外 安裝 Visual Studio 也是花了很久的時間特別麻煩，而且很佔空間，另外遇到以下錯誤

錯誤碼 1310: 拒絕存取
Window Installer 服務要安裝 Visual Studio 所需封裝時，無法存取這部電腦的登錄或檔案系統。如果 Windows Defender 或其他防毒軟體會限制存取，就可能發生這種情況。

修正方式: 請檢查您的防毒設定，並確認 Windows Installer 服務對登錄和檔案系統有不受限制的存取權。

這部分目前打算暫時先略過，之後再來處理。