---
title: 優化前端分析：Agoda 開發者的品質策略與工具
date: 2023-11-27 10:23:42
tags: 
 - Agoda Engineering 部落格
 - 前端
 - Front End Analytics
 - Front End
---

這篇文章是我在 [Agoda Engineering 部落格](https://medium.com/agoda-engineering)的文章閱讀紀錄
[Refining Front End Analytics: Quality Strategies and Tools for Developers at Agoda](https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f)

# Front End (FE) Analytics at Agoda

在Agoda，前端（FE）分析是一個動態框架，旨在追蹤使用者在前端應用程式中的行為和互動。
這個系統每天處理超過35億個事件，並分析超過1500個上下文字段，對於塑造和優化Agoda面向客戶、合作夥伴和內部應用程式的使用者體驗至關重要。

FE Analytics 提供了一系列廣泛的功能，以滿足Agoda不同專業需求：

* 開發人員和品質保證（QA）：在生產中進行調試和監控用戶互動，並識別問題或趨勢方面發揮了關鍵作用。
* 產品擁有者：基於新添加的功能計算用戶互動趨勢的變化，並證明/否定提升用戶體驗的假設方面發揮了作用。
* 分析師：檢查用戶互動中的模式，提供有關不同假設的報告和儀表板方面發揮了作用。
* 機器學習：檢測詐騙用戶並根據先前的互動個性化搜索結果方面發揮了作用。


就隱私擔憂而言，我們確保在這個數據集中不會記錄任何可識別個人信息（PII）。
數據嚴格僅包含與領域相關的基於互動的上下文，而不是用戶，以符合全球隱私標準，同時保護用戶數據並提供有價值的見解。

![image](https://hackmd.io/_uploads/H1KDVap4p.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f

目前，開發人員必須手動將每個事件添加到這個表中，這在保持一致的高質量數據方面存在挑戰。由於有眾多開發人員參與，對最佳實踐的不同解釋，以及可能存在人為錯誤的可能性，確保數據質量具有挑戰性。

本文突顯了我們努力提高數據質量並實施檢查和平衡措施以識別和解決問題的努力。

# Understanding Data Quality

對於依賴數據做出決策的企業而言，確保數據的準確性和適用性至關重要。

忽視這一點可能導致重大後果，例如：

* 可能導致收入損失的誤導性決策。
* 錯失的機會。
* 對所有參與者而言的時間和精力浪費。

![image](https://hackmd.io/_uploads/By6y8T6Ep.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f

如何衡量所生成數據的質量？我們已經提出了以下需要牢記的因素，特別是針對 FE Analytics，但這些原則應該適用於任何一般數據集。

![image](https://hackmd.io/_uploads/HJ8VYTpVa.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f

# The Frontend Data Team


在Agoda，有一個專門的團隊致力於構建和維護圍繞用戶互動事件的框架。
這個團隊由Web和移動應用程式開發人員組成，專注於在源頭最大程度地提高數據質量。
他們的任務是建立流程，確保更好的數據質量，有時這可能會影響開發人員的體驗和交付時間。

![image](https://hackmd.io/_uploads/BJgpiT6V6.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f

以下是這個團隊針對提升數據質量所提出的概述。

# FE Analytics Framework

FE分析框架的開發始於對現有系統的全面審查。

# Building blocks

一個事件通常包含兩個部分:

* 發生事件：用戶在特定應用程序的頁面上與元素進行互動。
* 內容：該事件周圍狀況的各種狀態。

![image](https://hackmd.io/_uploads/By32h664p.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f

# The rocky development process

先前對於發送這些數據是沒有控制的。以下是跟蹤一個硬編碼事件而沒有任何控制的過程。

![image](https://hackmd.io/_uploads/SyTgpaTNT.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f


基於產品擁有者的需求，開發人員將事件硬編碼，推出了該功能，然後等待了幾天以收集足夠的數據進行分析。

在這一點上，如果幸運的話，他們可能有了良好的數據，或者發現了需要在分析中修復的問題，這將導致進一步的延遲。
這導致了精力的浪費和延遲的結果，本來可以幫助評估KPI的實現。如果不幸的話，他們可能會做出不受支持的決策，可能影響功能的採用。

隨著時間的推移，這個框架已經進化以應對這些問題，現在提供了一個早期警報系統，用於確定分析是否值得信賴。


# Classifying the Issues

為了增強我們FE Analytics的效能，我們將各種團隊遇到的挑戰分類為需要解決的特定類型的問題。
這些問題可以與事件本身的構建塊相關聯。

## Bad events

* 誤導性事件 — 不正確的操作類型、頁面或應用程式名稱
* 實施問題 — 事件重複、事件遺漏。

## Bad context

* 誤導性上下文 — 上下文的值錯誤或難以分析。
* 缺失上下文 — 需要的值遺失。


除此之外，我們還存在一個問題，那就是可靠地確定哪個團隊擁有特定的事件。
我們還需要控制數據，確保人們僅發送純粹的用戶互動，而不將數據混合用於其他目的（如加載時間和內部狀態）。
![image](https://hackmd.io/_uploads/HkJzATpE6.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f

# Defining Events

開發人員首先需要在一個集中的儲存庫中定義一個事件。由於表的扁平結構包含1500多個列，其中在任何給定事件中大多數列都將是空的，我們需要確保特定元素、頁面或應用程式的必需字段是存在的。

因此，這個集中式儲存庫提供了一個用於定義事件的API，看起來如下所示。

![image](https://hackmd.io/_uploads/HyKV1RT4p.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f

在定義被創建之後，由我們擁有這個集中式 C# 儲存庫的團隊進行 MR（Merge Request）審查，並對事件的設計質量發表評論。我們確保人們發送必要的事件和上下文，檢查命名以及其他質量準則。

這也成為預期事件的真實來源，從中我們可以:

* 目錄事件
* 標記事件的擁有權
* 生成封裝事件標識和上下文的類型化對象
* 生成用於捕捉回歸的驗證規則。

一旦一切都得到批准，MR（Merge Request）就會被合併。從這一點開始，代碼被生成並作為事件類型的庫的一部分進行部署。

# Implementing Events Using the FE Analytics Library

這個庫基本上提供了一種改進的開發人員體驗，同時確保追踪的事件是前一狀態定義中生成的代碼對象。

在這裡，我們在UI框架的頂部提供了觀察者，以直觀地在UI本身上直接追踪正確的操作。對於事件觀察，我們目前提供API支持

* HTML DOM Observers for web applications
* SwiftUI for iOS
* Jetpack Compose for Android

除此之外，我們還允許開發人員從應用程序的邏輯層手動追踪事件，盡管我們強烈建議他們盡可能使用觀察者。

通過使用為事件生成的類型與觀察者，我們確保他們在預期的上下文中追踪元素上的正確操作。

除了提供新的API之外，還需要更多，因為許多事件是使用舊的實現發送的。我們還需要開發人員將事件遷移到新系統，主要是為了進行目錄化和標記擁有權。這可能是一個挑戰，我們還投入了更多的努力來實現更簡便的代碼遷移，正如我的同事在文章[《應對舊代碼：我們如何通過元編程在Agoda加速代碼遷移》](https://medium.com/agoda-engineering/tackling-legacy-code-how-we-accelerate-code-migration-at-agoda-with-metaprogramming-ead43f4ffe4a)中所描述的。

# Testing the Events

測試分析數據是有爭議的，因為編寫測試對於像追踪事件這樣的“簡單”事物被認為很昂貴，往往容易被忽視。為了幫助簡化這個過程，我們的團隊提供了一套與觀察/追踪API綁定的測試工具，以減少撰寫測試所需的步驟。

我們最少期望開發人員能夠手動測試事件，以確保基本合理性。
然而，這也是一個具有挑戰性的經歷，因為人們必須查看網絡層，基本上是在冗長的請求主體中尋找他們的事件，猶如在一堆中尋找針芥。

最終，儘管已經編寫了測試並通過手動檢查確保事件正確，但在生產環境中仍然有可能發生一些問題。假設根據用例場景（國家、貨幣、屬性等）考慮上下文的所有可能值，那麼上下文的可能組合使得幾乎不可能確保不發生任何回歸。

因此，我們設計了一個系統，利用基於定義生成的規則在prelive和production環境中驗證事件，並根據所涵蓋的情景提供最大的反饋。

# Providing Pre and Post-Production Feedback

我們的驗證系統基於實現JSON Schema規範。
我們從定義中生成一個JSON Schema“規則”，然後與兩個系統同步，以不同的方式提供反饋。

* 來自分析伺服器的實時反饋：這僅發生在pre-live應用程序中，可在開發或pre-live測試期間使用。
* 生產後監控：我們無法實時驗證所有事件，因為參與的規模和計算量太大。因此，該系統驗證在生產中接收的一部分事件，並將其記錄下來，我們的報告讀取並將這些問題轉換為直接在擁有事件的團隊的問題追踪看板上提出的錯誤。

![image](https://hackmd.io/_uploads/BkFWBATVa.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f

最終，這個設置使得分析開發週期在產品擁有者分析數據之前，具有更多檢查點，以提供反饋，並意識到分析存在問題。

![image](https://hackmd.io/_uploads/ry5VS0aVp.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f

# Improving the Debugging Experience

即使這些反饋機制已經就位，我們的開發人員在使用實時反饋機制時仍然需要協助。
這是相當冗長的，需要一些努力來準確找出他們分析中的問題。

為了使這個過程更加直觀，我們提供了一個開發人員工具，作為一個名為 Mimir 的Chrome擴展的一部分。
該工具幫助用戶可視化和調試從應用程序發送出去的分析。
它逐一顯示應用程序發送的分析，如果從伺服器接收到任何驗證反饋，則將其突顯顯示。它不僅連接到瀏覽器中運行的當前Web會話，而且我們還允許其他非Web應用程序通過使用QR碼進行遠程連接，將分析顯示在這個調試器上。

![image](https://hackmd.io/_uploads/Bk_0HRp4T.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f

![image](https://hackmd.io/_uploads/Hku1806Ea.png)
>圖片來源: https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f

有了這一點，我們將體驗提升到一個難以爭辯的地步，即由於任何困難，不進行手動測試分析是困難的。

Mimir Chrome擴展對Agoda的內部用戶提供的不僅僅是調試分析的功能，這是另一篇文章的主題。

# Conclusion

在Agoda，FE Analytics對於收集和分析用戶互動數據至關重要，這對於提升用戶體驗至關重要。
由於這個系統的每個事件都需要由開發人員實現，存在錯誤和不一致性的可能性很高，最終可能導致錯誤的決策，以及時間和收入的損失。為了確保數據質量並減少任何可能的問題，FE數據團隊維護了一個系統和流程，使開發人員能夠定義、實現和測試他們的事件，在開發過程中獲得早期反饋，並通過觀察生產中的事件提前發出警告。

這個流程仍然有很大的改進空間，我們正在努力設計更好的API和保護措施，以在分析問題進入生產之前預防它們。

# 文章來源:https://medium.com/agoda-engineering/refining-front-end-analytics-quality-strategies-and-tools-for-developers-at-agoda-f0bb8778578f