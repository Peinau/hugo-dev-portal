---
title: "PEINAU"
description: ""
weight: 10
---

Si quieres integrar un botón de pagos en tu sitio web de forma fácil, rápida y segura, somos tu mejor opción.

Además, utilizando Peinau nunca verás la información sensible de la tarjeta y con ello le daras mas seguridad a tus clientes.

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