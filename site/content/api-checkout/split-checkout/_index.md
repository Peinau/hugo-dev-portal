---
title: "Split Checkout (captura de tarjeta + pago)"
description: ""
weight: 20
---

La integración mediante nuestra API te da un mayor control sobre el checkout en tu sitio, ya que el proceso se divide en dos etapas: Obtener un token de la tarjeta de crédito y realizar el cargo, y estas pueden ocurrir en momentos distintos.

Los pasos para realizar la integración son:

### 1. Obtener un Token de Acceso

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

### 2. Crear una Intención de Captura

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

### 3. Mostrar Formulario de Captura de tarjeta

Con la **capture_url** obtenida en el **paso 2** puedes desplegar el formulario de captura de tarjeta. [Puedes hacer clic aquí para ver un ejemplo de capture_url](https://api.sandbox.connect.fif.tech/tokenization/captures/gateways/credit/card/42743d48-7699-0d00-ef45-a68c587e662d/capture)

![Ejemplo de ventana Formulario](/api-checkout/split-checkout/images/captura-tarjeta-1.png)

El cliente debe ingresar los datos solicitados en el formulario y hacer clic en **Usar esta tarjeta** para obtener el token de la tarjeta de crédito.

![Ejemplo datos a ingresar](/api-checkout/split-checkout/images/captura-tarjeta-2.png)

La respuesta será enviada a la página de confirmacion indicada en la variable **"return_url"** de la petición a la **API de intención de Captura (paso 2)** o puedes consultar dicha respuesta llamando a la **API Revisión de Captura** de la siguiente forma:

```
 curl -X GET 'https://api.sandbox.connect.fif.tech/tokenization/captures/{{id}}'
```

> Debes reemplazar el **id** por el obtenido en la respuesta de la **API de captura /captures** **paso 2**.

**Ejemplo de respuesta enviada a la return_url:**

```
{
  "capture": "CREDIT_CARD",
  "capture_method": "TOKENIZATION",
  "application": "a3be1bc6-438a-c35e-e603-b15f2d30cfb9",
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
  "id": "fe5228dc-91ab-fa28-97ec-034bed089743",
  "create_time": "2017-10-12T20:29:36.035Z",
  "update_time": "2017-10-12T20:29:59.333Z",
  "state": "captured",
  "capture_number": "INCA-0000000047",
   "panLast4": "1111"
  }
}
```

El **id** generado corresponde al **Token de la tarjeta**.

> **id de ejemplo**"id": "fe5228dc-91ab-fa28-97ec-034bed089743"

Tabla de posibles respuestas:

| State    | Definición                               |
| -------- | ---------------------------------------- |
| captured | Se ha capturado la información de la tarjeta |
| canceled | Ocurrio un error y no se pudo completar la captura |

### 4. Intención de Pago

Para completar el pago con el **token de la tarjeta** debes ingresar el **id** obtenido previamente de la **return_url** en el campo **capture_token** de la petición a la API de **Intención de Pago /payments**, el **access_token** generado en el **paso 1** y hacer el llamado de la siguiente forma:

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
     "cancel_url": "https://chao.com",
     "additional_attributes": {
    "capture_token": "80bafec1-edf6-04ec-e08e-cabf7d93b688"
  }
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
        "payment_method": "QUICKPAY_TOKEN",
        "capture_token": "397fd6a5-5d3f-e588-e200-e37088d124b2"
    },
    "links": [
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/4422ad2b-7285-a953-2bfc-400b8318d517",
            "rel": "self",
            "method": "GET"
        },
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/gateways/quickpay/token/4422ad2b-7285-a953-2bfc-400b8318d517/pay",
            "rel": "approval_url",
            "method": "REDIRECT"
        },
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/gateways/quickpay/token/4422ad2b-7285-a953-2bfc-400b8318d517/reverse",
            "rel": "reverse_method",
            "method": "POST"
        },
        {
            "href": "https://api.sandbox.connect.fif.tech/checkout/payments/gateways/quickpay/token/4422ad2b-7285-a953-2bfc-400b8318d517/silent",
            "rel": "silent_charge",
            "method": "POST"
        }
    ],
    "id": "4422ad2b-7285-a953-2bfc-400b8318d517",
    "create_time": "2017-10-24T02:39:15.090Z",
    "update_time": "2017-10-24T02:39:15.090Z",
    "state": "created",
    "invoice_number": "INPA-50000000021"
}
```

Obtendrás los Links:

- **self**: desde esta URL puedes consultar la información de la captura.
- **approval_url**: desde esta URL el cliente debe autorizar el pago.
- **reverse_method**: para anular la transacción, debes hacer el llamado a este endpoint desde la **API de Anulación**.
- **silent_charge**: llamando a este endpoint desde la **API silent_charge** puedes ejecutar el cargo a la tarjeta de cŕedito del cliente sin pasar por la intención de pago.

### 5. ¿Cómo realizar el cargo a la tarjeta?

Te ofrecemos dos opciones para realizar el cargo a la tarjeta del cliente, a continuación podrás ver el detalle de cada una: 

#### 5.1 Approval

Si quieres utilizar esta opción, necesitas que el cliente apruebe el pago para ejecutar el cargo a la tarjeta de crédito. Para ello debes desplegar la ventana de aprobación del pago a partir de la [approval_url](https://quickpay-connect-checkout.azurewebsites.net/payments/gateways/quickpay/token/0fdcd938-62c7-aab2-5048-c2f172d495ac/pay) obtenida en el **paso 3**.

![Ejemplo Approval](/api-checkout/split-checkout/images/approval-1.png)

Si recibes una respuesta con **"state": "paid"** en la URL indicada como **return_url** o consultando desde la **URL self**, entonces el cliente ha aprobado del pago y se ejecuta el cargo a la tajeta de crédito.

  ```
{
    "intent": "sale",
    "additional_attributes": {
        "capture_token": "db95da9e-b94c-0b40-a84b-4268b0ca18bb"
    },
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
                    "_id": "5a29af7f6867b6000fe42a45"
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
    "id": "5247451f-e709-bc97-b195-8725f5e5d09a",
    "create_time": "2017-12-07T21:15:43.690Z",
    "update_time": "2017-12-07T21:16:02.340Z",
    "state": "paid",
    "invoice_number": "INPA-50000000915",
    "gateway": {
        "payment_flow": "with_token",
        "installments_number": "1",
        "merchantReferenceCode": "INPA-50000000915",
        "requestID": "5126813618226081704008",
        "decision": "ACCEPT",
        "reasonCode": "100",
        "requestToken": "Ahj7/wSTFezU3sEAuihIilF5MQdkMgKi8mIOyGSYGxlHK2GTSTLdIDgL7QwJyYr2am9ggF0UJAAAjAl3",
        "purchaseTotals": {
            "currency": "CLP"
        },
        "ccAuthReply": {
            "reasonCode": "100",
            "amount": "4500",
            "authorizationCode": "570110",
            "avsCode": "1",
            "authorizedDateTime": "2017-12-07T21:16:02Z",
            "processorResponse": "1",
            "paymentNetworkTransactionID": "111222",
            "ownerMerchantID": "falabella",
            "processorTransactionID": "6073acd1ed184b8cb4a85d8a68d778de"
        },
        "ccCaptureReply": {
            "reasonCode": "100",
            "requestDateTime": "2017-12-07T21:16:02Z",
            "amount": "4500"
        },
        "additionalProcessorResponse": "c7f3fc27-eb83-44f0-8429-5bf6918198a3",
        "capture_token": "db95da9e-b94c-0b40-a84b-4268b0ca18bb",
        "resume": {
            "_id": "5a29af926867b6000fe42a47",
            "card_number": {
                "panLast4": 1111
                "panFirst6": 411111
            },
            "authorizations": {
                "code": "570110"
            },
            "transaction": {
                "type": "CREDIT",
                "date": "2017-12-07T21:16:02.337Z",
                "currency": "CLP",
                "buy_order": "INPA-50000000915",
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
Posibles estados de la transacción:
  
| State    | Definición                               |
| -------- | ---------------------------------------- |
| paid  | El cargo fue realizado exitosamente en la cuenta del cliente |
| canceled | El cargo no fue realizado |
| reversed | Tiene al menos una devolución asociada |

#### 5.2 Silent Charge

Con esta opción, no es requerida la aprobación del cliente para ejecutar el cargo a la tarjeta de crédito.

Necesitas el **access_token** obtenido en la **Autenticación** y el **id (Token de la tarjeta)** generado en la **Intención de captura**, para ejecutar una llamada a la **API de Silent Charge /silent** de la siguiente forma:

{{%expand "CLIC AQUÍ PARA VER EJEMPLO DE LLAMADA A SILENT CHARGE" %}}
```
 curl -v -X POST 'https://api.sandbox.connect.fif.tech/checkout/payments/gateways/quickpay/token/{Token_de_tarjeta}/silent' \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer access_token"
```
{{% /expand%}}

{{%expand "CLIC AQUÍ PARA VER EJEMPLO DE RESPUESTA" %}}

```
{
    "intent": "sale",
    "additional_attributes": {
        "capture_token": "c9c19a22-b3b9-6b0b-c295-ab41c898f41c"
    },
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
                    "_id": "5a29b1144bddb8000f673f1a"
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
    "id": "a8cb0e21-acd1-93d7-f623-9a3a4523a2d0",
    "create_time": "2017-12-07T21:22:28.944Z",
    "update_time": "2017-12-07T21:22:46.142Z",
    "state": "paid",
    "invoice_number": "INPA-50000000916",
    "gateway": {
        "merchantReferenceCode": "INPA-50000000916",
        "requestID": "5126817655686174204009",
        "decision": "ACCEPT",
        "reasonCode": "100",
        "requestToken": "Ahj7/wSTFezjNs1vVeBpilF5MQeDvgKi8mIPB3yYGxlHK2GTSTLdIDgL7QwJyYr2cZtmt6rwNIAAMwWk",
        "purchaseTotals": {
            "currency": "CLP"
        },
        "ccAuthReply": {
            "reasonCode": "100",
            "amount": "4500",
            "authorizationCode": "570110",
            "avsCode": "1",
            "authorizedDateTime": "2017-12-07T21:22:46Z",
            "processorResponse": "1",
            "paymentNetworkTransactionID": "111222",
            "ownerMerchantID": "falabella",
            "processorTransactionID": "0c9a962865c44452a8edef0194cfac5c"
        },
        "ccCaptureReply": {
            "reasonCode": "100",
            "requestDateTime": "2017-12-07T21:22:46Z",
            "amount": "4500"
        },
        "additionalProcessorResponse": "0e372a5c-715c-4a50-b90c-ff774fec23f8",
        "capture_token": "c9c19a22-b3b9-6b0b-c295-ab41c898f41c",
        "resume": {
            "_id": "5a29b1266867b6000fe42a4b",
            "card_number": {
                "panLast4": 1111,
                "panFirst6": 411111
            },
            "authorizations": {
                "code": "570110"
            },
            "transaction": {
                "type": "CREDIT",
                "date": "2017-12-07T21:22:46.141Z",
                "currency": "CLP",
                "buy_order": "INPA-50000000916",
                "amount": 4500,
                "installments_number": 0
            },
            "response": {
                "code": 100
            }
        }
    }
}
```
{{% /expand%}}

Posibles estados de la transacción:

| State    | Definición                               |
| -------- | ---------------------------------------- |
| paid  | El cargo fue realizado exitosamente en la cuenta del cliente |
| canceled | El cargo no fue realizado |
| reversed | Tiene al menos una devolución asociada |

Además, agregamos información específica del código entregado por el Gateway CyberSource (Estructura resume del JSON de respuesta).

{{%expand "CLIC AQUÍ PARA VER LOS REASON CODES DE CYBERSOURCE" %}}

| Reason Code | Description                              |
| ----------- | ---------------------------------------- |
| 100         | Successful transaction. If ccAuthReply_processorResponse is 08, you can accept the transaction if the customer provides you with identification. |
| 101         | The request is missing one or more required fields. Possible action: see the reply fields missingField_0 through missingField_Nfor which fields are missing. Resend the request with the complete information. For information about missing or invalid fields. |
| 102         | One or more fields in the request contains invalid data. Possible action: see the reply fields invalidField_0 through invalidField_N for which fields are invalid. Resend the request with the correct information. For information about missing or invalid fields. |
| 104         | The merchant reference code for this authorization request matches the merchant reference code of another authorization request that you sent within the past 15 minutes.Possible action: Resend the request with a unique merchant reference code. |
| 110         | Only a partial amount was approved.      |
| 150         | General system failure.See the documentation for your CyberSource client for information about handling retries in the case of system errors. |
| 151         | The request was received but there was a server timeout. This error does not include timeouts between the client and the server. Possible action: To avoid duplicating the transaction, do not resend the request until you have reviewed the transaction status in the Business Center. |
| 152         | The request was received, but a service did not finish running in time.Possible action: To avoid duplicating the transaction, do not resend the request until you have reviewed the transaction status in the Business Center. |
| 200         | The authorization request was approved by the issuing bank but declined by CyberSource because it did not pass the Address Verification System (AVS) check. Possible action: You can capture the authorization, but consider reviewing the order for the possibility of fraud. |
| 201         | The issuing bank has questions about the request. You do not receive an authorization code programmatically, but you might receive one verbally by calling the processor.Possible action: Call your processor to possibly receive a verbal authorization. For contact phone numbers, refer to your merchant bank information. |
| 202         | Expired card. You might also receive this value if the expiration date you provided does not match the date the issuing bank has on file. Possible action: Request a different card or other form of payment. |
| 203         | General decline of the card. No other information was provided by the issuing bank. Possible action: Request a different card or other form of payment. |
| 204)        | Insufficient funds in the account. Possible action: Request a different card or other form of payment. |
| 205         | Stolen or lost card. Possible action: Review this transaction manually to ensure that you submitted the correct information. |
| 207         | Issuing bank unavailable. Possible action: Wait a few minutes and resend the request. |
| 208         | Inactive card or card not authorized for card-not-present transactions.Possible action: Request a different card or other form of payment. |
| 209         | CVN did not match. Possible action: Request a different card or other form of payment. |
| 210         | The card has reached the credit limit.Possible action: Request a different card or other form of payment. |
| 211         | Invalid CVN. Possible action: Request a different card or other form of payment. |
| 221         | The customer matched an entry on the processor’s negative file. Possible action: Review the order and contact the payment processor. |
| 230         | The authorization request was approved by the issuing bank but declined by CyberSource because it did not pass the CVN check. Possible action: You can capture the authorization, but consider reviewing the order for the possibility of fraud. |
| 231         | Invalid account number. Possible action: Request a different card or other form of payment. |
| 232         | The card type is not accepted by the payment processor. Possible action: Contact your merchant bank to confirm that your account is set up to receive the card in question. |
| 233         | General decline by the processor. Possible action: Request a different card or other form of payment. |
| 234         | There is a problem with the information in your CyberSource account. Possible action: Do not resend the request. |
| 235         | The requested capture amount exceeds the originally authorized amount. Possible action: Issue a new authorization and capture request for the new amount. |
| 236         | Processor failure. Possible action: Wait a few minutes and resend the request. |
| 237         | The authorization has already been reversed. Possible action: No action required. |
| 238         | The authorization has already been captured. Possible action: No action required. |
| 239         | The requested transaction amount must match the previous transaction amount.Possible action: Correct the amount and resend the request. |
| 240         | The card type sent is invalid or does not correlate with the credit card number.Possible action: Confirm that the card type correlates with the credit card number specified in the request, then resend the request. |
| 241         | The request ID is invalid. Possible action: Request a new authorization, and if successful, proceed with the capture. |
| 242         | You requested a capture, but there is no corresponding, unused authorization record. Occurs if there was not a previously successful authorization request or if the previously successful authorization has already been used by another capture request. Possible action: Request a new authorization, and if successful, proceed with the capture. |
| 243         | The transaction has already been settled or reversed. Possible action: No action required. |
| 246         | One of the following: The capture or credit is not voidable because the capture or credit information has already been submitted to your processor. You requested a void for a type of transaction that cannot be voided. Possible action: No action required. |
| 247         | You requested a credit for a capture that was previously voided. Possible action: No action required. |
| 250         | The request was received, but there was a timeout at the payment processor. Possible action: To avoid duplicating the transaction, do not resend the request until you have reviewed the transaction status in the Business Center. |
| 254         | Stand-alone credits are not allowed. Possible action: Submit a follow-on credit by including a request ID in the credit request. A follow-on credit must be requested within 60 days of the authorization. To process stand-alone credits, contact your CyberSource account representative to find out if your processor supports stand-alone credits. |
{{% /expand%}}


Si deseas hacer la devolución al cliente, debes llamar a [API de Anulación].

