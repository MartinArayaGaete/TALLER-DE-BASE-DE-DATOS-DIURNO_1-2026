INSERT INTO Tipo_Doc (id_tipo_doc, tipo) VALUES
(1, 'Boleta'),
(2, 'Factura'),
(3, 'Crédito');

INSERT INTO Producto (id_producto, nombre_producto, precio, stock) VALUES
(1, 'Laptop', 800000, 10),
(2, 'Mouse', 15000, 50),
(3, 'Teclado', 30000, 30),
(4, 'Monitor', 200000, 20),
(5, 'Impresora', 120000, 15),
(6, 'Audifonos', 25000, 40),
(7, 'Parlantes', 45000, 25),
(8, 'Webcam', 35000, 18),
(9, 'Disco Duro', 90000, 12),
(10, 'Memoria USB', 10000, 60),
(11, 'Silla Gamer', 150000, 8),
(12, 'Escritorio', 100000, 5),
(13, 'Smartphone', 500000, 22),
(14, 'Cargador', 12000, 35);

INSERT INTO Comuna (id_comuna, nombre_comuna) VALUES
(1, 'Santiago'), (2, 'Cerrillos'), (3, 'Cerro Navia'), (4, 'Conchalí'),
(5, 'El Bosque'), (6, 'Estación Central'), (7, 'Huechuraba'), (8, 'Independencia'),
(9, 'La Cisterna'), (10, 'La Florida'), (11, 'La Granja'), (12, 'La Pintana'),
(13, 'La Reina'), (14, 'Las Condes'), (15, 'Lo Barnechea'), (16, 'Lo Espejo'),
(17, 'Lo Prado'), (18, 'Macul'), (19, 'Maipú'), (20, 'Ñuñoa'),
(21, 'Pedro Aguirre Cerda'), (22, 'Peñalolén'), (23, 'Providencia'), (24, 'Puente Alto'),
(25, 'Quilicura'), (26, 'Quinta Normal'), (27, 'Recoleta'), (28, 'Renca'),
(29, 'San Bernardo'), (30, 'San Joaquín'), (31, 'San Miguel'), (32, 'San Ramón'),
(33, 'Vitacura'), (34, 'Buin'), (35, 'Calera de Tango'), (36, 'Paine'),
(37, 'Melipilla'), (38, 'Alhué'), (39, 'Curacaví'), (40, 'María Pinto'),
(41, 'San Pedro'), (42, 'Talagante'), (43, 'El Monte'), (44, 'Isla de Maipo'),
(45, 'Padre Hurtado'), (46, 'Peñaflor');

INSERT INTO Sueldo (id_sueldo, sueldo, cargo) VALUES
(1, 550000.00, 'Reponedor'),
(2, 520000.00, 'Vendedor'),
(3, 600000.00, 'Encargado de Bodega'),
(4, 700000.00, 'Administrador de Tienda'),
(5, 900000.00, 'Gerente de Tienda');

INSERT INTO Tienda (id_tienda, nombre_tienda, direccion) VALUES
(1, 'TecnoShop', 'Av. Providencia 1234, Santiago'),
(2, 'ElectroMarket', 'Av. Apoquindo 5678, Las Condes'),
(3, 'Casa Digital', 'Calle Estado 234, Santiago Centro'),
(4, 'Zona Tech', 'Mall Plaza Vespucio, La Florida'),
(5, 'Mundo Electrónico', 'Av. Independencia 3456, Independencia');

INSERT INTO Empleado (id_empleado, nombre_empleado, id_sueldo, id_comuna, id_tienda) VALUES
(1, 'Juan Pérez', 2, 1, 1),
(2, 'María González', 2, 14, 2),
(3, 'Carlos Soto', 3, 19, 3),
(4, 'Ana Muñoz', 1, 10, 3),
(5, 'Luis Rojas', 4, 23, 4),
(6, 'Camila Torres', 2, 20, 5),
(7, 'Pedro Díaz', 5, 33, 5),
(8, 'Sofía Herrera', 1, 24, 5),
(9, 'Diego Martínez', 3, 12, 4),
(10, 'Valentina López', 2, 17, 3);

INSERT INTO Vendedor (id_vendedor, nombre, id_empleado) VALUES
(1, 'Juan Pérez', 1),
(2, 'María González', 2),
(3, 'Camila Torres', 6);

INSERT INTO Venta (id_venta, fecha, monto_total, id_vendedor, id_tienda, id_tipo_doc) VALUES
(1, '2020-04-01', 815000.00, 1, 1, 1),
(2, '2020-04-02', 45000.00, 2, 2, 2),
(3, '2021-09-03', 230000.00, 3, 5, 1), 
(4, '2021-06-04', 120000.00, 1, 1, 3),
(5, '2021-04-05', 510000.00, 2, 2, 2),
(6, '2021-05-01', 122000.00, 2, 2, 2),
(7, '2021-01-02', 300000.00, 3, 5, 1), 
(8, '2021-02-03', 450000.00, 1, 1, 3), 
(9, '2021-07-04', 200000.00, 2, 2, 2), 
(10, '2021-08-05', 150000.00, 3, 5, 1), 
(11, '2021-09-01', 350000.00, 1, 1, 2), 
(12, '2021-10-02', 400000.00, 2, 2, 3), 
(13, '2021-11-03', 250000.00, 3, 5, 1), 
(14, '2021-12-04', 300000.00, 1, 1, 2), 
(15, '2021-03-05', 450000.00, 2, 2, 3); 

INSERT INTO Prod_Venta (id_prod_venta, id_producto, id_venta, cantidad) VALUES
(1, 1, 1, 1), 
(2, 2, 1, 1), 
(3, 7, 2, 1), 
(4, 4, 3, 1), 
(5, 3, 3, 1), 
(6, 5, 4, 1), 
(7, 13, 5, 1), 
(8, 10, 5, 1), 
(9, 12, 6, 1), 
(10, 10, 6, 1), 
(11, 14, 6, 1), 
(12, 4, 7, 1), 
(13, 12, 7, 1), 
(14, 4, 8, 1), 
(15, 11, 8, 1), 
(16, 12, 8, 1), 
(17, 4, 9, 1), 
(18, 11, 10, 1), 
(19, 4, 11, 1), 
(20, 11, 11, 1), 
(21, 4, 12, 1), 
(22, 12, 12, 1), 
(23, 9, 12, 1), 
(24, 10, 12, 1), 
(25, 11, 13, 1), 
(26, 12, 13, 1), 
(27, 4, 14, 1), 
(28, 12, 14, 1), 
(29, 4, 15, 1), 
(30, 11, 15, 1), 
(31, 12, 15, 1);


/*
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
