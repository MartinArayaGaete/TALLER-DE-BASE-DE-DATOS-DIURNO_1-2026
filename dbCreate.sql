CREATE TABLE IF NOT EXISTS Tipo_Documento (
  id_tipo_documento BIGINT PRIMARY KEY,
  tipo VARCHAR(80),
);

CREATE TABLE IF NOT EXISTS Comuna (
  id_comuna BIGINT PRIMARY KEY,
  nombre_comuna VARCHAR(255),
);

CREATE TABLE IF NOT EXISTS Sueldo (
  id_sueldo BIGINT PRIMARY KEY,
  sueldo DECIMAL(10,2),
  cargo VARCHAR(80),
);

CREATE TABLE IF NOT EXISTS Producto (
  id_producto BIGINT PRIMARY KEY,
  nombre_producto VARCHAR(255),
  precio BIGINT,
);

CREATE TABLE IF NOT EXISTS Tienda (
  id_tienda BIGINT PRIMARY KEY,
  id_comuna BIGINT,
  nombre_tienda VARCHAR(255),
  direccion_tienda VARCHAR(255),
  FOREIGN KEY (id_comuna) REFERENCES Comuna(id_comuna)
);

CREATE TABLE IF NOT EXISTS Empleado (
  id_empleado BIGINT PRIMARY KEY,
  id_sueldo BIGINT, 
  id_comuna BIGINT, 
  id_tienda BIGINT,
  nombre_empleado VARCHAR(80),
  FOREIGN KEY (id_sueldo) REFERENCES Sueldo(id_sueldo),
  FOREIGN KEY (id_comuna) REFERENCES Comuna(id_comuna),
  FOREIGN KEY (id_tienda) REFERENCES Tienda(id_tienda)
);

CREATE TABLE IF NOT EXISTS Vendedor (
  id_vendedor BIGINT PRIMARY KEY,
  id_empleado BIGINT,
  nombre_vendedor VARCHAR(80),
  FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

CREATE TABLE IF NOT EXISTS Venta (
  id_venta BIGINT PRIMARY KEY,
  id_vendedor BIGINT,
  id_tienda BIGINT,
  id_tipo_documento BIGINT,
  fecha DATE,
  FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor),
  FOREIGN KEY (id_tienda) REFERENCES Tienda(id_tienda),
  FOREIGN KEY (id_tipo_documento) REFERENCES Tipo_Documento(id_tipo_documento)
);

CREATE TABLE IF NOT EXISTS Producto_Venta (
  id_producto_venta BIGINT PRIMARY KEY,
  id_producto BIGINT,
  id_venta BIGINT,
  cantidad INT,
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
  FOREIGN KEY (id_venta) REFERENCES Venta(id_venta)
);

CREATE TABLE IF NOT EXISTS Producto_Tienda (
  id_producto_tienda BIGINT PRIMARY KEY,
  id_producto BIGINT,
  id_tienda BIGINT,
  stock INT,
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
  FOREIGN KEY (id_tienda) REFERENCES Tienda(id_tienda)
);