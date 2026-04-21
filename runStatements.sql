/* 1. Producto Mas vendido por mes el 2021 */

/* Si no hay ventas en el mes x, no se muestra en la lista */
SELECT DISTINCT ON (mes) mes,venta2021.id_producto,nombre_producto,cantidad_vendida
FROM (
  SELECT id_producto, TO_CHAR(fecha,'Month') AS mes, SUM(cantidad) AS cantidad_vendida
  FROM venta
  JOIN producto_venta ON venta.id_venta = producto_venta.id_venta
  WHERE EXTRACT (YEAR from fecha) = 2021
  GROUP BY id_producto, mes
) as venta2021
JOIN producto ON producto.id_producto = venta2021.id_producto
ORDER BY mes,nombre_producto, cantidad_vendida, id_producto DESC;



/* 2. Producto mas economico por tienda */

/* Si la tienda no tiene productos, no se muestra en la lista */
SELECT DISTINCT ON (id_tienda) id_tienda, nombre_producto, precio, stock
FROM producto
ORDER BY id_tienda, precio ASC;


/* 3. Ventas por mes, separadas entre Boletas y Facturas */
SELECT DATE_TRUNC('month', Venta.fecha), Tipo_Documento.tipo, COUNT(*) AS cantidad_ventas
FROM Venta
INNER JOIN Tipo_Documento ON Venta.id_tipo_documento = Tipo_Documento.id_tipo_documento
WHERE Tipo_Documento.tipo = 'Boleta' OR Tipo_Documento.tipo = 'Factura'
GROUP BY DATE_TRUNC('month', Venta.fecha), Tipo_Documento.tipo
ORDER BY DATE_TRUNC('month', Venta.fecha), Tipo_documento.tipo;


/* 4. Empleado que gano mas por tienda en 2020, indicando la comuna
      donde vive y el cargo que tiene en la empresa */
WITH totales_anuales AS (
    SELECT e.id_empleado, e.id_tienda, e.nombre_empleado, e.id_comuna, e.cargo, 
    SUM(s.monto_sueldo) AS total_2020
	
    FROM empleado e
    INNER JOIN sueldo s ON e.id_empleado = s.id_empleado
    WHERE EXTRACT(YEAR FROM s.fecha_pago) = 2020
    GROUP BY e.id_empleado, e.id_tienda, e.nombre_empleado, e.id_comuna, e.cargo
),

max_por_tienda AS (
    SELECT id_tienda, MAX(total_2020) AS monto_max
    FROM totales_anuales
    GROUP BY id_tienda
)

SELECT t.nombre_tienda, ta.nombre_empleado, c.nombre_comuna, ta.cargo, ta.total_2020
FROM totales_anuales ta
INNER JOIN max_por_tienda mpt ON ((ta.id_tienda = mpt.id_tienda) AND (ta.total_2020 = mpt.monto_max))
INNER JOIN tienda t ON ta.id_tienda = t.id_tienda
INNER JOIN comuna c ON ta.id_comuna = c.id_comuna;


/* 5. La tienda que tiene menos empleados */
SELECT e.id_tienda, numero_empleados,id_comuna,nombre_tienda,direccion_tienda
FROM (
		SELECT id_tienda ,COUNT(*) AS numero_empleados
		FROM empleado
		GROUP BY id_tienda
) e 
INNER JOIN tienda 
ON e.id_tienda = tienda.id_tienda
ORDER BY e.numero_empleados ASC
LIMIT 1;

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
WITH ventas_vendedor AS (SELECT EXTRACT(YEAR FROM Venta.fecha) as ano, Vendedor.id_vendedor, SUM(Producto.precio * Producto_Venta.cantidad) AS total_recaudado
                         FROM Venta 
                         JOIN Producto_Venta ON Venta.id_venta = Producto_Venta.id_venta
                         JOIN Producto ON Producto_Venta.id_producto = Producto.id_producto
                         GROUP BY ano, Venta.id_vendedor),
mejores AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY ano ORDER BY total_recaudado DESC) AS mejor
            FROM ventas_vendedor)
SELECT mejores.ano, mejores.id_vendedor, empleado.nombre_empleado, mejores.total_recaudado
FROM mejores
JOIN Vendedor ON mejores.id_vendedor = vendedor.id_vendedor
JOIN Empleado ON Vendedor.id_empleado = Empleado.id_empleado
WHERE mejores.mejor = 1
ORDER BY mejores.ano;

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
