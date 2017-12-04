---
title: "PEINAU"
description: ""
weight: 10
---

Si quieres integrar un botón de pagos que te permita controlar el checkout de tu e-commerce de forma fácil, rápida y segura, somos tu mejor opción.

Tu cliente podrá seleccionar los artículos que desea adquirir y al momento del checkout será redirigido a nuestra pasarela.

**FLUJO DE PAGO**

{{<mermaid align="left">}}
graph LR;
    A[Comercio] -->|Proceso de Pago| B(Peinau)
    B --> C{Medio de Pago}
    C --> D[Transbank Webpay]
    C --> E[CMR Crédito]
    C --> F[CMR Debito]
    C --> G[Quickpay Token]
    C --> H[Banco Falabella]
    D --> I[Comercio]
    E --> I[Comercio]
    F --> I[Comercio]
    G --> I[Comercio]
    H --> I[Comercio]
{{< /mermaid >}}

## ¿Cómo integrar nuestra pasarela de pagos?

Te ofrecemos diversas opciones de integración para que puedas adaptar nuestro producto a las necesidades de tu negocio.

### API Checkout
  - [Captura de Tarjeta + Checkout]({{%relref "../captura-tarjeta-checkout.md"%}})
  - 
  - [Debit Checkout con Webpay plus](transbank-webpay/introduction.md)
  
### SDKs
  - [SDK Javascript](https://github.com/Peinau/peinau-javascript/blob/master/README.md)
  
### Plugins
  - [Prestashop](https://github.com/Peinau/peinau-plugin-prestashop/blob/master/README.md)
  - [VTEX]
  - [WooCommerce]
