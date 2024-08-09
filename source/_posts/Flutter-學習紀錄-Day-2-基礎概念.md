---
title: Flutter 學習紀錄 - Day 2 基礎概念
date: 2024-07-30 11:16:18
tags:
 - Flutter
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/S1WdXASF0.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---
# Flutter 學習紀錄 - Day 2 基礎概念

# Flutter的架構

Flutter 是一個跨平台 UI 工具組，設計用於允許在作業系統（例如 iOS 和 Android）之間重複使用程式碼，同時也允許應用程式直接與底層平台服務介接。目標是讓開發人員能夠提供在不同平台上感覺自然的高效能應用程式，在它們存在差異的地方採用差異，同時盡可能共用程式碼。

在開發期間，Flutter 應用程式會在 VM 中執行，該 VM 提供狀態熱重載變更，而不需要完全重新編譯。對於發行，Flutter 應用程式會直接編譯成機器碼，無論是 Intel x64 或 ARM 指令，還是針對網路的 JavaScript。此架構是開放原始碼的，採用寬鬆的 BSD 授權，並擁有蓬勃發展的第三方套件生態系統，補充核心程式庫功能。

此概觀分為多個區段

* 圖層模型：建構 Flutter 的部分。
* 反應式使用者介面：Flutter 使用者介面開發的核心概念。
* 小工具簡介：Flutter 使用者介面的基本建構區塊。
* 渲染處理：Flutter 如何將 UI 程式碼轉換成像素。
* 平台嵌入器概觀：讓行動和桌上型作業系統執行 Flutter 應用程式的程式碼。
* 將 Flutter 與其他程式碼整合：關於 Flutter 應用程式可用的不同技術的資訊。
* 支援網路：關於瀏覽器環境中 Flutter 特性的結論性說明。

