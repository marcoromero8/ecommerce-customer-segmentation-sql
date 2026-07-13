# E-commerce Customer Segmentation & Data Automation (SQL)

Este repositorio contiene un proyecto práctico desarrollado en **SQL** enfocado en el diseño de bases de datos relacionales y la automatización de consultas lógicas para la segmentación y limpieza de audiencias en plataformas de producción.

## Objetivo del Proyecto
Demostrar habilidades en el manejo, limpieza, filtrado y segmentación de bases de datos transaccionales, aplicando buenas prácticas de desarrollo para asegurar la consistencia y la **integridad de los datos** en sistemas automatizados.

## Arquitectura de Datos

El script `automation_query.sql` estructura tres tablas esenciales dentro de un modelo relacional de negocio:

1. **`De_Subscribers`:** Repositorio maestro con la información de los contactos y su estado de suscripción (`Active`, `Unsubscribed`, `Bounced`).
2. **`De_Purchase_History`:** Tabla transaccional relacional que registra el comportamiento de compra histórico de los usuarios por categorías.
3. **`De_VIP_Tech_Campaign`:** La tabla destino limpia y segmentada que almacena la audiencia final apta para ser consumida por herramientas automatizadas de retención o flujos de comunicación.

## Lógica Técnica y Aplicación de "Ojo Clínico"

La consulta principal del proyecto demuestra el dominio de conceptos lógicos y técnicos avanzados mediante los siguientes enfoques:

* **Data Cleaning (Limpieza de Datos):** Uso de funciones como `TRIM()` y `LOWER()` para corregir e invalidar errores de formato generados en la captura de formularios web (espacios en blanco inconscientes o inconsistencia de mayúsculas).
* **Data Integrity & Suppression Rules:** Aplicación de filtros relacionales estrictos (`WHERE s.Status = 'Active'`) que garantizan que el sistema no procese registros con rebotes o bajas comerciales activas.
* **Segmentación Avanzada (Business Logic):** Uso óptimo de operaciones de agregación (`SUM`, `GROUP BY`) combinadas con la cláusula **`HAVING`** para extraer únicamente a los usuarios de alto valor (compras mayores o iguales a $3,000 en categorías específicas).

## Tecnologías Utilizadas
* **SQL (Structured Query Language):** DDL para diseño de estructuras y DML para manipulación de registros.
* **Lógica de Modelado Relacional:** Uso de Llaves Primarias e indexación a través de uniones relacionales de tipo `INNER JOIN`.
