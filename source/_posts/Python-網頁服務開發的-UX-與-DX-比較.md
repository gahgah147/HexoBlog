---
title: Python 網頁服務開發的 UX 與 DX 比較
date: 2023-11-27 10:27:09
tags:
  - Agoda Engineering 部落格
  - Python
  - UX
  - DX
---

這篇文章是我在 Agoda Engineering 部落格的文章閱讀紀錄
[UX vs. DX in Python Web Servers](https://medium.com/agoda-engineering/ux-vs-dx-in-python-web-servers-3e3d9db864b1)

# UX vs. DX in Python Web Servers

Agoda在11月舉辦了一場與曼谷Python社群合作的ThaiPy聚會。
演講者是Agoda的高級軟體工程師Mohamad Kamar，他分享了有關“Python Web伺服器中的UX vs DX”的演講。
他深入探討了Python在Web伺服器架構方面的多樣性，從簡單的同步伺服器到複雜的異步和基於框架的伺服器。
這篇博客文章總結了演講中討論的要點。

# 什麼是 UX and DX ?

使用者體驗（UX）指的是使用者與網路應用程式互動的整體體驗。
這包括速度、可用性、可存取性以及整體使用者滿意度等考慮因素。

開發者體驗（DX）代表開發者在建構、維護和擴展網路應用程式時的經驗。
易於設置、程式碼可維護性和除錯能力等因素在這裡扮演重要的角色。

當專注於改善開發者體驗（DX）或使用者體驗（UX）時，通常會為另一方帶來間接的好處。
例如，對功能開發速度的關注能夠提供更簡化的結果給最終使用者體驗，同時降低錯誤出現的機率，從而幫助開發者。

# 探索 Python 功能

Python的多用途性彰顯在其處理各種網頁伺服器架構的能力上，從處理一次請求的簡單同步伺服器到更複雜的異步和基於框架的伺服器，Python提供了廣泛的選擇。

每種方法對使用者體驗（UX）和開發者體驗（DX）都有其獨特的影響。

![image](https://hackmd.io/_uploads/BkFj2wWBT.png)
> 圖片來源: https://medium.com/agoda-engineering/ux-vs-dx-in-python-web-servers-3e3d9db864b1

[XKCD Python Fly Library import](https://xkcd.com/353/)

# 如何衡量網頁伺服器程式碼的開發者體驗

評估開發者體驗（DX）涉及探索多個方面。
儘管我的分析具有主觀性，但旨在提供在Python網頁伺服器開發中DX景觀的清晰概述：

以下是這些具體區域的分解：


1. 安裝的便利性：啟動伺服器有多輕鬆？這包括文件的品質、入門模板的可用性、所需的依賴項數量以及在設置過程中錯誤消息的清晰度等方面。
1. 代碼可讀性：這是開發者能夠輕鬆導覽和理解代碼庫的程度。這包括命名慣例、代碼組織、註釋的使用，以及是否遵守Python的風格指南（PEP 8）等因素。
1. 可維護性：此組件評估測試、擴展、更新、修復和增強代碼的簡單程度。可維護性受可移植性的影響（代碼是否可以在不進行重大重構的情況下移動或適應不同的環境或框架）、模塊化和是否遵循最佳實踐等。
1. 調試設施：這涉及評估網頁伺服器提供的工具和功能，以幫助識別和解決代碼問題。這包括本地調試工具、記錄設施、錯誤消息以及與外部調試工具集成的便利性。 


以這些為我們分析DX的基礎，我們可以比較不同方式構建Python網頁伺服器在相互之間的表現。

http.server：作為標準Python庫的一部分，http.server的設置是簡單明瞭的，但它僅提供基本功能，對於複雜應用程式的可維護性產生影響。調試和測試能力很大程度上取決於您使用的其他Python庫。

值得注意的是，http.server模組本身的文檔頁面建議開發者不要使用這些庫來構建生產應用程式，因為它缺乏安全功能。

![image](https://hackmd.io/_uploads/S1E9x_ZSa.png)
> 圖片來源: https://medium.com/agoda-engineering/ux-vs-dx-in-python-web-servers-3e3d9db864b1

aiohttp：由於它的異步性質，這使得設置比http.server更為複雜。
然而，使用Python的asyncio可以實現更有效的I/O操作，對於I/O密集型應用程式，這對可維護性產生積極影響。aiohttp的文檔提供了調試的線索，但測試異步代碼可能會更具挑戰性，需要使用Python的asyncio測試工具。

此外，aiohttp是一個非常輕量的庫，功能沒有這個列表上的其他庫多，通常被用作創建網頁伺服器的補充庫，而不是主要的構建塊。根據JetBrains進行的開發者調查：

>"大多數框架的受歡迎程度在年復年之間保持穩定。唯一的例外是提供異步程式設計支援的庫。asyncio庫在2022年達到歷史最高水平（21%），aiohttp顯示了輕微的增加，而httpx首次在調查中亮相，被9%的受訪者選擇。"

![image](https://hackmd.io/_uploads/BJq7bd-BT.png)
> 圖片來源: https://medium.com/agoda-engineering/ux-vs-dx-in-python-web-servers-3e3d9db864b1

[Python Developer Survey](https://www.jetbrains.com/lp/devecosystem-2022/python/)

* FastAPI：FastAPI因其快速且簡便的設置而受到讚譽，這要歸功於巧妙使用Python型別提示。FastAPI促進可維護的代碼，並包含用於調試和測試支援的內建文檔。

* Flask：以其極簡的方式，Flask提供了簡單的設置和靈活的環境。它為開發者提供了一系列選擇，儘管它缺乏內置的調試工具，但可以透過擴展（如Flask-Debug Toolbar）獲取這些功能。

* Django：以其“一切皆備”的理念而聞名，很多東西在安裝時就已經設置好了，這使得Django對新用戶來說可能有點壓倒性。但一旦配置完成，Django的高度模塊化和可重用的代碼可以使維護變得更加可管理。它配備了一個強大的ORM和管理面板，這可以協助調試，並且還有一個內置的測試框架。

FastAPI、Django和Flask目前是市場上使用最多的框架，其次是Tornado和一些較不知名的庫。對即將到來的部分進行一點預告，前5名最常用的Python庫中沒有一個在最高性能評分中得分。

![image](https://hackmd.io/_uploads/ryQDf_bST.png)
> 圖片來源: https://medium.com/agoda-engineering/ux-vs-dx-in-python-web-servers-3e3d9db864b1

[Python Developer Survey](https://www.jetbrains.com/lp/devecosystem-2022/python/)

# Developer Preference

開發者的偏好是由個人經驗和項目需求所塑造的。
隨著時間的推移，他們自然而然地傾向於他們熟悉的技術。
這種熟悉感提升了他們的舒適度和效率。
例如，一位精通Django的開發者可能會在網頁伺服器任務中偏好使用它，熟悉其功能、社區和文檔。

項目需求在很大程度上影響開發者在網頁伺服器和框架中的選擇。項目的性質和範圍決定了最佳選擇。
開發者可能會傾向於使用Flask來創建一個輕量級、小規模的應用程式，而對於功能較為豐富、複雜的項目，可能會選擇Django或Pyramid。
像伺服器負載、實時更新以及對強大文檔和社區支援的需求等因素也可能影響這些決策。

# Performance Considerations
性能是選擇網頁伺服器的一個關鍵因素。
在比較網頁庫的性能時，考慮到WSGI和ASGI標準是很重要的。
像aiohttp和FastAPI這樣的異步庫是為ASGI環境（例如uvicorn）設計的，而Django和Flask則默認使用WSGI設置（例如gunicorn），可能需要額外的努力進行其他部署。

# Striking a Balance: UX and DX Optimization

平衡使用者體驗（UX）和開發者體驗（DX）更像是一門藝術而非科學。這是關於為正確的任務選擇合適的工具。每個框架的實用性在很大程度上取決於你的具體用例。如果你的項目規模相對較小，使用像Django這樣的重量級框架可能會顯得過於臃腫。相反，像Flask或FastAPI這樣的極簡選擇可能更合適。

對於需要廣泛內建功能且使用一個有主觀意見的框架不是問題的更大、更複雜的項目，Django可能是一個更合適的選擇。如果你喜歡極簡的方法並且喜歡從頭開始建立一切的過程，考慮使用aiohttp。

# Conclusion

選擇合適的Python網頁伺服器框架需要在使用者體驗（UX）和開發者體驗（DX）之間取得平衡。
每個框架都提供獨特的功能，適用於不同的項目需求。
了解這些差異並將其與項目需求相一致是實現最佳網頁伺服器選擇的關鍵。

# References
[Django vs. Flask comparison](https://medium.com/@tj.joyson/an-another-django-vs-flask-comparison-which-one-is-better-236a163c18c6)
[Python developer survey](https://www.jetbrains.com/lp/devecosystem-2022/python/)


# 文章來源 :https://medium.com/agoda-engineering/ux-vs-dx-in-python-web-servers-3e3d9db864b1

