/* 1) Producto mas vendido por mes en 2021 */
SELECT mes, nombre_producto, total_vendido
FROM (
    SELECT
        EXTRACT(MONTH FROM v.fecha)::INT AS mes,
        p.nombre_producto,
        COUNT(*) AS total_vendido,
        ROW_NUMBER() OVER (
            PARTITION BY EXTRACT(MONTH FROM v.fecha)
            ORDER BY COUNT(*) DESC, p.nombre_producto
        ) AS rn
    FROM venta v
    JOIN prod_venta pv ON pv.id_venta = v.id_venta
    JOIN producto p ON p.id_producto = pv.id_producto
    WHERE EXTRACT(YEAR FROM v.fecha) = 2021
    GROUP BY EXTRACT(MONTH FROM v.fecha), p.nombre_producto
) t
WHERE rn = 1
ORDER BY mes;

/* 2) Producto mas economico por tienda (entre productos vendidos en esa tienda) */
SELECT nombre_tienda, nombre_producto, precio
FROM (
    SELECT
        t.nombre_tienda,
        p.nombre_producto,
        p.precio,
        ROW_NUMBER() OVER (
            PARTITION BY t.id_tienda
            ORDER BY p.precio ASC, p.id_producto
        ) AS rn
    FROM tienda t
    JOIN venta v ON v.id_tienda = t.id_tienda
    JOIN prod_venta pv ON pv.id_venta = v.id_venta
    JOIN producto p ON p.id_producto = pv.id_producto
) x
WHERE rn = 1
ORDER BY nombre_tienda;

/* 3) Ventas por mes separadas entre Boletas y Facturas */
SELECT
    DATE_TRUNC('month', v.fecha)::DATE AS mes,
    td.tipo,
    SUM(v.monto_total) AS total_ventas
FROM venta v
JOIN tipo_doc td ON td.id_tipo_doc = v.id_tipo_doc
WHERE td.tipo IN ('Boleta', 'Factura')
GROUP BY DATE_TRUNC('month', v.fecha), td.tipo
ORDER BY mes, td.tipo;

/* 4) Empleado que gano mas por tienda en 2020, con comuna y cargo
   Nota: "gano mas" se interpreta como mayor monto vendido en 2020. */
SELECT nombre_tienda, nombre_empleado, nombre_comuna, cargo, total_2020
FROM (
    SELECT
        t.id_tienda,
        t.nombre_tienda,
        e.id_empleado,
        e.nombre_empleado,
        c.nombre_comuna,
        s.cargo,
        SUM(v.monto_total) AS total_2020,
        ROW_NUMBER() OVER (
            PARTITION BY t.id_tienda
            ORDER BY SUM(v.monto_total) DESC, e.id_empleado
        ) AS rn
    FROM venta v
    JOIN vendedor vd ON vd.id_vendedor = v.id_vendedor
    JOIN empleado e ON e.id_empleado = vd.id_empleado
    JOIN tienda t ON t.id_tienda = v.id_tienda
    JOIN comuna c ON c.id_comuna = e.id_comuna
    JOIN sueldo s ON s.id_sueldo = e.id_sueldo
    WHERE EXTRACT(YEAR FROM v.fecha) = 2020
    GROUP BY t.id_tienda, t.nombre_tienda, e.id_empleado, e.nombre_empleado, c.nombre_comuna, s.cargo
) y
WHERE rn = 1
ORDER BY nombre_tienda;

/* 5) Tienda que tiene menos empleados */
SELECT nombre_tienda, total_empleados
FROM (
    SELECT
        t.id_tienda,
        t.nombre_tienda,
        COUNT(e.id_empleado) AS total_empleados,
        ROW_NUMBER() OVER (
            ORDER BY COUNT(e.id_empleado) ASC, t.id_tienda
        ) AS rn
    FROM tienda t
    LEFT JOIN empleado e ON e.id_tienda = t.id_tienda
    GROUP BY t.id_tienda, t.nombre_tienda
) x
WHERE rn = 1;

/* 6) Vendedor con mas ventas por mes */
SELECT anio, mes, nombre_vendedor, cant_ventas
FROM (
    SELECT
        EXTRACT(YEAR FROM v.fecha)::INT AS anio,
        EXTRACT(MONTH FROM v.fecha)::INT AS mes,
        vd.nombre AS nombre_vendedor,
        COUNT(*) AS cant_ventas,
        ROW_NUMBER() OVER (
            PARTITION BY EXTRACT(YEAR FROM v.fecha), EXTRACT(MONTH FROM v.fecha)
            ORDER BY COUNT(*) DESC, vd.id_vendedor
        ) AS rn
    FROM venta v
    JOIN vendedor vd ON vd.id_vendedor = v.id_vendedor
    GROUP BY EXTRACT(YEAR FROM v.fecha), EXTRACT(MONTH FROM v.fecha), vd.id_vendedor, vd.nombre
) x
WHERE rn = 1
ORDER BY anio, mes;

