---
title: 使用標準 OIDC 客戶端連接 Casdoor
date: 2025-03-07 16:39:03
tags:
    - Casdoor
    - OIDC
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

# 使用標準 OIDC 客戶端連接 Casdoor

![image](https://hackmd.io/_uploads/SJEgUXOskx.png)
>https://casdoor.org/docs/how-to-connect/oidc-client

## OIDC 探索 (OIDC Discovery)  

Casdoor 完整實作了 OIDC（OpenID Connect）協議。如果您的應用程式已經使用標準 OIDC 客戶端庫來連接其他 OAuth 2.0 身份提供者（Identity Provider），並希望遷移到 Casdoor，那麼使用 **OIDC 探索機制（OIDC Discovery）** 將使切換變得非常簡單。  

Casdoor 的 OIDC 探索 URL 格式如下：  
```
<你的 Casdoor 伺服器域名>/.well-known/openid-configuration
```
例如，Casdoor 官方示範站點的 OIDC 探索 URL 為：  
[https://door.casdoor.com/.well-known/openid-configuration](https://door.casdoor.com/.well-known/openid-configuration)  

此 URL 會返回一個 JSON 配置文件，其中包含 OIDC 相關的端點與支持的功能。例如：  

```json
{
  "issuer": "https://door.casdoor.com",
  "authorization_endpoint": "https://door.casdoor.com/login/oauth/authorize",
  "token_endpoint": "https://door.casdoor.com/api/login/oauth/access_token",
  "userinfo_endpoint": "https://door.casdoor.com/api/userinfo",
  "jwks_uri": "https://door.casdoor.com/.well-known/jwks",
  "introspection_endpoint": "https://door.casdoor.com/api/login/oauth/introspect",
  "response_types_supported": [
    "code",
    "token",
    "id_token",
    "code token",
    "code id_token",
    "token id_token",
    "code token id_token",
    "none"
  ],
  "response_modes_supported": [
    "login",
    "code",
    "link"
  ],
  "grant_types_supported": [
    "password",
    "authorization_code"
  ],
  "subject_types_supported": [
    "public"
  ],
  "id_token_signing_alg_values_supported": [
    "RS256"
  ],
  "scopes_supported": [
    "openid",
    "email",
    "profile",
    "address",
    "phone",
    "offline_access"
  ],
  "claims_supported": [
    "iss",
    "ver",
    "sub",
    "aud",
    "iat",
    "exp",
    "id",
    "type",
    "displayName",
    "avatar",
    "permanentAvatar",
    "email",
    "phone",
    "location",
    "affiliation",
    "title",
    "homepage",
    "bio",
    "tag",
    "region",
    "language",
    "score",
    "ranking",
    "isOnline",
    "isAdmin",
    "isGlobalAdmin",
    "isForbidden",
    "signupApplication",
    "ldap"
  ],
  "request_parameter_supported": true,
  "request_object_signing_alg_values_supported": [
    "HS256",
    "HS384",
    "HS512"
  ]
}
```

---

## OIDC 客戶端函式庫  

以下是一些常見的 OIDC 客戶端函式庫，可用於不同程式語言來實現 OIDC 驗證功能：  

| OIDC 客戶端函式庫 | 程式語言 | 連結 |
|------------------|--------|------|
| go-oidc | Go | [GitHub](https://github.com/coreos/go-oidc) |
| pac4j-oidc | Java | [官方文件](https://www.pac4j.org/docs/clients/openid-connect.html) |

這份清單並不完整，您可以在以下連結找到更多 OIDC 客戶端函式庫的資訊：  

- [OAuth 客戶端函式庫列表](https://oauth.net/code/)  
- [OpenID 認證開發工具](https://openid.net/certified-open-id-developer-tools/)  

---

## OIDC UserInfo 欄位對應  

當使用 `/api/userinfo` API 取得 OIDC 使用者資訊時，Casdoor 會將內部的使用者屬性對應到標準的 OIDC UserInfo 欄位，如下表所示：  

| Casdoor 使用者欄位 | OIDC UserInfo 欄位 |
|------------------|------------------|
| Id | sub |
| originBackend | iss |
| Aud | aud |
| Name | preferred_username |
| DisplayName | name |
| Email | email |
| Avatar | picture |
| Location | address |
| Phone | phone |

完整的 UserInfo 定義可參閱 Casdoor 官方文件。  

這樣的 OIDC 探索與標準 OIDC 客戶端函式庫相結合，可以輕鬆地將 Casdoor 整合到您的應用程式中，無論是身份驗證還是權限管理，都能實現標準化與便捷的對接。