/*TABLAS*/

/*
Tipo_Doc(id_tipo,tipo)
Producto (id_producto, nombre_producto, precio, stock, campo)
Comuna (id_comuna, nombre_comuna)
Sueldo (id_sueldo, sueldo, cargo)
Tienda (id_tienda, nombre_tienda, direccion)
Empleado(id_empleado,nombre_empleado,id_sueldo,id_comuna)
Vendedor(id_vendedor,nombre,id_empleado)
Venta(id_venta,fecha,monto_total,id_vendedor,id_tienda,id_tipo_doc)
Prod_Venta(id_prod_venta,id_producto,id_venta)
*/

/* 1. Producto Mas vendido por mes el 2021 */
SELECT mes, nombre_producto, total_vendido
FROM (
    SELECT 
        EXTRACT(MONTH FROM v.fecha) AS mes,
        p.nombre_producto,
        COUNT(*) AS total_vendido,
        ROW_NUMBER() OVER (
            PARTITION BY EXTRACT(MONTH FROM v.fecha)
            ORDER BY COUNT(*) DESC
        ) AS ranking
    FROM Venta v
    JOIN Prod_Venta pv ON v.id_venta = pv.id_venta
    JOIN Producto p ON pv.id_producto = p.product_id << IA la wea
    WHERE EXTRACT(YEAR FROM v.fecha) = 2021
    GROUP BY mes, p.nombre_producto
) t
WHERE ranking = 1;/*aqui filtramos la tabla */


/* 2. Producto mas economico por tienda */

/* 3. Ventas por mes, separadas entre Boletas y Facturas */
SELECT DATE_TRUNC('month', Venta.fecha), Tipo_Documento.tipo, COUNT(*) AS cantidad_ventas
FROM Venta
INNER JOIN Tipo_Documento ON Venta.id_tipo_documento = Tipo_Documento.id_tipo_documento
WHERE Tipo_Documento.tipo = 'Boleta' OR Tipo_Documento.tipo = 'Factura'
GROUP BY DATE_TRUNC('month', Venta.fecha), Tipo_Documento.tipo
ORDER BY DATE_TRUNC('month', Venta.fecha), Tipo_documento.tipo;


/* 4. Empleado que gano mas por tienda en 2020, indicando la comuna
      donde vive y el cargo que tiene en la empresa */

/* 5. La tienda que tiene menos empleados */

/* 6. El vendedor con mas ventas por mes */
WITH ventas_por_vendedor AS (
    SELECT 
        v.id_vendedor,
        e.nombre_empleado,
        EXTRACT(YEAR FROM ve.fecha) AS anio,
        EXTRACT(MONTH FROM ve.fecha) AS mes,
        COUNT(*) AS cantidad_ventas
    FROM venta ve
    JOIN vendedor v ON ve.id_vendedor = v.id_vendedor
    JOIN empleado e ON v.id_empleado = e.id_empleado
    GROUP BY v.id_vendedor, e.nombre_empleado, anio, mes
),

maximos AS (
    SELECT 
        anio,
        mes,
        MAX(cantidad_ventas) AS max_ventas
    FROM ventas_por_vendedor
    GROUP BY anio, mes
)

SELECT 
    vp.anio,
    vp.mes,
    vp.id_vendedor,
    vp.nombre_empleado,
    vp.cantidad_ventas
FROM ventas_por_vendedor vp
JOIN maximos m 
    ON vp.anio = m.anio 
   AND vp.mes = m.mes 
   AND vp.cantidad_ventas = m.max_ventas
ORDER BY vp.anio, vp.mes;

/* 7. El vendedor que ha recaudado mas dinero para la tienda por año */


/* 8. El vendedor con mas productos vendidos por tienda */

/* 9. El empleado con mayor sueldo por mes */

/* 10. La tienda con menor recaudacion por mes */
WITH recaudacion_mensual AS (
    SELECT 
        ti.id_tienda,
        ti.nombre_tienda,
        EXTRACT(YEAR FROM v.fecha) AS anio,
        EXTRACT(MONTH FROM v.fecha) AS mes,
        SUM(pv.cantidad * p.precio) AS total_recaudado
    FROM venta v
    JOIN tienda ti ON v.id_tienda = ti.id_tienda
    JOIN producto_venta pv ON v.id_venta = pv.id_venta
    JOIN producto p ON pv.id_producto = p.id_producto
    GROUP BY ti.id_tienda, ti.nombre_tienda, anio, mes
),

minimos AS (
    SELECT 
        anio,
        mes,
        MIN(total_recaudado) AS menor_recaudacion
    FROM recaudacion_mensual
    GROUP BY anio, mes
)

SELECT 
    r.anio,
    r.mes,
    r.nombre_tienda,
    r.total_recaudado
FROM recaudacion_mensual r
JOIN minimos m 
    ON r.anio = m.anio 
   AND r.mes = m.mes 
   AND r.total_recaudado = m.menor_recaudacion
ORDER BY r.anio, r.mes;