INSERT INTO Tipo_Doc (id_tipo_doc, tipo) VALUES
(1, 'Boleta'),
(2, 'Factura'),
(3, 'Crédito');

INSERT INTO Comuna (id_comuna, nombre_comuna) VALUES
(1, 'Santiago'),
(2, 'Providencia'),
(3, 'Las Condes'),
(4, 'La Florida'),
(5, 'Maipú');

INSERT INTO Sueldo (id_sueldo, sueldo, cargo) VALUES
(1, 550000.00, 'Reponedor'),
(2, 600000.00, 'Vendedor'),
(3, 700000.00, 'Supervisor'),
(4, 800000.00, 'Administrador'),
(5, 1000000.00, 'Gerente');

INSERT INTO Producto (id_producto, nombre_producto, precio, stock) VALUES
(1, 'Laptop', 800000, 10),
(2, 'Mouse', 15000, 50),
(3, 'Teclado', 30000, 30),
(4, 'Monitor', 200000, 20),
(5, 'Impresora', 120000, 15),
(6, 'Audifonos', 25000, 40),
(7, 'Parlantes', 45000, 25),
(8, 'Webcam', 35000, 18);

INSERT INTO Tienda (id_tienda, nombre_tienda, direccion, id_comuna) VALUES
(1, 'TecnoShop', 'Av. Providencia 1234', 2),
(2, 'ElectroMarket', 'Av. Apoquindo 5678', 3),
(3, 'Zona Tech', 'Mall Plaza Vespucio', 4);

INSERT INTO Empleado (id_empleado, nombre_empleado, id_sueldo, id_comuna, id_tienda) VALUES
(1, 'Juan Pérez', 2, 1, 1),
(2, 'María González', 2, 2, 1),
(3, 'Carlos Soto', 3, 5, 2),
(4, 'Ana Muñoz', 1, 4, 3),
(5, 'Luis Rojas', 4, 3, 2),
(6, 'Camila Torres', 2, 2, 3);

INSERT INTO Vendedor (id_vendedor, id_empleado) VALUES
(1, 1),
(2, 2),
(3, 6);

INSERT INTO Venta (id_venta, fecha, monto_total, id_vendedor, id_tienda, id_tipo_doc) VALUES
-- 2020
(1, '2020-10-15', 150000.00, 1, 1, 1),
(2, '2020-11-20', 300000.00, 2, 1, 2),
(3, '2020-12-05', 45000.00, 3, 3, 1),

-- 2021 (todos los meses)
(4, '2021-01-10', 830000.00, 1, 1, 1),
(5, '2021-02-12', 120000.00, 2, 1, 2),
(6, '2021-03-08', 60000.00, 3, 3, 1),
(7, '2021-04-18', 200000.00, 1, 1, 2),
(8, '2021-05-22', 75000.00, 2, 1, 1),
(9, '2021-06-14', 90000.00, 3, 3, 2),
(10, '2021-07-30', 300000.00, 1, 1, 1),
(11, '2021-08-05', 45000.00, 2, 1, 2),
(12, '2021-09-11', 250000.00, 3, 3, 1),
(13, '2021-10-19', 100000.00, 1, 1, 2),
(14, '2021-11-25', 180000.00, 2, 1, 1),
(15, '2021-12-31', 500000.00, 3, 3, 2);

INSERT INTO Prod_Venta (id_prod_venta, id_producto, id_venta, cantidad) VALUES
-- Venta 1 (2020)
(1, 2, 1, 2),
(2, 3, 1, 1),

-- Venta 2
(3, 1, 2, 1),

-- Venta 3
(4, 7, 3, 1),

-- Venta 4
(5, 1, 4, 1),
(6, 2, 4, 2),

-- Venta 5
(7, 5, 5, 1),

-- Venta 6
(8, 3, 6, 2),

-- Venta 7
(9, 4, 7, 1),

-- Venta 8
(10, 6, 8, 3),

-- Venta 9
(11, 8, 9, 2),

-- Venta 10
(12, 1, 10, 1),

-- Venta 11
(13, 2, 11, 1),

-- Venta 12
(14, 4, 12, 1),

-- Venta 13
(15, 3, 13, 2),

-- Venta 14
(16, 5, 14, 1),

-- Venta 15
(17, 1, 15, 1);