/* 7) Vendedor que mas recauda por tienda por anio */
SELECT anio, nombre_tienda, nombre_vendedor, total_recaudado
FROM (
    SELECT
        EXTRACT(YEAR FROM v.fecha)::INT AS anio,
        t.id_tienda,
        t.nombre_tienda,
        vd.nombre AS nombre_vendedor,
        SUM(v.monto_total) AS total_recaudado,
        ROW_NUMBER() OVER (
            PARTITION BY EXTRACT(YEAR FROM v.fecha), t.id_tienda
            ORDER BY SUM(v.monto_total) DESC, vd.id_vendedor
        ) AS rn
    FROM venta v
    JOIN vendedor vd ON vd.id_vendedor = v.id_vendedor
    JOIN tienda t ON t.id_tienda = v.id_tienda
    GROUP BY EXTRACT(YEAR FROM v.fecha), t.id_tienda, t.nombre_tienda, vd.id_vendedor, vd.nombre
) x
WHERE rn = 1
ORDER BY anio, nombre_tienda;

/* 8) Vendedor con mas productos vendidos por tienda
   Nota: se usa COUNT(*) en prod_venta; si se desea exactitud por unidades, usar SUM(cantidad). */
SELECT nombre_tienda, nombre_vendedor, total_productos
FROM (
    SELECT
        t.id_tienda,
        t.nombre_tienda,
        vd.nombre AS nombre_vendedor,
        COUNT(*) AS total_productos,
        ROW_NUMBER() OVER (
            PARTITION BY t.id_tienda
            ORDER BY COUNT(*) DESC, vd.id_vendedor
        ) AS rn
    FROM venta v
    JOIN tienda t ON t.id_tienda = v.id_tienda
    JOIN vendedor vd ON vd.id_vendedor = v.id_vendedor
    JOIN prod_venta pv ON pv.id_venta = v.id_venta
    GROUP BY t.id_tienda, t.nombre_tienda, vd.id_vendedor, vd.nombre
) x
WHERE rn = 1
ORDER BY nombre_tienda;

/* 9) Empleado con mayor sueldo por mes
   Nota: no existe historial mensual de sueldos, se toma sueldo actual asociado a empleados con ventas ese mes. */
SELECT anio, mes, nombre_empleado, sueldo
FROM (
    SELECT
        EXTRACT(YEAR FROM v.fecha)::INT AS anio,
        EXTRACT(MONTH FROM v.fecha)::INT AS mes,
        e.nombre_empleado,
        s.sueldo,
        ROW_NUMBER() OVER (
            PARTITION BY EXTRACT(YEAR FROM v.fecha), EXTRACT(MONTH FROM v.fecha)
            ORDER BY s.sueldo DESC, e.id_empleado
        ) AS rn
    FROM venta v
    JOIN vendedor vd ON vd.id_vendedor = v.id_vendedor
    JOIN empleado e ON e.id_empleado = vd.id_empleado
    JOIN sueldo s ON s.id_sueldo = e.id_sueldo
    GROUP BY EXTRACT(YEAR FROM v.fecha), EXTRACT(MONTH FROM v.fecha), e.id_empleado, e.nombre_empleado, s.sueldo
) x
WHERE rn = 1
ORDER BY anio, mes;

/* 10) Tienda con menor recaudacion por mes */
SELECT anio, mes, nombre_tienda, total_mes
FROM (
    SELECT
        EXTRACT(YEAR FROM v.fecha)::INT AS anio,
        EXTRACT(MONTH FROM v.fecha)::INT AS mes,
        t.id_tienda,
        t.nombre_tienda,
        SUM(v.monto_total) AS total_mes,
        ROW_NUMBER() OVER (
            PARTITION BY EXTRACT(YEAR FROM v.fecha), EXTRACT(MONTH FROM v.fecha)
            ORDER BY SUM(v.monto_total) ASC, t.id_tienda
        ) AS rn
    FROM venta v
    JOIN tienda t ON t.id_tienda = v.id_tienda
    GROUP BY EXTRACT(YEAR FROM v.fecha), EXTRACT(MONTH FROM v.fecha), t.id_tienda, t.nombre_tienda
) x
WHERE rn = 1
ORDER BY anio, mes;