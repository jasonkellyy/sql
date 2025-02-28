

SELECT
    ds.product as 'Product Code',
	dh.customername as 'Delivery Depot',
    inv.description as 'Product Description',
    SUM(ds.qty) as 'Total Ordered Qty',
    SUM(ds.qty_despatched) as 'Total Despatched Qty',
    SUM(ds.qty) - SUM(ds.qty_despatched) as 'Variance',
	FORMAT(dh.date_ordered, 'dd/MM/yyyy') as 'Date Ordered'
FROM
    si_sop_dsp_header dh
LEFT JOIN
    si_sop_dsp_stock ds ON dh.despatch_no = ds.despatch_no
LEFT JOIN
    si_sop_customers cus ON cus.customercode = dh.customercode
LEFT JOIN
	si_sop_inv_header ih ON dh.order_no = ih.orig_order_no
INNER JOIN
    inventory inv ON inv.product = ds.product
WHERE
(CONVERT(date, dh.date_ordered) Between '2021-01-01 00:00:00.000' and '2024-07-03 00:00:00.000') 
AND ih.invoice_type = '1'
AND dh.customercode IN (--add customer code(s))
GROUP BY
    ds.product,
    inv.description,
	dh.date_ordered,
	dh.customername
ORDER BY
    dh.date_ordered ASC

SELECT
	FORMAT(dh.date_ordered, 'dd/MM/yyyy') as 'Date Ordered',
	FORMAT(dh.date_despatched, 'dd/MM/yyyy') as 'Date Despatched',
	dh.customercode as 'Customer Code',
	dh.customername as 'Depot Name',
    ds.product as 'Product Code',
    inv.description as 'Product Description',
    SUM(ds.qty) as 'Quantity Ordered',
    SUM(ds.qty_despatched) as 'Quantity Despatched'

FROM
    si_sop_dsp_header dh
LEFT JOIN
    si_sop_dsp_stock ds ON dh.despatch_no = ds.despatch_no
LEFT JOIN
    si_sop_customers cus ON cus.customercode = dh.customercode
LEFT JOIN
	si_sop_inv_header ih ON dh.order_no = ih.orig_order_no
INNER JOIN
    inventory inv ON inv.product = ds.product
WHERE
(CONVERT(date, dh.date_ordered) Between '2022-05-25 00:00:00.000' and '2025-07-03 00:00:00.000') 
AND ih.invoice_type = '1'

AND dh.customercode IN ('ALD03', 'ALD04')
AND dh.customercode IN (-- add customer code(s))
GROUP BY
    ds.product,
    inv.description,
	dh.date_ordered,
	dh.customername,
	dh.date_despatched,
	dh.customercode
ORDER BY
    dh.date_ordered ASC