## 架構圖層
Flutter 被設計為可擴充的圖層系統。它以一系列獨立的程式庫存在，每個程式庫都依賴於底層圖層。沒有任何圖層具有對下方圖層的特權存取權，而且架構層的每個部分都設計為可選和可替換的。
![image](https://hackmd.io/_uploads/S1WdXASF0.png)
>https://flutter.dev.org.tw/resources/architectural-overview

Flutter的架構分成三層：

### Framework
Framework 層是 Flutter 的高層部分，主要是由 Dart 語言撰寫。這一層提供了構建應用程式的基本結構和工具。它包含了以下幾個子層：

* Widgets：Flutter 提供了豐富的 Widget 集合，用於構建複雜的 UI 元件。這些 Widget 是 Flutter 應用程式的核心，所有的視圖和互動都由這些 Widget 組成。

* Rendering：這個子層負責將 Widget 渲染到螢幕上。它處理佈局、繪製和動畫等操作，確保 Widget 能夠正確顯示和互動。

* Animation and Gestures：提供了動畫和手勢的支援，讓開發者能夠輕鬆地添加豐富的動畫效果和處理用戶的手勢輸入。
### Engine

Engine 層是 Flutter 的核心，它由 C++ 編寫，並且負責低層次的渲染和輸入處理。這一層提供了跨平台的渲染和執行環境，使得 Flutter 應用能夠在不同的平台上運行。Engine 包含以下主要組件：

* Skia：一個開源的 2D 圖形庫，用於繪製所有的圖形元素。Skia 提供了高效的繪圖性能，確保 Flutter 應用能夠流暢運行。

* Dart Runtime：運行 Dart 程式碼的執行環境，負責 Dart 程式碼的編譯和執行。

* Text：提供了文字渲染的支援，包括複雜的文字佈局和渲染。

### Embedder

Embedder 層負責將 Flutter 應用嵌入到特定的操作系統中。這一層提供了與底層平台互動的介面，使得 Flutter 可以在不同的操作系統上運行。Embedder 包含以下功能：

* Platform Channels：用於 Dart 和原生平台代碼之間的通信。這使得 Flutter 應用能夠調用原生平台的 API，並且讓原生平台能夠調用 Dart 程式碼。

* Event Loop：處理操作系統的事件，如輸入事件和畫面更新，並將這些事件傳遞給 Flutter 應用。

* Window Management：管理應用的窗口和視窗，使得 Flutter 應用能夠在不同平台上以正確的大小和位置顯示。


# 跨平台開發工具比較

與 APP 開發相關的主要跨平台開發框架和工具包括以下幾個：

### 1. **Flutter**

![image](https://hackmd.io/_uploads/SkF5LCBKA.png)
>https://docs.flutter.dev/
- **語言**：Dart
- **描述**：由 Google 開發的框架，可以構建高效能的原生應用。其特點包括豐富的 widget 庫和優秀的 Hot Reload 功能。
- **特點**：
  - 高效能，直接編譯成原生代碼。
  - 擁有豐富的預設元件和插件。
  - 支援 iOS、Android、Web 和桌面應用。

### 2. **React Native**
![image](https://hackmd.io/_uploads/SJ7i_CHtA.png)
>https://reactnative.dev/
- **語言**：JavaScript
- **描述**：由 Facebook 開發，使用 JavaScript 和 React 來構建原生應用。具有廣大的社群和豐富的第三方資源。
- **特點**：
  - 使用 JavaScript 和 React 來開發。
  - 可以共享大部分代碼於 iOS 和 Android 平台。
  - 需要透過 JavaScript Bridge 與平台溝通。

### 3. **Ionic**
![image](https://hackmd.io/_uploads/SysxFArYR.png)
>https://ionicframework.com/
- **語言**：JavaScript (Angular, React, Vue)
- **描述**：基於 web 技術的框架，使用 HTML、CSS 和 JavaScript 來構建跨平台應用。依賴於 Cordova 和 Capacitor。
- **特點**：
  - 使用流行的 web 框架（如 Angular、React、Vue）。
  - 可以通過 WebView 將應用包裝成原生應用。
  - 支援廣泛的插件和原生功能訪問。

### 4. **Apache Cordova (PhoneGap)**
![image](https://hackmd.io/_uploads/B1oXtRSK0.png)
>https://cordova.apache.org/
- **語言**：HTML, CSS, JavaScript
- **描述**：使用 web 技術來構建移動應用，並包裝成原生應用在各種平台上運行。
- **特點**：
  - 通過 WebView 渲染應用內容。
  - 支援多種平台（iOS、Android 等）。
  - 插件系統豐富，能訪問各種原生功能。

### 5. **Kotlin Multiplatform Mobile (KMM)**
![image](https://hackmd.io/_uploads/Byt8tRrY0.png)
>https://www.jetbrains.com/kotlin-multiplatform/
- **語言**：Kotlin
- **描述**：由 JetBrains 提供，允許使用 Kotlin 來共享業務邏輯代碼，同時在 Android 和 iOS 上運行。
- **特點**：
  - 專注於共享邏輯層，UI 層使用平台原生方式實現。
  - 提供 Kotlin 語言的所有優勢和功能。
  - 與 Android 原生開發無縫整合。

### 6. **Unity**
![image](https://hackmd.io/_uploads/SkSYYCBt0.png)
>https://unity.com/cn 

- **語言**：C#
- **描述**：主要用於遊戲開發，但也能用於構建各種跨平台的應用。
- **特點**：
  - 支援多種平台，包括 iOS、Android、Windows、macOS。
  - 強大的 2D 和 3D 渲染能力。
  - 擁有廣泛的插件和資源庫。

### 8. **NativeScript**
![image](https://hackmd.io/_uploads/Sk1vcCHKA.png)
>https://nativescript.org/
- **語言**：JavaScript, TypeScript
- **描述**：允許使用 JavaScript 或 TypeScript 來構建原生移動應用。
- **特點**：
  - 提供對原生 API 的直接訪問。
  - 可以使用 Angular 或 Vue.js 來構建應用。
  - 支援 iOS 和 Android。

當然可以，以下是調整後的比較表：

| 框架/工具                         | **Flutter**                                             | **React Native**                                        | **.NET MAUI**                                            | **Ionic**                                                | **Apache Cordova (PhoneGap)**                            | **Kotlin Multiplatform Mobile (KMM)**                    | **Unity**                                                | **NativeScript**                                         |
|-----------------------------------|---------------------------------------------------------|---------------------------------------------------------|----------------------------------------------------------|----------------------------------------------------------|----------------------------------------------------------|----------------------------------------------------------|----------------------------------------------------------|----------------------------------------------------------|
| **語言**                          | Dart                                                    | JavaScript                                              | C#                                                       | JavaScript (Angular, React, Vue)                         | HTML, CSS, JavaScript                                    | Kotlin                                                   | C#                                                       | JavaScript, TypeScript                                   |
| **Hot Reload 支援**               | 支援                                                    | 支援                                                    | 支援                                                     | 支援                                                     | 支援                                                     | 不支援                                                   | 支援                                                     | 支援                                                     |
| **發展時間**                      | 2017年                                                  | 2015年                                                  | 2021年                                                   | 2013年                                                   | 2009年                                                   | 2019年                                                   | 2005年                                                   | 2014年                                                   |
| **Component 支援**                | 由 Google 開發，預設豐富                                | 需要第三方支援                                          | 由 Microsoft 支持，與 .NET 生態系統整合                  | 需要第三方支援                                           | 需要第三方支援                                           | 需自行開發                                               | 豐富，針對遊戲開發                                       | 需要第三方支援                                           |
| **文件品質**                      | 詳細易讀                                                | 第三方 Library 文件品質不一                             | 詳細易讀                                                 | 第三方 Library 文件品質不一                              | 第三方 Library 文件品質不一                              | 詳細易讀                                                 | 詳細易讀                                                 | 詳細易讀                                                 |
| **社群成熟度**                    | 發展中                                                  | 成熟                                                    | 發展中                                                   | 成熟                                                     | 成熟                                                     | 發展中                                                   | 成熟                                                     | 發展中                                                   |
| **效能**                          | 直接轉成 native code                                    | 需透過 Bridge 與平台溝通                                | 直接訪問原生 API                                         | 基於 WebView                                            | 基於 WebView                                            | 直接訪問原生 API                                         | 高效能 2D 和 3D 渲染                                     | 直接訪問原生 API                                         |
| **App 大小**                      | 較小                                                    | 較大                                                    | 中等                                                     | 中等                                                     | 中等                                                     | 中等                                                     | 較大                                                     | 中等                                                     |
| **特色與備註**                    | 高效能，豐富的 widget 庫和 Hot Reload 功能              | 使用 JavaScript 和 React 開發，廣大的社群與資源         | 繼承自 Xamarin，與 Visual Studio 緊密整合               | 使用 web 技術構建應用，依賴於 Cordova 和 Capacitor       | 使用 web 技術構建應用，廣泛的平台支持                   | 共享邏輯層，UI 層使用平台原生方式實現                   | 遊戲開發為主，但可構建各種應用，支持多平台               | 使用 Angular 或 Vue.js 構建應用，支援 iOS 和 Android    |

# 總結

- **Flutter** 是一個強大且高效的框架，適合構建高性能、原生體驗的跨平台應用。
- **React Native** 具有廣大的社群和資源，使用 JavaScript 和 React，是許多開發者的首選。
- **.NET MAUI** 繼承自 Xamarin，與 .NET 和 Visual Studio 緊密結合，適合已有 C# 技能的開發者。
- **Ionic** 和 **Cordova** 適合使用 web 技術開發應用的團隊，具有較好的跨平台支持。
- **Kotlin Multiplatform Mobile (KMM)** 提供共享業務邏輯的能力，適合 Android 和 iOS 原生開發者。
- **Unity** 適合需要高效能 2D/3D 渲染的應用，尤其是遊戲開發。
- **NativeScript** 允許使用 Angular 或 Vue.js 構建應用，提供直接訪問原生 API 的能力。

這些框架各有優勢和適用場景，選擇哪一個取決於你的具體需求和技術背景。希望這些比較能對你有所幫助。
