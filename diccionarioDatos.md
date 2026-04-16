# Diccionario de Datos - Base de Datos de Ventas

## 1. Tabla: Tipo_Documento

**Descripción:** Esta tabla permite distinguir el tipo de documento a emitir.

| Campo | Tipo | Restricción | Descripción |
|-------|------|------------|-------------|
| id_tipo_documento | BIGINT | PRIMARY KEY | Identificador único del tipo de documento |
| tipo | VARCHAR(80) | NOT NULL | Nombre del tipo de documento (Boleta, Factura, Crédito) |

---

## 2. Tabla: Comuna
| Campo | Tipo | Restricción | Descripción |
|-------|------|------------|-------------|
| id_comuna | BIGINT | PRIMARY KEY | Identificador único de la comuna |
| nombre_comuna | VARCHAR(80) | NOT NULL | Nombre de la comuna |

---

## 3. Tabla: Sueldo
| Campo | Tipo | Restricción | Descripción |
|-------|------|------------|-------------|
| id_sueldo | BIGINT | PRIMARY KEY | Identificador único del registro de sueldo |
| sueldo | DECIMAL(10,2) | NOT NULL | Monto del sueldo |
| cargo | VARCHAR(80) | NOT NULL | Cargo o posición del empleado |

---

## 4. Tabla: Producto
| Campo | Tipo | Restricción | Descripción |
|-------|------|------------|-------------|
| id_producto | BIGINT | PRIMARY KEY | Identificador único del producto |
| nombre_producto | VARCHAR(80) | NOT NULL | Nombre del producto |
| precio | INT | NOT NULL | Precio unitario del producto |

---

## 5. Tabla: Tienda
| Campo | Tipo | Restricción | Descripción |
|-------|------|------------|-------------|
| id_tienda | BIGINT | PRIMARY KEY | Identificador único de la tienda |
| id_comuna | BIGINT | FOREIGN KEY | Referencia a la tabla Comuna |
| nombre_tienda | VARCHAR(80) | NOT NULL | Nombre de la tienda |
| direccion | VARCHAR(80) | NOT NULL | Dirección física de la tienda |

---

## 6. Tabla: Empleado
| Campo | Tipo | Restricción | Descripción |
|-------|------|------------|-------------|
| id_empleado | BIGINT | PRIMARY KEY | Identificador único del empleado |
| id_sueldo | BIGINT | FOREIGN KEY | Referencia a la tabla Sueldo |
| id_comuna | BIGINT | FOREIGN KEY | Referencia a la tabla Comuna |
| id_tienda | BIGINT | FOREIGN KEY | Referencia a la tabla Tienda |
| nombre_empleado | VARCHAR(80) | NOT NULL | Nombre completo del empleado |

---

## 7. Tabla: Vendedor
| Campo | Tipo | Restricción | Descripción |
|-------|------|------------|-------------|
| id_vendedor | BIGINT | PRIMARY KEY | Identificador único del vendedor |
| id_empleado | BIGINT | FOREIGN KEY | Referencia a la tabla Empleado |
| nombre | VARCHAR(80) | NOT NULL | Nombre del vendedor |


---

## 8. Tabla: Venta
| Campo | Tipo | Restricción | Descripción |
|-------|------|------------|-------------|
| id_venta | BIGINT | PRIMARY KEY | Identificador único de la venta |
| id_vendedor | BIGINT | FOREIGN KEY | Referencia a la tabla Vendedor |
| id_tienda | BIGINT | FOREIGN KEY | Referencia a la tabla Tienda |
| id_tipo_doc | BIGINT | FOREIGN KEY | Referencia a la tabla Tipo_Doc |
| fecha | DATE | NOT NULL | Fecha en que se realizó la venta |
| monto_total | DECIMAL(10,2) | NOT NULL | Monto total de la venta |

---

## 9. Tabla: Producto_Venta

**Descripción:** Esta tabla de asociación permite vincular producto y venta.

| Campo | Tipo | Restricción | Descripción |
|-------|------|------------|-------------|
| id_prod_venta | BIGINT | PRIMARY KEY | Identificador único del registro producto-venta |
| id_producto | BIGINT | FOREIGN KEY | Referencia a la tabla Producto |
| id_venta | BIGINT | FOREIGN KEY | Referencia a la tabla Venta |

---

## 10. Tabla: Producto_Tienda

| Campo | Tipo | Restricción | Descripción |
|-------|------|------------|-------------|
| stock | INT | NOT NULL | Cantidad disponible en inventario |

---

## Relaciones Principales

- **Empleado** → Sueldo (muchos a uno)
- **Empleado** → Comuna (muchos a uno)
- **Empleado** ↔ Tienda (muchos a uno)
- **Vendedor** → Empleado (uno a uno)
- **Venta** → Vendedor (muchos a uno)
- **Venta** → Tienda (muchos a uno)
- **Venta** → Tipo_Doc (muchos a uno)
- **Prod_Venta** → Producto (muchos a uno)
- **Prod_Venta** → Venta (muchos a uno)