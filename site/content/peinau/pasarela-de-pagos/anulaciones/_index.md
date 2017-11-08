---
title: "API REST de Anulaciones"
description: ""
weight: 20
---

Utilizando el **access_token** obtenido en la **Autenticación** y el **id (Token de la tarjeta)** generado en la **Intención de captura**, debes ejecutar una petición a la **API de Anulación /reverse** de la siguiente forma:

```
 curl -v -X POST 'https://quickpay-connect-checkout.azurewebsites.net/payments/gateways/quickpay/token/{Token_de_tarjeta}/reverse' \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer access_token"
```

[Volver al menú anterior]({{%relref "api-tokenizacion-pago/_index.md"%}})

