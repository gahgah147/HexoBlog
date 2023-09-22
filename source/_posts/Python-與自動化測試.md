---
title: Python 與自動化測試
date: 2023-09-21 14:44:10
tags: Pthon 自動化測試 iThome鐵人賽
---


# 前言

這篇是記錄我在看鐵人賽 [Python 與自動化測試的敲門磚 ](https://ithelp.ithome.com.tw/articles/10290529) 的過程

# 主題

| 主題 | 日程 | 
| -------- | -------- | 
| 簡介     | day 01 | 
| Pytest     | day 02 ~ 10 | 
| TDD     | day 11 ~ 12 |  
| Selenium     | day 13 ~ 17 | 
| Appium     | day 18 ~ 21 | 
| CI/CD	    | day 22 ~ 26 | 
| Jenkins  | day 27 ~ 29 | 
| 結語  | day 30 | 

# Pytest 
Pytest 是一種使用在 Python 語言裡面的一中單元測試框架，而 Pytest 基本上就是由 Python 原生自帶的單元測試框架 Unittest 衍生出來的，所以可以看到有些範例可以和 Unittest 的套件互相兼容混用。

Pytest 和 Unittest 相比，有下列幾項優點：

1. 更易於上手，撰寫 testcase 時較為直覺
2. 擴展性高，可以兼容許多外掛套件
3. 可以標註某些 testcase 為失敗是正常的
4. 測試程式撰寫起來相較於 unittest 較為簡潔

# TDD
TDD 完整名稱為 Test-driven development，中譯為 "測試驅動開發"，是一種軟體開發的方式，以這種模式開發的軟體，會需要在開發程式的同時一併撰寫測試程式，簡單來說就是一個 function 產出就要產出一個相對應的 testcase，好處是可以快速的檢查各項功能有沒有發生錯誤，也可以避免在開發完成後再回來補血測試程式，造成某些功能遺漏沒有測到。

# Selenium
相信很多人對於 Selenium 並不陌生，近年來很常被應用在網路爬蟲上，可以比較簡單的對動態網頁進行爬取，Selenium 最初被開發出來的時候，其實是拿來進行網頁自動化測試的

# Appium
Appium 顧名思義，適用於測試手機 APP 的一個自動化測試的工具，是一個 Open Source 的專案，Appium 提供跨平台的操作，亦即它可以同時測試 IOS 以及 Android 甚至是 Desktop 的 API

# Jenkins 
除了 Gitlab、Github 之外，Jenkins 也是目前主流的 CI/CD 工具之一，由於 Jenkins 也是開源專案，因此發展速度非常快，也非常容易上手，這邊將花幾天的時間來介紹該如何進行 Jenkins 的操作以及環境的建置

接話來會將以上五個項目分別記錄文章

參考來源: https://ithelp.ithome.com.tw/articles/10290529