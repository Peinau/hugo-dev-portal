---
title: "3. APIs Checkout"
description: ""
weight: 10
---

{{<mermaid align="left">}}
graph LR;
    A{APIs Checkout}
    A --> B[Split Checkout /(captura de tarjeta + pago)]
    A --> C[Express Checkout]
    C --> D[Credit]
    C --> E[Debit checkout con Webpay Plus]
{{< /mermaid >}}

