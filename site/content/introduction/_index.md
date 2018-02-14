---
title: "1. PEINAU"
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
    C --> E[CMR]
    C --> F[Débito Banco Falabella]
    C --> G[Quickpay Token]
    D --> I[Comercio]
    E --> I[Comercio]
    F --> I[Comercio]
    G --> I[Comercio]
{{< /mermaid >}}

---
title: "2. Integracion"
description: ""
weight: 10
---
