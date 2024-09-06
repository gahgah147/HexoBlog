---
title: Next JS 和開放式 AI / GPT：下一代 Next JS 和 AI 應用程式
date: 2024-02-27 16:30:43
tags:
    - Next JS
    - AUTH0
    - Tailwind CSS
    - Stripe
    - MongoDB
    - OpenAI
    - GPT API
---

# [Next JS 和開放式 AI / GPT：下一代 Next JS 和 AI 應用程式](https://softnshare.com/next-js-ai/?fbclid=IwAR2pwxtLQNCUgwpeKvYi23Ge1N7Svcmi7h_mgp-jJhs41r4znT9m4Ctq1yg)

# 這篇是學習Next JS 和開放式 AI / GPT：下一代 Next JS 和 AI 應用程式 課程的紀錄，
課程上有使用到以下工具

1. OpenAI 的 GPT 在應用程式中實現 AI 生成的內容
2. Auth0 驗證 Next JS 應用程式
3. Tailwind CSS 設計 Next JS 應用程式
4. MongoDB 儲存 Next JS 應用程式的資料
5. Stripe 向客戶收費

其中發現台灣沒辦法使用 Stripe 收費這邊比較困擾一點，另外其他功能都有成功設定。

## 第一堂課程

課程教學Github: https://github.com/tomphill/blog-standard-course
React基礎課程: https://youtu.be/HVFSgIVXcD4
第一堂Github連結: https://github.com/tomphill/nextjs-openai-starter 
課程連結: https://www.udemy.com/course/next-js-ai/learn/lecture/36192386?LSNPUBID=BoHFIyu6APU&components=add_to_cart%2Cavailable_coupons%2Cbase_purchase_section%2Cbuy_button%2Cbuy_for_team%2Ccacheable_buy_button%2Ccacheable_deal_badge%2Ccacheable_discount_expiration%2Ccacheable_price_text%2Ccacheable_purchase_text%2Ccurated_for_ufb_notice_context%2Ccurriculum_context%2Cdeal_badge%2Cdiscount_expiration%2Cgift_this_course%2Cincentives%2Cinstructor_links%2Clifetime_access_context%2Cmoney_back_guarantee%2Cprice_text%2Cpurchase_tabs_context%2Cpurchase%2Crecommendation%2Credeem_coupon%2Csidebar_container%2Cpurchase_body_container&ranEAID=BoHFIyu6APU&ranMID=39197&ranSiteID=BoHFIyu6APU-xOeQldV1zZ53.eDHqBvJfQ&utm_medium=udemyads&utm_source=aff-campaign#reviews

