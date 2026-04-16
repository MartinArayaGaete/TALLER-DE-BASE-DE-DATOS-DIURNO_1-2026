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

/*Producto Mas vendido por mes el 2021*/
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


/*Producto mas economico por tienda*/
/*Ventas por mes, separadas entre Boletas y Facturas*/
/*Empleado que gano mas por tienda en 2020, indicando la comuna
donde vive y el cargo que tiene en la empresa
*/
/*la tienda que tiene menos empleados*/
/*el vendedor con mas ventas por mes*/
/*el vendedor que ha recaudado mas dinero para la tienda por año*/
/*El vendedor con mas productos vendidos por tineda*/
/*El empleado con mayor sueldo por mes*/
/*La tienda con menor recaudacion por mes*/