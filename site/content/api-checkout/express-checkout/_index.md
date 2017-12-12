---
title: "Credit Express Checkout"
description: ""
weight: 10
---

Con esta solución sólo debes mostrar un formulario al cliente, esto facilitará el proceso de checkout.

Para integrarte debes seguir los siguientes pasos:

## 1. Obtener un Token de Acceso

Al completar el registro de la aplicación (Alta del Comercio), obtendrás dos llaves con las cuales te podrás autenticar en el sistema, a estas les llamamos **client_id** (identificador) y **client_secret** (Clave Secreta).

Foto [Ejemplo de client_id y client_secret]

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
curl -X POST 'https://api.sandbox.connect.fif.tech/checkout/payments' \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer access_token" \
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
     "payment_method": "QUICKPAY_TOKEN"
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
                    "tax": 0
                }
            ],
            "shipping_address": {
                "line1": "Miraflores 222",
                "city": "Santiago",
                "country_code": "CL",
                "phone": "+56 9 1234 5674",
                "type": "HOME_OR_WORK",
                "recipient_name": "Andres Roa"
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
            "full_name": "Andres Roa",
            "email": "jlprueba1@quickpay.com"
        },
        "payment_method": "QUICKPAY_TOKEN"
    },
    "links": [
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/864f3629-07a1-56d1-31a9-cce39026b9a1",
            "rel": "self",
            "security": [
                "ApiKey"
            ],
            "method": "GET"
        },
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/gateways/quickpay/token/864f3629-07a1-56d1-31a9-cce39026b9a1/pay",
            "rel": "approval_url",
            "method": "REDIRECT"
        },
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/864f3629-07a1-56d1-31a9-cce39026b9a1/edit",
            "rel": "update_url",
            "method": "PUT"
        },
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/gateways/quickpay/token/864f3629-07a1-56d1-31a9-cce39026b9a1/silent",
            "rel": "silent_charge",
            "security": [
                "Jwt"
            ],
            "method": "POST"
        },
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/gateways/quickpay/token/864f3629-07a1-56d1-31a9-cce39026b9a1/reverse",
            "rel": "reverse_method",
            "security": [
                "Jwt"
            ],
            "method": "POST"
        }
    ],
    "id": "864f3629-07a1-56d1-31a9-cce39026b9a1",
    "create_time": "2017-12-12T01:50:09.578Z",
    "update_time": "2017-12-12T01:50:09.578Z",
    "state": "created",
    "invoice_number": "INPA-50000000922"
}
```

Obtendrás los Links:

- **self**: desde esta URL puedes consultar la información de la captura.
- **approval_url**: debes desplegar esta URL al cliente para que pueda continuar con el pago.
- **silent_charge**: con esta opción, no es requerida la aprobación del cliente para ejecutar el cargo a la tarjeta de crédito (debes tener el token de la tarjeta).
- **reverse_method**: te permite anular la transacción.

## 3. Mostrar Formulario de Pago

Con la **approval_url** obtenida en el **paso 2** puedes desplegar el formulario de pago.

FOTO [Ejemplo de Formulario Transbank]

**Datos de prueba:**

> |Número de Tarjeta|CCV|Fecha de vencimiento|
> |---|---|---|
> |4111111111111111|123|02/2020|

Al hacer clic en aprobar pago, finaliza la transacción y se ejecuta el cargo a la tarjeta de crédito dle cliente. En este punto, PEINAU devuelve el resultado de la transacción a la URL que indicaste en el request a la API **intención de pago** **(paso 2)**.

## 4. Consulta de Estado de la Transacción

Con la url **self** obtenida en el **paso 2** debes consultar el estado de la transacción de la siguiente forma:

```
curl -X GET \
https://api.sandbox.connect.fif.tech/checkout/payments/{id} \
-H 'authorization: Bearer access_token
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
                    "_id": "5a2f35d14bddb8000f673f25"
                }
            ],
            "shipping_address": {
                "line1": "Miraflores 222",
                "city": "Santiago",
                "country_code": "CL",
                "phone": "+56 9 1234 5674",
                "type": "HOME_OR_WORK",
                "recipient_name": "Andres Roa"
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
            "full_name": "Andres Roa",
            "email": "jlprueba1@quickpay.com"
        },
        "payment_method": "QUICKPAY_TOKEN"
    },
    "links": [],
    "id": "864f3629-07a1-56d1-31a9-cce39026b9a1",
    "create_time": "2017-12-12T01:50:09.578Z",
    "update_time": "2017-12-12T01:58:10.246Z",
    "state": "paid",
    "invoice_number": "INPA-50000000922",
    "additional_attributes": {
        "capture_token": "d9667df7-d0dc-9161-0407-790a4dd4450c"
    },
    "gateway": {
        "capture_token": "d9667df7-d0dc-9161-0407-790a4dd4450c",
        "payment_flow": "express_checkout",
        "installments_number": "1",
        "merchantReferenceCode": "INPA-50000000922",
        "requestID": "5130438896646406704009",
        "decision": "ACCEPT",
        "reasonCode": "100",
        "requestToken": "Ahj7/wSTFh8kckUIFouJilF5MUH53AKi8mKD87iYGxlHLGGTSTLdIDgL7QwJyYsPkjkihAtFxIAAghgZ",
        "purchaseTotals": {
            "currency": "CLP"
        },
        "ccAuthReply": {
            "reasonCode": "100",
            "amount": "4500",
            "authorizationCode": "570110",
            "avsCode": "1",
            "authorizedDateTime": "2017-12-12T01:58:10Z",
            "processorResponse": "1",
            "paymentNetworkTransactionID": "111222",
            "ownerMerchantID": "falabella",
            "processorTransactionID": "1a28d91e00e64981b4f9e2be5f7ffe11"
        },
        "ccCaptureReply": {
            "reasonCode": "100",
            "requestDateTime": "2017-12-12T01:58:10Z",
            "amount": "4500"
        },
        "additionalProcessorResponse": "fa23f52f-ea51-4b8e-962c-c8827b58f1ad",
        "resume": {
            "_id": "5a2f37b24bddb8000f673f27",
            "card_number": {
                "panLast4": 1111,
                "panFirst6": 411111
            },
            "authorizations": {
                "code": "570110"
            },
            "transaction": {
                "type": "CREDIT",
                "date": "2017-12-12T01:58:10.245Z",
                "currency": "CLP",
                "buy_order": "INPA-50000000922",
                "amount": 4500,
                "installments_number": 1
            },
            "response": {
                "code": 100
            }
        }
    }
}
```