# auth0 設定
![image](https://hackmd.io/_uploads/ByWTukRo6.png)


![image](https://hackmd.io/_uploads/rkHSYyRs6.png)
>設定 auth0 API

## 產生 AUTH0_SECRET 方式
```
 openssl rand -hex 32
```

## 調整.env.local 設定檔案如下
```
AUTH0_SECRET=<AUTH0_SECRET>
AUTH0_BASE_URL=<AUTH0_BASE_URL>
AUTH0_ISSUER_BASE_URL=<AUTH0_ISSUER_BASE_URL>
AUTH0_CLIENT_ID=<AUTH0_CLIENT_ID>
AUTH0_CLIENT_SECRET=<AUTH0_CLIENT_SECRET>
```

## 新增 Application URI 設定
![image](https://hackmd.io/_uploads/Hko7ATxja.png)

## 設定auth0 登入身分驗證頁面
新增 pages/api/auth/[...auth0].js

```
import { handleAuth } from '@auth0/nextjs-auth0';

export default handleAuth();

```

## 調整 pages/index.js 檔案
```
import Link from 'next/link'
export default function Home() {
  return (
    <div>
      <h1>this is the homepage</h1>
      <div>
        <Link href="/api/auth/login">Login</Link>
      </div>
    </div>
  );
}
```

執行 npm run dev 後打開  http://localhost:3001/
![image](https://hackmd.io/_uploads/SyitcyAjp.png)

點擊login 後可以看到身分驗證畫面
![image](https://hackmd.io/_uploads/Syt1okAsa.png)

註冊頁面
![image](https://hackmd.io/_uploads/r1lIokCi6.png)

詢問授權
![image](https://hackmd.io/_uploads/ryWvqJRia.png)

## 設定頁面必須要登入才能瀏覽

舉例來說 pages/post/new.js 檔案內容:
```
import { withPageAuthRequired } from "@auth0/nextjs-auth0";

export default function NewPost(props){
    console.log('New Post Props:',props);
    return (
        <div>
            <h1>
                this is the new post page
            </h1>
        </div>
    );
}

export const getServerSideProps = withPageAuthRequired(() => {
    return {
        props:{},
    };
});
```

這邊的 withPageAuthRequired 就是限定使用者一定要登入才能看到這一頁的內容

repo紀錄: https://github.com/gahgah147/nextjs-openai-starter/tree/Day1-Auth0%E7%99%BB%E5%85%A5%E9%A9%97%E8%AD%89

# 透過Tailwind CSS設定外觀

![image](https://hackmd.io/_uploads/r1OLCBx2T.png)
>https://tailwindcss.com/

[Tailwind CSS 新手上路：概念、安裝與工具推薦](https://medium.com/@Kelly_CHI/tailwind-css-introduction-and-tools-68e770b2bf7f)

Tailwind CSS 是一個採用了「Utility First」理念的 CSS 框架。

練習Repo: https://github.com/gahgah147/nextjs-openai-starter/tree/Day2-%E9%80%8F%E9%81%8ETailwind-CSS%E8%A8%AD%E5%AE%9A%E5%A4%96%E8%A7%80

# 透過 OpenAI's GPT API 自動產生Blog 文章

首先到 Openai 平台
![image](https://hackmd.io/_uploads/SyjwaFg36.png)
>https://platform.openai.com/

登入後可以點選 Usage 查看用量
![image](https://hackmd.io/_uploads/Sk9aRtgh6.png)
> 像是這樣就是用完了

![image](https://hackmd.io/_uploads/BJufJcln6.png)
>這樣是還有用量可以使用

## 產生 API Keys
點選 API keys 後點擊 Create new secret key 按鈕
![image](https://hackmd.io/_uploads/HyRHeclhT.png)

這邊可以設定API key的名稱
![image](https://hackmd.io/_uploads/ryfn-5ehT.png)

成功產生API KEY
![image](https://hackmd.io/_uploads/BkPdzqxnp.png)

## 設定環境變數
修改 .env.local 檔新增以下內容
```
OPENAI_API_KEY=<剛剛產生的 API KEY>
```

## 安裝 react-markdown套件
```
npm i react-markdown
```

在程式碼中引用
例如:postContent 是 markdown 的內容
```

import Markdown from "react-markdown";

...
<Markdown>
    {postContent}
</Markdown>
...
```

## 設定MongoDB

![image](https://hackmd.io/_uploads/H1-poJ72p.png)
>https://www.mongodb.com/atlas/database

註冊後登入
![image](https://hackmd.io/_uploads/BkfW3ymhT.png)
>https://cloud.mongodb.com/v2/64a3c968e3797d3fc1796726#/clusters

### 設定IP ADDRESS
因為一開始如果沒有設定IP Address會無法連線到
點選 Network Access

![image](https://hackmd.io/_uploads/ByVPmx7nT.png)

點選 ADD IP ADDRESS

![image](https://hackmd.io/_uploads/SJk37gX2T.png)

選擇 ALLOW ACCESS FROM ANYWHERE

### 創建資料庫
點選DataBase 

![image](https://hackmd.io/_uploads/HylDVxQn6.png)

![image](https://hackmd.io/_uploads/B1hq0Zmh6.png)

建立新的資料庫
![image](https://hackmd.io/_uploads/BJRGyfQha.png)

再新增一個posts table
![image](https://hackmd.io/_uploads/SyNU1z7ha.png)

點選 Connect
![image](https://hackmd.io/_uploads/SJRcJf72T.png)

產生使用者
![image](https://hackmd.io/_uploads/Bk1beGm2T.png)

設定選擇 Connect to your application
![image](https://hackmd.io/_uploads/H1xHxMX3p.png)

複製這段程式碼
![image](https://hackmd.io/_uploads/rylnefm2p.png)

修改 .env.local 檔案新增以下這一行
```
MONGODB_URI=mongodb+srv://user:<password>@cluster0.biiwahu.mongodb.net/?retryWrites=true&w=majority
```

這樣就能成功建立連線

# 設定 Stripe 收費功能

{% note warning simple %}
這邊我發現一個問題 Stripe並不支援在台灣開立商戶帳戶 
{% endnote %}

![image](https://hackmd.io/_uploads/ryq1DtV26.png)
>https://stripe.com/

登入後創建帳號
![image](https://hackmd.io/_uploads/ry7kYtEha.png)

點選開發人員 > API 密鑰 複製 Secret key
![image](https://hackmd.io/_uploads/SkQ4KK4np.png)

修改 .env.local 檔案
```
STRIPE_SECRET_KEY=<剛剛的Secret key>
```

點選添加產品

![image](https://hackmd.io/_uploads/H1gkTKNnT.png)

新增一個 10 tokens 的產品
![image](https://hackmd.io/_uploads/SJghz6K43p.png)

複製這邊的 API ID
![image](https://hackmd.io/_uploads/BJMvaFNhT.png)

修改 .env.local 檔案
```
STRIPE_PRODUCT_PRICE_ID=<API ID>
```

## 設定Webhooks

點選 Webhooks
![image](https://hackmd.io/_uploads/SJyIOFS3p.png)

點擊 在本地環境中測試
![image](https://hackmd.io/_uploads/SJq__FB2T.png)

![image](https://hackmd.io/_uploads/HkifYFrhp.png)

下載CLI
這邊後來是選擇用apt 下載
Add Stripe CLI’s GPG key to the apt sources keyring:
```
curl -s https://packages.stripe.dev/api/security/keypair/stripe-cli-gpg/public | gpg --dearmor | sudo tee /usr/share/keyrings/stripe.gpg
```
Add CLI’s apt repository to the apt sources list:
```
echo "deb [signed-by=/usr/share/keyrings/stripe.gpg] https://packages.stripe.dev/stripe-cli-debian-local stable main" | sudo tee -a /etc/apt/sources.list.d/stripe.list
```
Update the package list:
```
sudo apt update
```
Install the CLI:
```
sudo apt install stripe
```

這邊會需要登入 stripe
![image](https://hackmd.io/_uploads/HkRfW5r26.png)

```
stripe listen --forward-to localhost:3000/api/webhooks/stripe
```
![image](https://hackmd.io/_uploads/HJrgr9B2T.png)

這樣可以取得 webhook signing secret 

修改 .env.local 檔案 新增 STRIPE_WEBHOOK_SECRET 內容
```
STRIPE_WEBHOOK_SECRET=<webhook signing secret >
```

repo紀錄: https://github.com/gahgah147/nextjs-openai-starter/tree/Day4-%E8%A8%AD%E5%AE%9AStripe%E6%94%B6%E8%B2%BB%E5%8A%9F%E8%83%BD

# 部屬

## 建立新的repository
點選新增
![image](https://hackmd.io/_uploads/rkLKtsK36.png)

![image](https://hackmd.io/_uploads/ryJ0YiKha.png)

![image](https://hackmd.io/_uploads/BkPJ5jKnp.png)

## 設定 digitalocean

![image](https://hackmd.io/_uploads/rJCHqoKnp.png)
>https://www.digitalocean.com/

註冊好後選擇部屬到APPs 上
![image](https://hackmd.io/_uploads/BkfHTjKhT.png)

設定連結到github 
![image](https://hackmd.io/_uploads/rJVCTjK2T.png)

這邊可以選擇想要的方案，這邊選擇Edit plan
![image](https://hackmd.io/_uploads/H1_W0iY36.png)

這邊選擇最便宜的 每月5美元方案
![image](https://hackmd.io/_uploads/B1R6-hF2a.png)

## 接下來可以設定環境變數
![image](https://hackmd.io/_uploads/HkiGM3t26.png)

選擇 Bulk Editor
![image](https://hackmd.io/_uploads/rJtVMnFha.png)

複製 env.local 的所有內容

![image](https://hackmd.io/_uploads/Syesf2F3T.png)

![image](https://hackmd.io/_uploads/Hy2oMhYn6.png)

這邊點擊後會需要等待一段時間
![image](https://hackmd.io/_uploads/B1imR3K3p.png)

成功後可以看到網站連結
![image](https://hackmd.io/_uploads/HkXxe6tnp.png)

修改環境變數 AUTH0_BASE_URL 為https://squid-app-zu4dz.ondigitalocean.app/
![image](https://hackmd.io/_uploads/HJR9bpFha.png)

修改 auth0 的環境變數
![image](https://hackmd.io/_uploads/HkKLzTY36.png)
>https://manage.auth0.com/


