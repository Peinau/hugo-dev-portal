---
title: "Debit checkout con Webpay Plus"
description: ""
weight: 10
---

Recibe pagos online con la solución Transbank Webpay a través de PEINAU.

Con esto podrás potenciar tus ventas online ya que permitirás que tus clientes paguen sus compras electrónicas con Tarjetas de débito, integrándose al paso final del flujo del carro de compras.

Para integrarte debes seguir los siguientes pasos:

## 1. Obtener un Token de Acceso

Al completar el registro de la aplicación (Alta del Comercio), obtendrás dos llaves con las cuales te podrás autenticar en el sistema, a estas les llamamos **client_id** (identificador) y **client_secret** (Clave Secreta).

![Ejemplo de client_id y client_secret](/api-checkout/split-checkout/images/portal-1.png)

Con estas credenciales podrás obtener el **token de acceso** llamando a la **API de Autenticación** de la siguiente forma:

```
export CLIENT_ID=641281901508761220281
export CLIENT_SECRET=B8WKRXMiWHHrMCectt9Rg3ju4Y8GNheEa50gx6365sBV
curl -v -X POST https://api.sandbox.connect.fif.tech/sso/oauth2/v2/token \
 -H "Content-Type:application/x-www-form-urlencoded" \
 -H "Authorization: Basic $CLIENT_ID:$CLIENT_SECRET" \
 -d "grant_type=client_credentials" | json_pp
```

> El **CLIENT_ID** y **CLIENT_SECRET** utilizados en esta petición son datos de prueba.

Como respuesta obtendrás el **access_token**:

```
{  
   "scope":"",
   "token_type":"Bearer",
   "access_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJwcmltYXJ5c2lkIjoiMjhhZGI5OTktN2EyZS03MGI4LWMwOTItZTRjMTZhOWU5ZTBhIiwidW5pcXVlX25hbWUiOiJHbWFpbCIsImdyb3Vwc2lkIjoiQVBQTCIsImlzcyI6IkZhbGFiZWxsYSIsImF1ZCI6IldlYiIsInNjb3BlIjpbXSwiaWF0IjoxNTA4ODExNzA2LCJleHAiOjMwMTc3MDk4MTJ9.MQJFaXB-TWYbPGeJYU5CYcYJmc8mtERokeEgNSq31IjnIWvPugpD1lA0vU1zTsCTJJxb-jMfQGLqYb68HjMrZPiaFk09HZTWjdKEdWyV07Ospv4BwtVEfSlFBw-hVoazIYXng4UNXGQwxhMEduHyRY4yB6Anc2vk6J_EBPTkGv75ogsYl6bt1NTSZ9oHkjhz8Mp05Re7lt59XRajSFYp9OJExHjMJOS3mQw-zwwJedKua9XcdNu65Zx-8Zur7pcU_qk9Bjbd5o5D6Y5R6ueYUQx7kWnabWgt8ubDsEqRTnqUDvcY-5KYmMKXjtFD6riMWGXyX3EaOPNvYwrFNoXH9A",
   "expires_in":1508898106
}
```

Con el **access_token** generado, ya puedes comenzar a usar nuestras APIs para completar los pasos siguientes. 

## 2. Intención de Pago

Para contiunar con el proceso de pago debes ingresar el **access_token** generado en el **paso 1**y hacer el llamado de la siguiente forma:

```
export access_token="{access_token}"
curl -X POST 'https://api.sandbox.connect.fif.tech/checkout/payments' \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer $access_token" \
 -d '{ 
   "intent": "sale", 
   "payer": { 
     "payer_info": { 
       "email": "jlprueba1@quickpay.com", 
       "full_name": "JL Prueba 1",
       "country": "CL",
       "documentNumber": "123123123",
       "documentType": "RUT"
     }, 
     "payment_method": "TRANSBANK_WEBPAY"
   }, 
   "transaction": { 
     "reference_id": "OD0000233", 
     "description": "Transaction detailed description", 
     "soft_descriptor": "Short Description", 
     "amount": { 
       "currency": "CLP", 
       "total": 4500, 
       "details": { 
         "subtotal": 810, 
         "tax": 190, 
         "shipping": 0, 
         "shipping_discount": 0 
       } 
     }, 
     "item_list": { 
       "shipping_address": { 
         "line1": "Miraflores 222", 
         "city": "Santiago", 
         "country_code": "CL", 
         "phone": "+56 9 1234 5674", 
         "type": "HOME_OR_WORK", 
         "recipient_name": "JL Prueba 1" 
       }, 
       "shipping_method": "DIGITAL", 
       "items": [ 
         { 
           "sku": "1231232", 
           "name": "Destornillador 2344", 
           "description": "Destornillador SCL - ONT", 
           "quantity": 1, 
           "price": 4500, 
           "tax": 0 
         } 
       ] 
     } 
   }, 
   "redirect_urls": { 
     "return_url": "https://requestb.in/sfoogtsf", 
     "cancel_url": "https://chao.com" 
   } 
 }' | json_pp
```

Como respuesta obtendrás la siguiente información:

```
{
    "intent": "sale",
    "application": "6d717967-8288-0089-69d1-a6a0b7cce54e",
    "redirect_urls": {
        "return_url": "https://requestb.in/sfoogtsf",
        "cancel_url": "https://chao.com"
    },
    "transaction": {
        "reference_id": "OD0000233",
        "description": "Transaction detailed description",
        "soft_descriptor": "Short Description",
        "item_list": {
            "shipping_method": "DIGITAL",
            "items": [
                {
                    "sku": "1231232",
                    "name": "Destornillador 2344",
                    "description": "Destornillador SCL - ONT",
                    "quantity": 1,
                    "price": 4500,
                    "tax": 0
                }
            ],
            "shipping_address": {
                "line1": "Miraflores 222",
                "city": "Santiago",
                "country_code": "CL",
                "phone": "+56 9 1234 5674",
                "type": "HOME_OR_WORK",
                "recipient_name": "JL Prueba 1"
            }
        },
        "amount": {
            "currency": "CLP",
            "total": 4500,
            "details": {
                "subtotal": 810,
                "tax": 190,
                "shipping": 0,
                "shipping_discount": 0
            }
        }
    },
    "payer": {
        "payer_info": {
            "documentType": "RUT",
            "documentNumber": "123123123",
            "country": "CL",
            "full_name": "JL Prueba 1",
            "email": "jlprueba1@quickpay.com"
        },
        "payment_method": "TRANSBANK_WEBPAY"
    },
    "links": [
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/d8536e18-3632-fdcb-f2ed-45d8390e8ab9",
            "rel": "self",
            "security": [
                "ApiKey"
            ],
            "method": "GET"
        },
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/gateways/transbank/webpay/d8536e18-3632-fdcb-f2ed-45d8390e8ab9/pay",
            "rel": "approval_url",
            "method": "REDIRECT"
        },
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/gateways/transbank/webpay/d8536e18-3632-fdcb-f2ed-45d8390e8ab9/reverse",
            "rel": "reverse_method",
            "security": [
                "Jwt"
            ],
            "method": "POST"
        }
    ],
    "id": "d8536e18-3632-fdcb-f2ed-45d8390e8ab9",
    "create_time": "2017-11-20T16:09:20.944Z",
    "update_time": "2017-11-20T16:09:20.944Z",
    "state": "created",
    "invoice_number": "INPA-50000000499"
}
```

Obtendrás los Links:

- **self**: desde esta URL puedes consultar la información de la captura.
- **approval_url**: debes desplegar esta URL al cliente para que pueda continuar con el pago.
- **reverse_method**: te permite anular la transacción.

## 3. Mostrar Formulario de Pago Transbank Webpay

Con la **approval_url** obtenida en el **paso 2** puedes desplegar el formulario de pago con Transbank Webpay.

FOTO [Ejemplo de Formulario Transbank]

**Datos de prueba WebPay plus:**

> |Número de Tarjeta|RUT|Password|
> |---|---|---|
> |4051885600446623|11.111.111-1|123|

Desde este punto, el cliente interactua directamente con WebPay plus. 

Una vez finalizada la transacción, PEINAU devuelve el resultado de esta a la URL que indicaste en el request a la API **intención de pago** **(paso 2)**.

## 4. Consulta de Estado de la Transacción

Con la url **self** obtenida en el **paso 2** puedes consultar el estado de la transacción de la siguiente forma:

```
curl -X GET \
https://api.sandbox.connect.fif.tech/checkout/payments/{id} \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer $access_token" \
 -d '{
}'| json_pp
```

> Donde access_token es el **token de acceso** generado en el **paso 1** y el **id** es el id de la intención de pago generado en el **paso 2**.

Obtendrás una respuesta similar a:

```
{
    "intent": "sale",
    "application": "28adb999-7a2e-70b8-c092-e4c16a9e9e0a",
    "redirect_urls": {
        "return_url": "https://requestb.in/sfoogtsf",
        "cancel_url": "https://chao.com"
    },
    "transaction": {
        "reference_id": "OD0000233",
        "description": "Transaction detailed description",
        "soft_descriptor": "Short Description",
        "item_list": {
            "shipping_method": "DIGITAL",
            "items": [
                {
                    "sku": "1231232",
                    "name": "Destornillador 2344",
                    "description": "Destornillador SCL - ONT",
                    "quantity": 1,
                    "price": 4500,
                    "tax": 0,
                    "_id": "5a14412d3d3d6b001405ef48"
                }
            ],
            "shipping_address": {
                "line1": "Miraflores 222",
                "city": "Santiago",
                "country_code": "CL",
                "phone": "+56 9 1234 5674",
                "type": "HOME_OR_WORK",
                "recipient_name": "JL Prueba 1"
            }
        },
        "amount": {
            "currency": "CLP",
            "total": 4500,
            "details": {
                "subtotal": 810,
                "tax": 190,
                "shipping": 0,
                "shipping_discount": 0
            }
        }
    },
    "payer": {
        "payer_info": {
            "documentType": "RUT",
            "documentNumber": "123123123",
            "country": "CL",
            "full_name": "JL Prueba 1",
            "email": "jlprueba1@quickpay.com"
        },
        "payment_method": "TRANSBANK_WEBPAY"
    },
    "links": [],
    "id": "ffd9367d-5a9f-92de-fb24-0276a3156bf1",
    "create_time": "2017-11-21T15:07:26.024Z",
    "update_time": "2017-11-21T15:08:45.185Z",
    "state": "paid",
    "invoice_number": "INPA-50000000545",
    "gateway": {
        "accountingDate": "1121",
        "buyOrder": "INPA-50000000545",
        "cardDetail": {
            "cardNumber": "6623"
        },
        "detailOutput": [
            {
                "sharesNumber": 0,
                "amount": "4500",
                "commerceCode": "597020000541",
                "buyOrder": "INPA-50000000545",
                "authorizationCode": "1213",
                "paymentTypeCode": "VD",
                "responseCode": 0
            }
        ],
        "sessionId": "ffd9367d-5a9f-92de-fb24-0276a3156bf1",
        "transactionDate": "2017-11-21T15:07:44.204Z",
        "urlRedirection": "https://webpay3gint.transbank.cl/filtroUnificado/voucher.cgi",
        "VCI": "TSY"
    }
}
```
