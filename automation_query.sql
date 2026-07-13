-- ==============================================================================
-- PROJECT: E-commerce Customer Segmentation & Data Cleaning Automation
-- PURPOSE: Relational database design and advanced SQL queries for behavioral segmenting.
-- AUTHOR: Marco Aurelio Romero Galván
-- ==============================================================================

-- 1. ESTRUCTURA DE LA BASE DE DATOS (TABLAS DE ORIGEN)

-- Tabla maestra de todos los usuarios registrados y su estado de suscripción
CREATE TABLE De_Subscribers (
    SubscriberKey VARCHAR(50) PRIMARY KEY,
    EmailAddress VARCHAR(100) NOT NULL,
    FirstName VARCHAR(50),
    Status VARCHAR(20), -- 'Active', 'Unsubscribed', 'Bounced'
    SignupDate DATE
);

-- Tabla transaccional con el historial de compras de los clientes
CREATE TABLE De_Purchase_History (
    PurchaseID INT PRIMARY KEY,
    SubscriberKey VARCHAR(50),
    ProductCategory VARCHAR(50),
    Amount DECIMAL(10,2),
    PurchaseDate DATE
);

-- 2. TABLA DESTINO PARA AUTOMATIZACIÓN (TARGET AUDIENCE TABLE)
-- Aquí se insertará el resultado final para alimentar las campañas automatizadas
CREATE TABLE De_VIP_Tech_Campaign (
    SubscriberKey VARCHAR(50) PRIMARY KEY,
    EmailAddress VARCHAR(100),
    FirstName VARCHAR(50),
    TotalSpent DECIMAL(10,2),
    SegmentName VARCHAR(30)
);

-- 3. POBLACIÓN DE DATOS DE PRUEBA (CON ERRORES DE FORMATO E INCONSISTENCIAS)
INSERT INTO De_Subscribers VALUES 
('SUB001', 'marco.dev@email.com', 'Marco', 'Active', '2026-01-10'),
('SUB002', '  luis.garcia@email.com ', 'Luis', 'Active', '2026-02-15'), -- ERROR: Espacios en blanco
('SUB003', 'ana.lopez@email.com', 'Ana', 'Unsubscribed', '2026-03-01'), -- EXCLUIR: Usuario dado de baja
('SUB004', 'carlos.t@email.com', 'Carlos', 'Bounced', '2026-04-12');   -- EXCLUIR: Correo con rebote

INSERT INTO De_Purchase_History VALUES 
(101, 'SUB001', 'Technology', 1500.00, '2026-06-01'),
(102, 'SUB001', 'Technology', 2000.00, '2026-07-05'), -- Suma $3500 (Cumple criterio de valor)
(103, 'SUB002', 'Fashion', 500.00, '2026-07-10'),     -- EXCLUIR: Categoría incorrecta
(104, 'SUB003', 'Technology', 4000.00, '2026-07-11'); -- EXCLUIR: Monto correcto pero usuario inactivo

-- 4. PROCESO DE AUTOMATIZACIÓN, LIMPIEZA Y SEGMENTACIÓN AVANZADA
-- Esta consulta limpia formatos, protege la integridad de datos y segmenta clientes de alto valor.
INSERT INTO De_VIP_Tech_Campaign (SubscriberKey, EmailAddress, FirstName, TotalSpent, SegmentName)
SELECT 
    s.SubscriberKey,
    TRIM(LOWER(s.EmailAddress)) AS EmailAddress, -- DATA CLEANING: Elimina espacios y estandariza a minúsculas
    s.FirstName,
    SUM(p.Amount) AS TotalSpent,
    'VIP_Tech_Lovers' AS SegmentName
FROM De_Subscribers s
INNER JOIN De_Purchase_History p ON s.SubscriberKey = p.SubscriberKey
WHERE s.Status = 'Active' -- INTEGRIDAD DE DATOS: Excluye rebotes y usuarios con baja comercial
  AND p.ProductCategory = 'Technology'
GROUP BY s.SubscriberKey, s.EmailAddress, s.FirstName
HAVING SUM(p.Amount) >= 3000.00; -- FILTRO DE AGREGACIÓN: Solo clientes con consumo acumulado >= $3000

-- 5. VERIFICACIÓN DEL RESULTADO
SELECT * FROM De_VIP_Tech_Campaign;
