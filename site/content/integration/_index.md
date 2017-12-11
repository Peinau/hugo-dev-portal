---
title: "¿Cómo integrar nuestra pasarela de pagos?"
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
    B --> E[Captura de Tarjeta + Checkout]
    B --> F[Express Checkout]
    D --> G[Prestashop]
    D --> H[vtex]
    D --> I[woocommerce]
    F --> J[Credit]
    F --> K[Debit Checkout con Webpay plus]
    
    click E "{{%relref "introduction/captura-tarjeta-checkout.md"%}}" "This is a link"
    click K "(transbank-webpay/introduction.md)" "This is a link"
    style J fill:#ccf,stroke:#f66,stroke-width:2px,stroke-dasharray: 5, 5
    style K fill:#ccf,stroke:#f66,stroke-width:2px,stroke-dasharray: 5, 5
{{< /mermaid >}}    

### APIs Checkout
  - [Split Checkout (captura de tarjeta + pago)]({{%relref "introduction/captura-tarjeta-checkout.md"%}})
  - Express Checkout
    - Credit
    - [Debit Checkout con Webpay plus](transbank-webpay/introduction.md)
  
### SDKs
  - [SDK Javascript](https://github.com/Peinau/peinau-javascript/blob/master/README.md)
  
### Plugins
  - [Prestashop](https://github.com/Peinau/peinau-plugin-prestashop/blob/master/README.md)
  - [VTEX]
  - [WooCommerce]
