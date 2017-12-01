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
    
Te ofrecemos diversas opciones de integración para que puedas adaptar nuestro producto a las necesidades de tu negocio.
