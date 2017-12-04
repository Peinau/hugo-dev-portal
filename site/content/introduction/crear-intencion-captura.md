---
title: "2. Crear una Intención de Captura"
description: ""
weight: 20
---

Luego de haber obtenido el **access_token** y con la información mínima del cliente, se debe crear una **intención de captura**.

Utilizando dicho **access_token**, debes ejecutar una llamanda a la **API de captura /captures** de la siguiente forma:

```
curl -X POST 'https://api.sandbox.connect.fif.tech/tokenization/captures' \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer ACCESS TOKEN" \
 -d '{
  "capture": "CREDIT_CARD",
  "capture_method": "TOKENIZATION",
  "cardholder": {
    "reference_id": "001389",
    "country": "CL",
    "name": "Mati 1",
    "email": "JLPrueba1@gmail.com"
  },
  "billing": {
    "line1": "Miraflores 222",
    "city": "Santiago",
    "state": "Region Metropolitana",
    "country": "CL"
  },
  
  "redirect_urls": {
    "return_url": "https://requestb.in/sfoogtsf",
    "cancel_url": "http://www.mysite.cl/cancel"
  }
}' | json_pp
```
**Detalle de los campos enviados**


| Nombre        | Tipo            | Descripción  | Requerido |
| ------------- | --------------- | ------------ | --------- |
| capture      | Enum  | Tipo de Captura solicitada en la intención.             | Sí |
| capture_method| Enum | Método de Captura para la tarjeta   | Sí |
| cardholder | Object        | Datos del tarjeta habiente | Sí |
| cardholder.reference_id | String        | Identificador externo del comercio | No |
| cardholder.country | String ([ISO 3166-1 alpha-2][ISO 3166-1 alpha-2])        | País de residencia del tarjeta habiente | Sí |
| cardholder.name | String      | Nombre del tarjeta habiente tal como se muestra en la tarjeta | Sí |
| cardholder.email | String      | Email del tarjeta habiente | Sí |
| billing | String      | Dirección de facturación asociada a la tarjeta  | Sí |
| billing.line1 | String      | Dirección de facturación | Sí |
| billing.line2 | String      | Dirección 2 de facturación | No |
| billing.city | String      | Ciudad para facturación | Sí |
| billing.state | String      | Comuna de facturación | Sí |
| billing.country | String ([ISO 3166-1 alpha-2][ISO 3166-1 alpha-2])     | País de facturación| Sí |
| redirect_urls | Object      | Url de redirección dependiendo del estado de la captura una vez finalizado el proceso de captura | Sí |
| redirect_urls.return_url | String (Url)      | Url de redirección al producirse una captura exitosa | Sí |
| redirect_urls.cancel_url | String (Url)      | Url de redirección al producirse una captura fallida | Sí |

Como respuesta obtendrás la siguiente información:

```
{
    "capture": "CREDIT_CARD",
    "capture_method": "TOKENIZATION",
    "application": "28adb999-7a2e-70b8-c092-e4c16a9e9e0a",
    "redirect_urls": {
        "return_url": "https://requestb.in/sfoogtsf",
        "cancel_url": "http://www.mysite.cl/cancel"
    },
    "billing": {
        "line1": "Miraflores 222",
        "city": "Santiago",
        "state": "Region Metropolitana",
        "country": "CL"
    },
    "cardholder": {
        "reference_id": "001389",
        "country": "CL",
        "name": "Mati 1",
        "email": "JLPrueba1@gmail.com"
    },
    "id": "42743d48-7699-0d00-ef45-a68c587e662d",
    "create_time": "2017-10-24T02:27:28.985Z",
    "update_time": "2017-10-24T02:27:28.985Z",
    "state": "created",
    "capture_number": "INCA-50000000006",
    "links": [
        {
            "href": "https://api.sandbox.connect.fif.tech/tokenization/captures/42743d48-7699-0d00-ef45-a68c587e662d",
            "rel": "self",
            "method": "GET"
        },
        {
            "href": "https://api.sandbox.connect.fif.tech/tokenization/captures/gateways/credit/card/42743d48-7699-0d00-ef45-a68c587e662d/capture",
            "rel": "capture_url",
            "method": "REDIRECT"
        }
    ]
}
```

Detalle de las URLs generadas:

+ URL 1 (**rel: self**): desde esta URL puedes consultar la información de la intención de captura.
+ URL 2 (**rel: capture_url**): desde esta URL debes acceder al formulario de captura de la tarjeta.

Ir al paso [3. Mostrar formulario de Captura de tarjeta]({{%relref "formulario-captura-tarjeta.md"%}})
