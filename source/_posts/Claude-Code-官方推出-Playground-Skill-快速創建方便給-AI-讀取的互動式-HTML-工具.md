---
title: Claude Code 官方推出 Playground Skill 快速創建方便給 AI 讀取的互動式 HTML 工具
date: 2026-02-02 12:01:46
tags:
    - Skill
    - Claude Code
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

![image](https://hackmd.io/_uploads/S1vJzi6LZl.png)

> 官方文檔：https://skills.sh/anthropics/claude-plugins-official/playground

---

## 什麼是 Playground Skill？ 

### 核心概念

Playground Skill 是 Anthropic 官方推出的 Claude Code 插件，它能幫助你快速創建**互動式 HTML 工具**。每個 Playground 都是一個自包含的 HTML 檔案，包含三大核心元素：

```
┌─────────────────────────────────────────────┐
│  📊 左側：互動控制面板                        │
│  調整參數、切換選項                           │
├─────────────────────────────────────────────┤
│  👁️ 中間：即時預覽區域                        │
│  視覺化顯示當前設定的效果                      │
├─────────────────────────────────────────────┤
│  📝 底部：智能提示詞輸出                       │
│  自動生成可複製的自然語言指令                  │
│  [Copy] 按鈕                                 │
└─────────────────────────────────────────────┘
```

### 工作流程

```
你調整控制面板 → 預覽即時更新 → 系統生成提示詞 → 複製提示詞 → 貼回 Claude → 執行任務
```

### 為什麼需要它？

**傳統方式的痛點：**
- ❌ 純文字描述難以精確表達視覺設計
- ❌ 需要反覆來回調整參數
- ❌ 容易產生理解誤差

**Playground 的優勢：**
- ✅ 視覺化探索所有選項組合
- ✅ 即時看到每個調整的效果
- ✅ 自動生成精確的自然語言指令
- ✅ 無縫整合回 Claude Code 工作流

---

## 快速開始：安裝與設定 

### 三步驟安裝

```bash
# Step 1: 添加官方 Marketplace
/plugin marketplace add anthropics/claude-plugins-official

# Step 2: 安裝 Playground Plugin
/plugin install playground@claude-plugins-official

# Step 3: 重啟 Claude Code
exit
claude code
```

### 驗證安裝

安裝完成後，試試這個指令：

```
請建立一個設計 playground，讓我可以調整按鈕的圓角和顏色
```

如果 Claude 開始創建 HTML 檔案，就表示安裝成功！

---

## 核心概念與設計原則 

### 使用流程

**1. 用關鍵字觸發**

包含這些關鍵字的請求會自動觸發 Playground：
- 「互動工具」、「playground」
- 「視覺化探索」、「調整設計」
- 「架構圖」、「關係圖」

**2. Claude 自動處理**

Claude 會：
- 識別最適合的模板類型
- 載入對應模板
- 生成自定義 HTML 檔案
- 自動在瀏覽器開啟

**3. 互動探索**

- 🎛️ 調整控制面板參數
- 👀 觀察預覽即時更新
- 📋 查看生成的提示詞
- 🔘 點擊 Copy 按鈕

**4. 應用結果**

將提示詞貼回 Claude Code，繼續你的工作流程。

### 七大設計原則

每個優質的 Playground 都應該遵循：

#### 1. 📦 單一 HTML 檔案

```html
<!-- ✅ 正確：所有資源內嵌 -->
<style>/* CSS 寫在這裡 */</style>
<script>// JS 寫在這裡 </script>

<!-- ❌ 錯誤：依賴外部資源 -->
<link rel="stylesheet" href="external.css">
```

**原因**：確保離線可用、無依賴問題。

#### 2. ⚡ 即時預覽

```javascript
// ✅ 正確：input 事件立即觸發
input.addEventListener('input', () => updateAll());

// ❌ 錯誤：需要點擊按鈕才更新
button.addEventListener('click', () => updateAll());
```

**原因**：即時反饋讓探索更流暢。

#### 3. 📝 自然語言輸出

```javascript
// ✅ 正確：像人類的描述
"創建一個按鈕，使用 12px 圓角、藍色背景、柔和陰影"

// ❌ 錯誤：純數據列表
"borderRadius: 12, color: #3b82f6, shadow: 8"
```

**原因**：Claude 需要自然語言才能正確理解。

#### 4. 📋 一鍵複製

```javascript
copyBtn.addEventListener('click', async () => {
  await navigator.clipboard.writeText(prompt);
  copyBtn.textContent = '✓ Copied!';
  setTimeout(() => copyBtn.textContent = 'Copy', 2000);
});
```

#### 5. 🎯 合理的預設值

```javascript
const DEFAULTS = {
  borderRadius: 8,
  padding: 16,
  color: '#3b82f6'
};

const PRESETS = {
  minimal: { borderRadius: 4, shadow: 0 },
  bold: { borderRadius: 16, shadow: 20 }
};
```

**原因**：載入時就能看到好看的效果。

#### 6. 🌑 深色主題

```css
body {
  background: #1a1a1a;
  color: #e0e0e0;
  font-family: system-ui, sans-serif;
}
```

#### 7. 🔄 集中式狀態管理

```javascript
const state = { /* 所有配置 */ };

function updateAll() {
  renderPreview();  // 更新視覺
  updatePrompt();   // 重建提示詞
}
```

---

## 六種模板完整介紹 

### 模板總覽

| 模板 | 適用場景 | 觸發關鍵字 |
|------|---------|-----------|
| 🎨 Design Playground | UI 組件設計 | 設計工具、樣式調整 |
| 🗺️ Code Map | 專案架構視覺化 | 架構圖、組件關係 |
| 📊 Data Explorer | 數據查詢建構 | SQL、API、查詢建構 |
| 🧭 Concept Map | 知識結構展示 | 概念地圖、學習路徑 |
| 📄 Document Critique | 文件審查 | 文件審查、評論工具 |
| 🔍 Diff Review | 程式碼審查 | code review、diff 檢視 |

### 1. 🎨 Design Playground

**功能**：
- 組件樣式調整（按鈕、卡片、表單）
- 布局配置（間距、對齊、排列）
- 顏色系統（主題色、背景、文字）
- 字體設定（大小、粗細、行高）

**使用案例**：
```
請建立一個設計 playground，讓我可以調整卡片組件的圓角、陰影和間距
```

**適合誰**：UI/UX 設計師、前端工程師、產品經理

### 2. 🗺️ Code Map

**功能**：
- 組件關係圖
- 資料流向視覺化
- 系統分層結構
- 依賴關係展示

**使用案例**：
```
請用 playground 為這個專案建立互動式架構圖
```

**適合誰**：技術 Lead、架構師、新團隊成員

### 3. 📊 Data Explorer

**功能**：
- SQL 查詢建構器
- API 端點測試
- 資料管道視覺化
- 正則表達式測試器

**使用案例**：
```
幫我建立一個 SQL 查詢的互動工具，可以視覺化選擇表格和欄位
```

**適合誰**：數據分析師、後端工程師

### 4. 🧭 Concept Map

**功能**：
- 概念關係圖
- 知識結構展示
- 學習路徑規劃
- 範圍映射

**使用案例**：
```
建立一個概念地圖，幫我理解這個技術的核心概念和它們之間的關係
```

**適合誰**：學習者、技術寫作者、教育者

### 5. 📄 Document Critique

**功能**：
- 段落級別評論
- 建議批准/拒絕流程
- 改進建議追蹤
- 版本對比

**使用案例**：
```
創建一個文件審查工具，讓我可以對每個章節添加評論
```

**適合誰**：技術寫作者、文檔管理員

### 6. 🔍 Diff Review

**功能**：
- Git diff 視覺化
- 逐行評論
- 提交歷史檢視
- Pull Request 審查

**使用案例**：
```
建立一個 code review playground，幫我審查 Git diff
```

**適合誰**：開發團隊、Code Reviewer

---

## 深度實戰：Design Playground 

### 完整案例：設計現代按鈕組件

#### Phase 1：提出需求

```
請建立一個 Design Playground，幫我設計現代化的按鈕組件。

需要調整：
- 圓角大小
- 顏色（Primary、Secondary、Danger）
- 尺寸（Small、Medium、Large）
- 陰影效果
- Hover 狀態
```

#### Phase 2：生成的介面結構

**控制面板**：
```
基本樣式
├── 圓角 [0-24px] ━━━━━●━━━━━
├── 顏色方案
│   ├── ● Primary (藍色)
│   ├── ○ Secondary (灰色)
│   └── ○ Danger (紅色)
└── 尺寸
    ├── ○ Small
    ├── ● Medium
    └── ○ Large

進階設定 ▼
├── 陰影強度 [0-20px] ━━━●━━━━━
├── 邊框寬度 [0-4px] ━●━━━━━━━
└── 內邊距 [8-32px] ━━━━●━━━━

預設組合
├── [極簡風格] [標準樣式] [大膽設計]
```

**預覽區域**：
```
┌──────────────────────┐
│                      │
│   [  Click Me  ]     │ ← 正常狀態
│                      │
│   [  Click Me  ]     │ ← Hover 狀態（變亮）
│                      │
│   [  Click Me  ]     │ ← Active 狀態（按下）
│                      │
└──────────────────────┘
```

**提示詞輸出**：
```
創建一個按鈕組件，使用 12px 圓角、藍色背景（#3b82f6）、
中等尺寸（padding: 12px 24px）、柔和陰影（0 4px 8px rgba(0,0,0,0.1)）。
Hover 時背景變為 #2563eb，陰影增強至 0 6px 12px。

[Copy] 按鈕
```

#### Phase 3：操作步驟演示

**步驟 1：調整圓角**
- 移動滑桿至 12px
- ✅ 預覽按鈕圓角立即更新
- ✅ 提示詞加入「12px 圓角」

**步驟 2：選擇顏色**
- 點擊 Primary 單選按鈕
- ✅ 按鈕變藍色
- ✅ 提示詞更新「藍色背景（#3b82f6）」

**步驟 3：調整陰影**
- 陰影滑桿設為 8
- ✅ 預覽顯示柔和陰影
- ✅ 提示詞描述「柔和陰影效果」

**步驟 4：測試預設組合**
- 點擊「大膽設計」
- ✅ 所有參數自動調整：圓角 16px、陰影 20px
- ✅ 提示詞完整更新

**步驟 5：複製並應用**
- 點擊 Copy
- 貼回 Claude Code
- ✅ Claude 生成完整 React/Vue 組件程式碼

#### Phase 4：生成的程式碼範例

```typescript
// Button.tsx
import React from 'react';
import './Button.css';

interface ButtonProps {
  children: React.ReactNode;
  onClick?: () => void;
  variant?: 'primary' | 'secondary' | 'danger';
  size?: 'small' | 'medium' | 'large';
}

export const Button: React.FC<ButtonProps> = ({ 
  children, 
  onClick,
  variant = 'primary',
  size = 'medium' 
}) => {
  return (
    <button 
      className={`btn btn-${variant} btn-${size}`}
      onClick={onClick}
    >
      {children}
    </button>
  );
};
```

```css
/* Button.css */
.btn {
  border-radius: 12px;
  border: none;
  cursor: pointer;
  font-weight: 500;
  transition: all 0.2s ease;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.btn-primary {
  background: #3b82f6;
  color: white;
}

.btn-primary:hover {
  background: #2563eb;
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
  transform: translateY(-1px);
}

.btn-medium {
  padding: 12px 24px;
  font-size: 16px;
}
```

### 實戰案例 2：電商產品卡片

#### 需求定義

```
請建立 Design Playground，設計電商產品卡片：
- 卡片圓角、陰影層次
- 內部間距、圖片高度
- 字體大小（標題、價格、描述）
- 主題切換（日間/夜間模式）
```

#### 預設方案對比

| 方案 | 圓角 | 陰影 | 內邊距 | 風格 |
|------|------|------|--------|------|
| 極簡電商 | 8px | 柔和 | 16px | 簡潔易讀 |
| 豪華精品 | 4px | 明顯 | 24px | 高端精緻 |
| 現代時尚 | 16px | 中等 | 20px | 潮流年輕 |

#### 生成的提示詞

```
創建產品卡片組件，採用現代時尚風格：
- 16px 圓角營造柔和感
- 卡片 320px 寬，圖片 240px 高
- 內邊距 20px，元素間距 12px
- 柔和陰影（0 8px 16px rgba(0,0,0,0.08)）
- 標題 20px 粗體，價格 24px 醒目
- Hover 時卡片上浮 2px，陰影增強
- 底部按鈕使用品牌主色 #3b82f6
```

---

## 深度實戰：Code Map 

### 完整案例：React 電商專案架構

#### Phase 1：提供專案上下文

```
這是我的 React 電商專案：

src/
├── components/
│   ├── ProductCard.tsx
│   ├── ShoppingCart.tsx
│   └── Checkout.tsx
├── pages/
│   ├── HomePage.tsx
│   ├── ProductPage.tsx
│   └── CartPage.tsx
├── services/
│   ├── api.ts
│   └── auth.ts
├── store/
│   ├── cartSlice.ts
│   └── userSlice.ts
└── App.tsx

請用 playground 建立互動式架構圖，
顯示各層關係和資料流向。
```

#### Phase 2：生成的介面

**控制面板**：
```
顯示層級
├── ☑ Pages (頁面層)
├── ☑ Components (組件層)
├── ☑ Services (服務層)
└── ☑ Store (狀態層)

顯示關係
├── ☑ 組件依賴
├── ☑ 資料流向
├── ☑ API 呼叫
└── ☐ Props 傳遞（細節）

視圖模式
├── ● 分層視圖
├── ○ 依賴關係圖
└── ○ 資料流視圖

搜尋功能
└── [搜尋組件...] 🔍
```

**預覽區域**：
```
┌──────────────────────────────────────────┐
│                 App.tsx                   │
│                    │                      │
│     ┌──────────────┼──────────────┐      │
│     │              │              │      │
│  HomePage    ProductPage    CartPage     │
│     │              │              │      │
│     │        ┌─────┴─────┐       │      │
│     │        │           │        │      │
│ ProductCard ProductCard ShoppingCart     │
│     │        │           │        │      │
│     └────────┴───────────┴────────┘      │
│              │           │                │
│          api.ts     cartSlice.ts          │
│                                           │
│  ■ Pages  ■ Components  ■ Services       │
└──────────────────────────────────────────┘
```

#### Phase 3：互動功能演示

**功能 1：點擊組件查看詳情**

點擊 `ProductCard`：
```
╔════════════════════════════════╗
║ ProductCard.tsx                ║
╠════════════════════════════════╣
║ 使用於：                       ║
║  • HomePage                    ║
║  • ProductPage                 ║
║                                ║
║ 依賴：                         ║
║  • api.ts (獲取產品)           ║
║  • cartSlice.ts (加購物車)     ║
║                                ║
║ Props：                        ║
║  • productId: string           ║
║  • showDetails: boolean        ║
║  • onAddToCart: () => void     ║
╚════════════════════════════════╝
```

**功能 2：切換資料流視圖**

```
┌────────────────────────────────┐
│ 用戶互動                        │
│     ↓                          │
│ Pages (路由層)                  │
│     ↓                          │
│ Components (UI 層)              │
│     ↓                          │
│ Services (API 請求)             │
│     ↓                          │
│ Store (狀態更新)                │
│     ↓                          │
│ Components (重新渲染)           │
└────────────────────────────────┘
```

**功能 3：搜尋與聚焦**

搜尋 `cart`：
```
結果高亮：
✓ ShoppingCart.tsx (黃色高亮)
✓ CartPage.tsx (黃色高亮)
✓ cartSlice.ts (黃色高亮)
✓ 相關連線變為紅色
✓ 其他組件半透明化
```

#### Phase 4：生成的提示詞

```
這個 React 電商專案採用四層架構：

1. 頁面層（Pages）：
   - HomePage、ProductPage、CartPage
   - 負責路由和頁面佈局

2. 組件層（Components）：
   - ProductCard（HomePage 和 ProductPage 共用）
   - ShoppingCart、Checkout（CartPage 使用）

3. 服務層（Services）：
   - api.ts：處理 HTTP 請求
   - auth.ts：管理認證
   - 被 Pages 和 Components 呼叫

4. 狀態層（Store）：
   - cartSlice.ts：購物車狀態
   - userSlice.ts：用戶狀態
   - 使用 Redux Toolkit

關鍵資料流：
用戶點擊 ProductCard → 觸發 cartSlice.addToCart 
→ ShoppingCart 自動更新 → Checkout 讀取資料結帳

建議：
- Checkout 可拆分為更小的子組件
- 為 services 添加錯誤處理中間件
```

### 實戰案例 2：微服務架構

#### 系統描述

```
我們有以下微服務：
- API Gateway（入口）
- User Service、Product Service
- Order Service、Payment Service
- Notification Service

透過 RabbitMQ 進行非同步通訊。
請建立互動式架構圖。
```

#### 特殊功能：時間軸動畫

**控制面板**：
```
場景模擬
├── [下訂單流程]
├── [用戶註冊流程]
└── [支付完成流程]

時間軸
├── [▶️ 播放] [⏸️ 暫停] [🔄 重置]
└── 速度：[1x] [2x] [4x]
```

**動畫演示（下訂單流程）**：

```
Step 1: Client → API Gateway
        [POST /api/orders]

Step 2: API Gateway → Order Service
        [創建訂單]

Step 3: Order Service → Product Service
        [檢查庫存]

Step 4: Order Service → Payment Service
        [處理支付]

Step 5: Payment Service → RabbitMQ
        [發送 payment.completed 事件]

Step 6: RabbitMQ → Order Service
        [更新訂單狀態]

Step 7: RabbitMQ → Notification Service
        [發送確認郵件]
```

---

## 進階技巧與最佳實踐

### Design Playground 進階技巧

#### 技巧 1：響應式設計預覽

```
請在 Design Playground 中加入響應式預覽，
讓我看到手機、平板、桌面三種尺寸下的效果
```

生成的介面會包含：
```
[📱 Mobile] [📱 Tablet] [💻 Desktop]
```

#### 技巧 2：動畫時間軸

```
請加入動畫展示，讓我看到 hover、focus、active 
狀態的轉場效果，並可以調整動畫速度
```

#### 技巧 3：直接匯出程式碼

```
請在 Playground 底部加入「匯出 CSS」和「匯出 Tailwind」
按鈕，讓我直接取得對應程式碼
```

#### 技巧 4：A/B 測試對比

```
請建立雙欄預覽，讓我可以同時看兩種設計方案，
方便比較和選擇
```

### Code Map 進階技巧

#### 技巧 1：效能熱點分析

```
請在 Code Map 中加入效能熱點標示，
用顏色深淺表示組件的渲染頻率
```

視覺效果：
```
🔴 熱點（高頻渲染）
🟡 中等
🟢 冷點（低頻）
```

#### 技巧 2：版本對比

```
請建立可以對比兩個版本架構差異的 Code Map，
顯示重構前後的變化
```

#### 技巧 3：自動生成文檔

```
請加入「生成架構文檔」按鈕，
自動將視覺化架構轉為 Markdown 文檔
```

#### 技巧 4：整合專案統計

```
在 Code Map 中顯示每個模組的統計：
- 程式碼行數
- 複雜度評分
- 測試覆蓋率
- 最後修改時間
```

### 提示詞生成最佳實踐

#### 原則 1：只提及非預設值

```javascript
function updatePrompt() {
  const parts = [];
  
  if (state.borderRadius !== DEFAULTS.borderRadius) {
    parts.push(`圓角 ${state.borderRadius}px`);
  }
  
  // 只在有改變時才加入
  if (parts.length > 0) {
    return `更新卡片使用${parts.join('、')}`;
  } else {
    return '使用預設樣式的卡片';
  }
}
```

#### 原則 2：使用定性描述

```javascript
if (state.shadowBlur > 16) {
  parts.push('明顯的陰影');
} else if (state.shadowBlur > 0) {
  parts.push('微妙的陰影');
}
// 而非只寫 shadowBlur: 8
```

#### 原則 3：提供足夠上下文

```javascript
// ❌ 錯誤
"8px、藍色、16px"

// ✅ 正確
"創建按鈕組件，使用 8px 圓角、藍色背景（#3b82f6）、
16px 內邊距。整體風格應該簡約內斂。"
```

### 常見錯誤與解決方案

#### 錯誤 1：控制項過多

**問題**：介面雜亂，使用者不知從何開始

**解決**：
```html
<div class="controls">
  <section>
    <h3>基本樣式</h3>
    <!-- 最常用的 3-5 個控制項 -->
  </section>
  
  <details>
    <summary>進階選項 ▼</summary>
    <!-- 進階控制項摺疊在這裡 -->
  </details>
</div>
```

#### 錯誤 2：預覽不即時更新

**問題**：調整滑桿，畫面沒反應

**解決**：
```javascript
// ✅ 使用 'input' 事件
slider.addEventListener('input', (e) => {
  state.value = e.target.value;
  updateAll(); // 立即更新
});

// ❌ 避免用 'change' 事件（只在失焦時觸發）
```

#### 錯誤 3：沒有預設值

**問題**：頁面載入時是空白的

**解決**：
```javascript
const DEFAULTS = {
  borderRadius: 8,
  shadowBlur: 8,
  padding: 16
};

// 初始化
window.addEventListener('DOMContentLoaded', () => {
  Object.assign(state, DEFAULTS);
  updateAll();
});
```

---
## 總結與資源 

### 核心價值

Playground Skill 的三大價值：

1. **🎨 視覺化探索**
   - 將抽象概念轉為可互動介面
   - 降低溝通成本，提高精確度

2. **⚡ 即時反饋**
   - 每個調整立即看到效果
   - 快速試錯，找到最佳方案

3. **🔄 無縫整合**
   - 自動生成自然語言指令
   - 輕鬆整合回 Claude Code 工作流

### 使用時機

記住這三個關鍵場景：

| 場景 | 使用模板 | 範例 |
|------|---------|------|
| 🎨 視覺設計 | Design Playground | 難以用文字描述 UI 外觀時 |
| 📊 複雜配置 | Data Explorer | 選項組合太多需要視覺化探索 |
| 🗺️ 系統理解 | Code Map | 需要互動式理解專案架構 |

### 快速開始指令

```bash
# Design Playground
請建立一個設計 playground，幫我調整按鈕的樣式

# Code Map
請用 playground 為這個專案建立互動式架構圖

# Data Explorer
幫我建立一個 SQL 查詢的視覺化工具

# Concept Map
建立概念地圖，幫我理解這個技術的核心概念

# Document Critique
創建文件審查工具，讓我可以添加評論

# Diff Review
建立 code review playground，幫我審查 Git diff
```

### 延伸資源

- 📚 [Claude Code 官方文檔](https://code.claude.com/docs)
- 🔌 [Anthropic 插件庫](https://github.com/anthropics/claude-plugins-official)
- 🛠️ [Skills 市場](https://skills.sh)
- 💬 [社群討論](https://github.com/anthropics/claude-plugins-official/discussions)

### 下一步行動

1. ✅ 立即安裝 Playground Skill
2. 🎨 試試 Design Playground 設計一個按鈕
3. 🗺️ 用 Code Map 視覺化你的專案架構
4. 💡 探索其他四種模板的可能性
5. 🚀 將 Playground 整合進你的日常工作流

---

**記住**：Playground 不只是工具，更是你和 Claude 之間精確溝通的橋樑。

當你下次需要設計 UI、理解架構、建構查詢時，別忘了說：

> 「請建立一個 playground 工具...」

你會發現工作效率大幅提升！✨

