---
title: 學習 Headless UI：打造靈活的前端設計
date: 2025-01-08 11:13:58
tags:
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

## 什麼是 Headless UI？  


![image](https://hackmd.io/_uploads/BJRyTDsL1x.png)
>https://github.com/tailwindlabs/headlessui

在前端開發中，**Headless UI** 是一種專注於功能而非外觀的 UI 元件庫。它提供了基礎的交互邏輯與功能，但不附帶預設樣式，開發者可以完全自由地設計視覺呈現，讓應用程式能夠更靈活地滿足不同的設計需求。  


## 為什麼選擇 Headless UI？  

1. **完全的樣式自由**  
   Headless UI 不會強制使用任何特定的樣式表，開發者可以用自己的 CSS 或框架（如 Tailwind CSS、SCSS）來控制外觀。  

2. **專注於功能**  
   它提供了預建的功能邏輯，例如無障礙支援（Accessibility）和狀態管理，開發者可以減少處理細節的時間，專注於業務邏輯與設計。  

3. **框架無關**  
   雖然 Headless UI 目前主要支援 React 和 Vue，但它的概念適用於任何框架甚至原生 JavaScript。  

---

## 常見功能與範例  

### 1. 無樣式的彈出式選單（Dropdown Menu）  

**範例使用 Tailwind CSS 與 React:**  
```jsx
import { Menu } from '@headlessui/react';

function Dropdown() {
  return (
    <Menu>
      <Menu.Button className="bg-blue-500 text-white px-4 py-2 rounded">選單</Menu.Button>
      <Menu.Items className="absolute bg-white border mt-2 rounded shadow-md">
        <Menu.Item>
          {({ active }) => (
            <a
              className={`block px-4 py-2 ${active ? 'bg-blue-100' : ''}`}
              href="/profile"
            >
              個人資料
            </a>
          )}
        </Menu.Item>
        <Menu.Item>
          {({ active }) => (
            <a
              className={`block px-4 py-2 ${active ? 'bg-blue-100' : ''}`}
              href="/settings"
            >
              設定
            </a>
          )}
        </Menu.Item>
      </Menu.Items>
    </Menu>
  );
}
export default Dropdown;
```

### 2. 無樣式的對話框（Dialog）  

Headless UI 內建了彈性對話框元件，適用於模態視窗：  

```jsx
import { Dialog } from '@headlessui/react';
import { useState } from 'react';

function Modal() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <>
      <button onClick={() => setIsOpen(true)} className="bg-green-500 text-white px-4 py-2 rounded">開啟對話框</button>
      <Dialog open={isOpen} onClose={() => setIsOpen(false)} className="fixed inset-0 z-10">
        <div className="fixed inset-0 bg-black opacity-30" aria-hidden="true" />
        <div className="relative p-6 bg-white max-w-sm mx-auto mt-20 rounded">
          <Dialog.Title className="text-lg font-bold">對話框標題</Dialog.Title>
          <Dialog.Description>這是對話框的內容描述。</Dialog.Description>
          <button onClick={() => setIsOpen(false)} className="mt-4 bg-red-500 text-white px-4 py-2 rounded">關閉</button>
        </div>
      </Dialog>
    </>
  );
}
export default Modal;
```

---

## Headless UI 的優點  

- **無縫整合 CSS 框架：** 與 Tailwind CSS 搭配時，能輕鬆建立自訂的外觀設計。  
- **無障礙支援：** 預設支援 ARIA 屬性，符合 WCAG 標準。  
- **提升開發效率：** 開發者不需從零實作交互邏輯。  

---

## 使用建議  

1. **結合設計系統：** 將 Headless UI 元件作為基礎，打造符合團隊需求的設計系統。  
2. **熟悉無障礙規範：** 善用 Headless UI 提供的無障礙功能，提升應用程式的易用性。  
3. **配合框架生態系：** 選擇適合的樣式工具（如 Tailwind CSS）能大幅減少樣式設計的重工。  
