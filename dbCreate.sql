
CREATE TABLE comuna (
  id_comuna BIGINT PRIMARY KEY,
  nombre_comuna VARCHAR(255) NOT NULL
);

CREATE TABLE tipo_documento (
  id_tipo_documento BIGINT PRIMARY KEY,
  tipo VARCHAR(80) NOT NULL
);

CREATE TABLE tienda (
  id_tienda BIGINT PRIMARY KEY,
  id_comuna BIGINT NOT NULL,
  nombre_tienda VARCHAR(80) NOT NULL,
  direccion_tienda VARCHAR(255),
  FOREIGN KEY (id_comuna) REFERENCES comuna(id_comuna)
);

CREATE TABLE empleado (
  id_empleado BIGINT PRIMARY KEY,
  id_tienda BIGINT NOT NULL,
  id_comuna BIGINT NOT NULL,
  nombre_empleado VARCHAR(80) NOT NULL,
  cargo VARCHAR(80) NOT NULL,
  FOREIGN KEY (id_tienda) REFERENCES tienda(id_tienda),
  FOREIGN KEY (id_comuna) REFERENCES comuna(id_comuna)
);

CREATE TABLE producto (
  id_producto BIGINT PRIMARY KEY,
  id_tienda BIGINT NOT NULL,
  nombre_producto VARCHAR(255) NOT NULL,
  precio INT NOT NULL,
  stock INT NOT NULL,
  FOREIGN KEY (id_tienda) REFERENCES tienda(id_tienda)
);

CREATE TABLE sueldo (
  id_sueldo BIGINT PRIMARY KEY,
  id_empleado BIGINT NOT NULL,
  monto_sueldo DECIMAL(10,2) NOT NULL,
  fecha_pago DATE NOT NULL,
  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE vendedor (
  id_vendedor BIGINT PRIMARY KEY,
  id_empleado BIGINT NOT NULL UNIQUE,
  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE venta (
  id_venta BIGINT PRIMARY KEY,
  id_vendedor BIGINT NOT NULL,
  id_tienda BIGINT NOT NULL,
  id_tipo_documento BIGINT NOT NULL,
  fecha DATE NOT NULL,
  FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor),
  FOREIGN KEY (id_tienda) REFERENCES tienda(id_tienda),
  FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documento(id_tipo_documento)
);

CREATE TABLE producto_venta (
  id_producto_venta BIGINT PRIMARY KEY,
  id_producto BIGINT NOT NULL,
  id_venta BIGINT NOT NULL,
  cantidad INT NOT NULL,
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
  FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
);