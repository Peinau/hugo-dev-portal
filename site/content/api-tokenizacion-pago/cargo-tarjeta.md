## 5. ¿Cómo realizar el cargo a la tarjeta?

Te ofrecemos dos opciones para realizar el cargo a la tarjeta del cliente, a continuación podrás ver el detalle de cada una: 

### 5.1 Approval

Si quieres utilizar esta opción, necesitas que el cliente apruebe el pago para ejecutar el cargo a la tarjeta de crédito. Para ello debes desplegar la ventana de aprobación del pago a partir de la [approval_url](https://quickpay-connect-checkout.azurewebsites.net/payments/gateways/quickpay/token/0fdcd938-62c7-aab2-5048-c2f172d495ac/pay) obtenida en el [paso 3](#3-mostrar-formulario-de-captura-de-tarjeta).

![Ejemplo Approval](Portal04.jpg)

Esta ventana permite dos opciones al cliente:

* Aprobar Pago y ejecutar el cargo a la tajeta de crédito
* Cancelar

#### 5.1.1 Aprobar Pago y ejecutar el cargo a la tajeta de crédito

  Si recibes una respuesta con **"state": "paid"** en la URL indicada como **return_url** o consultando desde la **URL self**, entonces el cliente ha aprobado del pago y se ejecuta el cargo a la tajeta de crédito.

  ```
  {
      "intent": "sale",
      "application": "a3be1bc6-438a-c35e-e603-b15f2d30cfb9",
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
                      "price": 500,
                      "tax": 0,
                      "_id": "59e0c580f23884b8cc3aa5c5"
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
          "capture_token": "cda62314-1258-ff27-6a8b-6323955998ce"
      },
      "links": [],
      "id": "79aef545-3dda-dfae-e924-cd1c60eebdd1",
      "create_time": "2017-10-13T13:54:09.156Z",
      "update_time": "2017-10-13T13:54:36.169Z",
      "state": "paid",
      "invoice_number": "INPA-0000000096",
      "gateway": {
          "installments_number": "1",
          "merchantReferenceCode": "INPA-0000000096",
          "requestID": "5079028762296913904009",
          "decision": "ACCEPT",
          "reasonCode": "100",
          "requestToken": "Ahj7/wSTE1Wu9XYbdkGJik/oE2bCnAU/oE2bCnJgbGUcdoZNJMt0gOAvtDAnJiarXersNuyDEgAAahIC",
          "purchaseTotals": {
              "currency": "CLP"
          },
          "ccAuthReply": {
              "reasonCode": "100",
              "amount": "4500",
              "authorizationCode": "570110",
              "avsCode": "1",
              "authorizedDateTime": "2017-10-13T13:54:36Z",
              "processorResponse": "1",
              "paymentNetworkTransactionID": "111222",
              "ownerMerchantID": "falabella",
              "processorTransactionID": "cca1703e27f34fc3bd661c3aaaa080a6"
          },
          "ccCaptureReply": {
              "reasonCode": "100",
              "requestDateTime": "2017-10-13T13:54:36Z",
              "amount": "4500"
          },
          "additionalProcessorResponse": "9d7549aa-3207-4ee3-aff8-f17330a0c4c1",
          "capture_token": "cda62314-1258-ff27-6a8b-6323955998ce"
      }
  }
  ```

#### 5.1.2 Cancelar

  Si recibes una respuesta con **"state": "canceled"** en la URL indicada como **cancel_url** o consultando desde la **URL self**, entonces el cliente ha cancelado el pago.

```
{
  "intent": "sale",
  "application": "a3be1bc6-438a-c35e-e603-b15f2d30cfb9",
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
          "price": 500,
          "tax": 0,
          "_id": "59e0b597f23884b8cc3aa5c3"
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
    "capture_token": "d246ba70-6340-98a3-fbd5-b243a61314a9"
  },
  "links": [
    
  ],
  "id": "9ece98a3-9c64-6f0d-ee12-39e68745017d",
  "create_time": "2017-10-13T12:46:16.497Z",
  "update_time": "2017-10-13T12:47:00.733Z",
  "state": "canceled",
  "invoice_number": "INPA-0000000095",
  "gateway": {
    "message": "user cancel error",
    "amount": 4500,
    "capture_token": "d246ba70-6340-98a3-fbd5-b243a61314a9"
  }
}
```

### 5.2 Silent Charge

Con esta opción, no es requerida la aprobación del cliente para ejecutar el cargo a la tarjeta de crédito.

Necesitas el **access_token** obtenido en la **Autenticación** y el **id (Token de la tarjeta)** generado en la **Intención de captura**, para ejecutar una llamada a la **API de Silent Charge /silent** de la siguiente forma:

```
 curl -v -X POST 'https://api.sandbox.connect.fif.tech/checkout/payments/gateways/quickpay/token/{Token_de_tarjeta}/silent' \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer access_token"
```
[Volver al inicio](../introduction.md)
