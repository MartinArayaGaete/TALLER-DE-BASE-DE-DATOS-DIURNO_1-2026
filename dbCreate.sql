CREATE TABLE IF NOT EXISTS Tipo_Doc (
  id_tipo_doc BIGINT,
  tipo VARCHAR(80),
  PRIMARY KEY (id_tipo_doc)
);

CREATE TABLE IF NOT EXISTS Comuna (
  id_comuna BIGINT,
  nombre_comuna VARCHAR(80),
  PRIMARY KEY (id_comuna)
);

CREATE TABLE IF NOT EXISTS Sueldo (
  id_sueldo BIGINT,
  sueldo DECIMAL(10,2),
  cargo VARCHAR(80),
  PRIMARY KEY (id_sueldo)
);

CREATE TABLE IF NOT EXISTS Producto (
  id_producto BIGINT,
  nombre_producto VARCHAR(80),
  precio INT,
  stock INT,
  PRIMARY KEY (id_producto)
);

CREATE TABLE IF NOT EXISTS Tienda (
  id_tienda BIGINT,
  nombre_tienda VARCHAR(80),
  direccion VARCHAR(80),
  PRIMARY KEY (id_tienda)
);

CREATE TABLE IF NOT EXISTS Empleado (
  id_empleado BIGINT,
  nombre_empleado VARCHAR(80),
  id_sueldo BIGINT, 
  id_comuna BIGINT, 
  id_tienda BIGINT,
  PRIMARY KEY (id_empleado),
  FOREIGN KEY (id_sueldo) REFERENCES Sueldo(id_sueldo),
  FOREIGN KEY (id_comuna) REFERENCES Comuna(id_comuna),
  FOREIGN KEY (id_tienda) REFERENCES Tienda(id_tienda)
);

CREATE TABLE IF NOT EXISTS Vendedor (
  id_vendedor BIGINT,
  id_empleado BIGINT, 
  PRIMARY KEY (id_vendedor),
  FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

CREATE TABLE IF NOT EXISTS Venta (
  id_venta BIGINT,
  fecha DATE,
  monto_total DECIMAL(10,2),
  id_vendedor BIGINT,
  id_tienda BIGINT,
  id_tipo_doc BIGINT,
  PRIMARY KEY (id_venta),
  FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor),
  FOREIGN KEY (id_tienda) REFERENCES Tienda(id_tienda),
  FOREIGN KEY (id_tipo_doc) REFERENCES Tipo_Doc(id_tipo_doc)
);

CREATE TABLE IF NOT EXISTS Prod_Venta (
  id_prod_venta BIGINT,
  id_producto BIGINT,
  id_venta BIGINT,
  cantidad INT,
  PRIMARY KEY (id_prod_venta),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
  FOREIGN KEY (id_venta) REFERENCES Venta(id_venta)
);