SELECT
    ds.product,
    inv.description,
    SUM(ds.qty) as 'Total Ordered Qty',
    SUM(ds.qty_despatched) as 'Total Despatched Qty',
    SUM(ds.qty) - SUM(ds.qty_despatched) as 'Variance'
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
(CONVERT(date, dh.date_ordered) Between @Date and @date2) 
AND dh.customercode NOT IN ('BAK01', 'COM01',
'FCC96', 'FCC97', 'FCC98', 'MC01', 'QC01', 'SCP01')
AND ih.invoice_type = '1'
GROUP BY
    ds.product,
    inv.description
ORDER BY
     ds.product ASC
