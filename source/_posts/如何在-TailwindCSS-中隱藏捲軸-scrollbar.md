---
title: 如何在 TailwindCSS 中隱藏捲軸 - scrollbar
date: 2024-12-24 09:56:08
tags:
    - tailwindcss
categories:
keywords:
description:
top_img:
comments:
cover:
toc:
toc_number:
copyright:
mathjax:
katex:
hide:
---

# 如何在 TailwindCSS 中隱藏捲軸 - scrollbar
## 你不想讓你的 UI 看起來像這樣嗎？

**在隱藏捲軸前：**

![image](https://hackmd.io/_uploads/Bkh29KPSJe.png)

本篇將教你 **如何使用 TailwindCSS 隱藏 HTML 元素的捲軸**，只需兩個簡單步驟即可完成！

---

## 步驟一：新增自定義樣式

首先，打開你的專案中的 `global.css`（或 `styles/global.css`），並新增以下樣式代碼：  

```css
/* global.css */
@tailwind base;
@tailwind components;
@tailwind utilities;

/* 新增以下代碼 */
@layer utilities {
  /* 隱藏 Chrome、Safari 和 Opera 的捲軸 */
  .no-scrollbar::-webkit-scrollbar {
    display: none;
  }

  /* 隱藏 IE、Edge 和 Firefox 的捲軸 */
  .no-scrollbar {
    -ms-overflow-style: none; /* IE 和 Edge */
    scrollbar-width: none;    /* Firefox */
  }
}
```

### 解釋：
1. **`::-webkit-scrollbar`**：針對 Chrome、Safari 和 Opera 定義捲軸樣式。
2. **`.no-scrollbar`**：提供給其他瀏覽器（如 IE、Edge 和 Firefox）使用。

至此，已新增名為 `no-scrollbar` 的自定義 TailwindCSS 工具類別。

---

## 步驟二：在 HTML 元素中使用 `no-scrollbar`

接下來，將 `no-scrollbar` 類別添加到需要隱藏捲軸的元素上。例如：

```html
<div class="w-full overflow-y-scroll no-scrollbar">
  <!-- 你的內容 -->
</div>
```

## 注意：
- `overflow-y-scroll`：仍然允許內容滾動，但隱藏捲軸。
- 如果需要針對水平捲軸，也可以使用 `overflow-x-scroll`。

---

## 總結

透過以上兩個步驟，我們成功在 **TailwindCSS** 中隱藏捲軸，讓介面看起來更整潔。同時保持了捲動的功能，這對於需要隱藏視覺元素但保留互動性的設計非常有幫助。

希望這篇教學能幫助到你！🎉
