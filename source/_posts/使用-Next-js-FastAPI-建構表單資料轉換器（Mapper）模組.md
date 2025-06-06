---
title: 使用 Next.js + FastAPI 建構表單資料轉換器（Mapper）模組
date: 2025-06-06 11:18:24
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


# 使用 Next.js + FastAPI 建構表單資料轉換器（Mapper）模組

在實務專案中，前端表單往往由多層巢狀的資料組成，例如使用者輸入的一系列目標設定、報告項目、子任務等。但後端通常需要儲存成平坦化的資料表（例如：一張批次表、一張細項表、一張子細項表）。

為了解決前端與後端資料格式不一致的問題，我們可以設計一個 **Mapper 模組**，作為兩端資料結構之間的轉譯橋梁。

---

## 🧰 系統架構概覽

* 前端：使用 **Next.js + React Hook Form** 建構表單
* 後端：使用 **FastAPI** 作為 RESTful API 框架
* 資料庫：PostgreSQL，使用多張關聯表設計

---

## 📌 範例情境：多層表單資料送出

假設你要送出一份多層結構的「使用者目標設定表單」：

```json
{
  "category_id": 3,
  "year": 2024,
  "owner": "Alice",
  "items": [
    {
      "name": "任務 A",
      "value": 100,
      "sub_items": [
        { "label": "子任務 A1", "score": 30 },
        { "label": "子任務 A2", "score": 70 }
      ]
    }
  ]
}
```

後端需要將資料拆解後分別寫入：

* `goal_batches` 表（紀錄批次）
* `goal_items` 表（每個任務）
* `goal_sub_items` 表（任務下的子任務）

---

## 🔧 Mapper 設計

撰寫一個通用的 `map_goal_payload()` 函式，協助拆解 JSON 結構：

```python
def map_goal_payload(payload: dict) -> dict:
    batch_data = {
        "category_id": payload["category_id"],
        "year": payload["year"],
        "owner": payload["owner"]
    }

    items_data = []
    for item in payload["items"]:
        item_data = {
            "name": item["name"],
            "value": item["value"],
            "sub_items": item.get("sub_items", [])
        }
        items_data.append(item_data)

    return {
        "batch": batch_data,
        "items": items_data
    }
```

---

## 💡 實際應用 in FastAPI

```python
@router.post("/goals/submit")
def submit_goals(payload: dict, db: Session = Depends(get_db)):
    mapped = map_goal_payload(payload)

    batch = GoalBatch(**mapped["batch"])
    db.add(batch)
    db.flush()

    for item in mapped["items"]:
        goal_item = GoalItem(batch_id=batch.id, name=item["name"], value=item["value"])
        db.add(goal_item)
        db.flush()

        for sub in item["sub_items"]:
            sub_item = GoalSubItem(item_id=goal_item.id, **sub)
            db.add(sub_item)

    db.commit()
    return {"message": "成功建立目標紀錄"}
```

---

## 🧪 搭配 Pydantic 型別驗證

定義清楚的 Schema 可提升開發效率與資料安全性：

```python
class SubItemSchema(BaseModel):
    label: str
    score: int

class GoalItemSchema(BaseModel):
    name: str
    value: int
    sub_items: List[SubItemSchema]

class GoalBatchSchema(BaseModel):
    category_id: int
    year: int
    owner: str
    items: List[GoalItemSchema]
```

---

## 🔍 結語：將前端巢狀資料結構轉換為後端關聯資料的利器

透過 Mapper 設計：

* ✅ 將複雜表單結構轉成簡潔平坦格式
* ✅ 降低後端邏輯耦合，方便重用與測試
* ✅ 對應前端 JSON 結構變化，只需更新 mapping 規則即可

這種設計特別適合複雜業務系統、ERP、CRM、內部管理後台等場景。
