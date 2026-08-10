# API Reference: <Service>

Base URL: `https://api.example.com`

All requests require header `Authorization: Bearer <token>`.

## `GET /v1/items`

List items.

**Query params**

| Name | Type | Required | Notes |
|---|---|---|---|
| `limit` | int | no | 1–100, default 20 |
| `cursor` | string | no | pagination cursor |

**Response `200`**

```json
{
  "items": [{ "id": "abc", "name": "Example" }],
  "next_cursor": null
}
```

**Errors**

- `401` — missing/invalid token
- `429` — rate limited

## `POST /v1/items`

Create an item.

**Body**

```json
{ "name": "Example" }
```

**Response `201`**

```json
{ "id": "abc", "name": "Example" }
```
