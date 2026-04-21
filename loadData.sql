INSERT INTO comuna (id_comuna, nombre_comuna) VALUES
(1, 'La Cisterna'),
(2, 'Santiago Centro'),
(3, 'Providencia'),
(4, 'San Miguel');

INSERT INTO tipo_documento (id_tipo_documento, tipo) VALUES
(1, 'Boleta'),
(2, 'Factura');

INSERT INTO tienda (id_tienda, id_comuna, nombre_tienda, direccion_tienda) VALUES
(101, 2, 'ElectroCentro Sur', 'Alameda 1234'),
(102, 1, 'TecnoCisterna', 'Gran Avenida 8000'),
(103, 3, 'ProviTech', 'Av. Providencia 500');


INSERT INTO empleado (id_empleado, id_tienda, id_comuna, nombre_empleado, cargo) VALUES
(1, 101, 4, 'Juan Perez', 'Vendedor'),
(2, 101, 2, 'Ana Gomez', 'Jefe de Tienda'),
(3, 102, 1, 'Luis Rojas', 'Vendedor'),
(4, 103, 3, 'Maria Silva', 'Vendedor Senior'),
(5, 102, 1, 'Carlos Soto', 'Vendedor Part-Time');


INSERT INTO sueldo (id_sueldo, id_empleado, monto_sueldo, fecha_pago) VALUES
(1, 1, 450000.00, '2020-05-30'), 
(2, 2, 650000.00, '2020-05-30'), 
(3, 3, 500000.00, '2021-08-30'), 
(4, 4, 800000.00, '2021-08-30'), 
(5, 5, 450000.00, '2020-12-30'); 


INSERT INTO vendedor (id_vendedor, id_empleado) VALUES
(201, 1),
(202, 3),
(203, 4),
(204, 5);


INSERT INTO producto (id_producto, id_tienda, nombre_producto, precio, stock) VALUES
(301, 101, 'Mouse Inalambrico', 15000, 50),
(302, 101, 'Teclado Mecanico', 45000, 30),
(303, 102, 'Monitor 24 pulgadas', 120000, 15),
(304, 102, 'Cable HDMI', 5000, 100),
(305, 103, 'Notebook Gamer', 850000, 5),
(306, 103, 'Pendrive 64GB', 8000, 80);


INSERT INTO venta (id_venta, id_vendedor, id_tienda, id_tipo_documento, fecha) VALUES
(401, 201, 101, 1, '2021-03-15'),
(402, 201, 101, 2, '2021-03-20'),
(403, 202, 102, 1, '2020-07-10'),
(404, 202, 102, 2, '2021-11-05'),
(405, 203, 103, 1, '2021-03-18'),
(406, 204, 102, 1, '2020-12-24');


INSERT INTO producto_venta (id_producto_venta, id_producto, id_venta, cantidad) VALUES
(501, 301, 401, 2),
(502, 302, 401, 1),
(503, 301, 402, 10),
(504, 304, 403, 5),
(505, 303, 404, 2),
(506, 305, 405, 1),
(507, 306, 405, 3),
(508, 304, 406, 1);