---
title: "2. ¿Cómo integrar nuestra pasarela de pagos?"
description: ""
weight: 10
---

Te ofrecemos diversas opciones de integración para que puedas adaptar nuestro producto a las necesidades de tu negocio.

{{<mermaid align="left">}}
graph LR;
    A((Comercio))
    A --> B{APIs Checkout}
    A --> C{SDKs}
    A --> D{Plugins}
    B --> E[Split Checkout]
    B --> F[Credit Express Checkout]
    B --> G[Debit Checkout con Webpay plus]
    D --> H[Prestashop]
    D --> I[VTEX]
    D --> J[WooCommerce]

{{< /mermaid >}}    

