---
title: Flutter 學習紀錄 - Day 3 – Dart Language 學習
date: 2024-07-30 16:39:45
tags:
 - Flutter
categories:
keywords:
description:
top_img:
comments:
cover: https://hackmd.io/_uploads/HkzO5f8KR.png
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---
# Flutter 學習紀錄 - Day 3 – Dart Language 學習

# Dart 官方說明教學文件
![image](https://hackmd.io/_uploads/Hy_5_z8K0.png)
>https://dart.dev.org.tw/overview

## Dart：語言

Dart 是一種類型安全的程式語言，設計用於確保變數的值始終與其靜態類型相符。這種方式稱為健全類型檢查。雖然 Dart 的類型是強制性的，但類型註解是可選的，因為 Dart 支援類型推論。這意味著即使你不明確指定類型，Dart 也能自動推斷出變數的類型。

Dart 的類型系統非常靈活，允許使用 `dynamic` 類型來結合執行時期檢查。這在需要編寫特別動態的程式碼或進行實驗時非常有用。

### 健全的空安全

Dart 內建了健全的空安全機制。這表示除非你明確允許變數為空，否則它們的值不能為空。這種空安全機制能夠透過靜態程式碼分析在執行時期保護你免於空例外。

與其他一些空安全語言不同的是，當 Dart 確定變數為非空時，該變數在執行時期將始終保持非空。如果你在偵錯器中檢查程式碼的執行情況，你會看到非空性在執行時期得到保留，這就是所謂的健全空安全。

這些特性使得 Dart 成為一個非常可靠和強大的語言，特別適合用於構建高效能且穩定的應用程式。


## Dart：函式庫

Dart 有一個 豐富的核心函式庫集，提供許多日常程式設計任務的基本要素

* 每個 Dart 程式（dart:core）的內建類型、集合和其他核心功能
* 更豐富的集合類型，例如佇列、連結串列、雜湊映射和二元樹（dart:collection）
* 用於在不同資料表示法之間轉換的編碼器和解碼器，包括 JSON 和 UTF-8（dart:convert）
* 數學常數和函數，以及隨機數字產生（dart:math）
* 支援非同步程式設計，使用 Future 和 Stream 等類別（dart:async）
* 有效處理固定大小資料（例如，未簽署的 8 位元組整數）和 SIMD 數值類型的清單（dart:typed_data）
* 檔案、socket、HTTP 和其他 I/O 支援，適用於非網路應用程式（dart:io）
* 外國函數介面，用於與呈現 C 風格介面的其他程式碼進行互操作（dart:ffi）
* 使用隔離進行並行程式設計，獨立的工作人員類似於執行緒，但不會共用記憶體，僅透過訊息進行通訊（dart:isolate）
* HTML 元素和其他資源，適用於需要與瀏覽器和文件物件模型 (DOM) 互動的基於網路的應用程式（dart:html）


除了核心函式庫之外，許多 API 都透過全面的套件集提供。Dart 團隊發布許多有用的補充套件，例如

* 字元
* intl
* http
* 加密
* 標記語言


此外，第三方發行商和更廣大的社群會發布數千個套件，支援下列功能

* XML
* Windows 整合
* SQLite
* 壓縮

若要查看一系列使用 Dart 核心函式庫的範例，請閱讀 [核心函式庫文件](https://dart.dev.org.tw/libraries)。若要尋找其他 API，請參閱 [常用套件頁面](https://dart.dev.org.tw/guides/libraries/useful-libraries)。


## Dart：平台

Dart 的編譯器技術非常靈活，能夠讓您以不同的方式執行程式碼，適用於多種平台。

### 原生平台

針對行動裝置和桌上型電腦應用程式，Dart 提供了兩種編譯方式：

- **即時編譯 (JIT)**：在開發期間，Dart VM 可以即時編譯程式碼，讓開發者能夠快速測試和調整程式碼。
- **提前編譯 (AOT)**：在發佈應用程式時，Dart 編譯器會將程式碼轉換為機器碼，確保應用程式在裝置上能夠高效執行。

### 網頁平台

針對網頁應用程式，Dart 可以編譯為 JavaScript，方便在各種瀏覽器上運行。這種編譯可以用於開發和生產環境，確保網頁應用的兼容性和效能。


![image](https://hackmd.io/_uploads/HkzO5f8KR.png)
>https://dart.dev.org.tw/overview#platform


# DartPad - 練習平台

![image](https://hackmd.io/_uploads/H1oGjGUF0.png)
>https://dartpad.dev/

DartPad 是一個線上工具，能在瀏覽器中撰寫、執行和分享 Dart 程式碼，無需安裝任何軟體。

以下是一些 DartPad 的主要功能：

* 即時編輯和執行：可以即時撰寫和執行 Dart 程式碼，立即看到結果，這對於學習和測試程式碼片段非常有用。

* 範例程式碼：DartPad 提供了豐富的範例程式碼，可以快速瞭解 Dart 語言和 Flutter 框架的各種功能和特性。

* 分享程式碼：可以輕鬆地分享您的程式碼片段和結果，方便與他人協作和討論。
使用 DartPad，您可以快速開始學習和探索 Dart 和 Flutter，而不需要進行任何設定或安裝。

這邊可以參考Dart 官方簡介文件說明做完整的一個練習。

![image](https://hackmd.io/_uploads/r1M0iMIKR.png)
>https://dart.dev.org.tw/language

# 資料型態


| 資料型態    | 說明                                                                 | 範例                                                         |
|-------------|--------------------------------------------------------------------|--------------------------------------------------------------|
| **var**     | 類似於 JavaScript 的變數宣告，根據初始化的值自動推斷型別，但一旦賦值後型別不可更改 | `var myVar = 42;`                                             |
| **Object**  | 所有型別的根基礎類別。每個 Dart 型別都繼承自 `Object`                   | `Object myObject = "Hello, Dart!";`                           |
| **dynamic** | 允許在編譯時期跳過型別檢查，明確表示可以在執行時期變更型別                  | `dynamic myDynamic = 10; myDynamic = "Now I'm a string!";` |
| **num**     | `int` 和 `double` 的父類別，表示數值型資料的抽象                           | `num myNum = 3.14;`                                           |
| **int**     | 表示整數型別                                                             | `int myInt = 123;`                                            |
| **double**  | 表示雙精度浮點數型別                                                        | `double myDouble = 456.78;`                                   |
| **bool**    | 表示布林值型別，只有 `true` 和 `false` 兩個值                               | `bool myBool = true;`                                         |
| **String**  | 表示字串型別                                                             | `String myString = "Dart is great!";`                         |
| **Symbol**  | 表示 Dart 程式中的符號，用於反射（reflection）                                | `Symbol mySymbol = #mySymbol;`                                |
| **List<T>** | 類似於 Python 的列表，支持泛型，用於表示有序集合                               | `List<int> myList = [1, 2, 3];`                               |
| **Map<K, V>** | 類似於 Python 的字典，支持泛型，用於表示鍵值對集合                           | `Map<String, int> myMap = {'one': 1, 'two': 2, 'three': 3};`  |


    
Dart擁有int、double、String、bool等常見的變數型態
    
在定義變數的時候可以選擇給他明確的型態或是用「var」讓Dart來幫忙決定

```
void main() {
  var a = 1; //int 整數
  var b = "1"; // String 字串
  var c = 1.1; // double 浮點數
  
  if (a is int) {
    print('a is int'); // Output： a is int
  }
  if (b is String) {
    print('b is String'); // Output： b is String
  }
  if (c is double) {
    print('c is double'); // Output： c is double
  }
} 
```
![image](https://hackmd.io/_uploads/BkkmafUtR.png)

    
需要注意的是假如用的是var在宣告賦值後就不能再賦予它其他型態的值了。
    
```
void main() {
  var a = 1;
  a = "123"; // Error: A value of type 'String' can't be assigned to a variable of type 'int'.
}
```
![image](https://hackmd.io/_uploads/BJbw6GLt0.png)

如上圖所示會發生錯誤
    
也可以使用dynamic來做宣告，dynamic是所有物件的基礎類型，也就是說它可以代表任何物件。
換句話來說，Dart的「dynamic」和JavaScript的「var」非常相似，可以隨時替換不同型態的值給變數。
    
```
void main() {
  dynamic a = 1;
  a = '123';  // no error

}
```
![image](https://hackmd.io/_uploads/r1diaGItA.png)

雖然這次也是使用var來宣告，但卻可以替換成不同型態的值，這是由於一開始並未給變數a初始值，因此var會給予變數a dynamic型態，所以就算替換了不同型態的值也不會報錯。
```
void main() {
  var a;
  a = 1;
  print(a); // Output：1
  a = "123";
  print(a); // Output： 123
}
```
![image](https://hackmd.io/_uploads/Sk5JRM8t0.png)

## List 

定義 List 需要使用方括號 []。可以在宣告時定義儲存值的型態，或者使用 dynamic 來接受所有型態。如果希望 List 內的值不被更動，在宣告時可以使用 const 關鍵字來把值固定，這樣之後就無法對 List 做新增、修改、刪除操作。
    
List 可以儲存任意型態的資料。
使用 const 宣告的 List 是不可變的，無法修改其內容。
支持泛型，可以在宣告時指定儲存的值的型態。
透過這些特性，Dart 的 List 能夠提供靈活且強大的資料結構來管理和操作集合數據。

```
void main() {
  List<dynamic> a = const [1, '123', true];
  print(a[1]); // Output：123
  a.add(123); // error
}
```
![image](https://hackmd.io/_uploads/ByxgMQ8tC.png)

## Map
    
最後要介紹的是Map，Map是使用key-value的方式來儲存的資料型態，Map是使用大括號{}，以Key:Value的方式定義。
之後在實作專案裡面會使用到Map來儲存從Youtube Api回傳過來的JSON Data，大家可以先去看一下JSON是怎麼樣的資料格式喔~

```
void main() {
  var map = {
    'key1': 'value1',
    'key2': 'value2',
    'key3': 'value3'
  };
 
  print(map['key1']);    // Output: value1
  print(map['test']);    // Output: null
 
  map['key4'] = 'value4';
  
  //Length  
  print(map.length); //Output： 4
 
  print(map.containsKey('value1')); // Output： false
 

  print(map.entries); // Output： (MapEntry(key1: value1), MapEntry(key2: value2), MapEntry(key3: value3), MapEntry(key4: value4))
  print(map.values); // Output： (value1, value2, value3, value4)
}
```

![image](https://hackmd.io/_uploads/Sy-a77LFC.png)

# 總結
    
今天整理了 Dart 語言的基本概念和特性，包括其類型系統、函式庫、平台支援以及一些常用的資料型態，還有Dart 語言特性跟DartPad 的練習平台。