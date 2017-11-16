---
title: "Introducción"
description: ""
weight: 10
---

Peinau es una plataforma de pagos... blah

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