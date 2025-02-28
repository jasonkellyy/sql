SELECT oh.ordernumber, sup.suppliername, oh.SupplierReference, CONVERT(varchar, oh.daterequired, 103) AS 'Date Required', od.product, inv.description, od.orderqtyordered, 
od.orderqtyreceived

FROM POP_OrderDetail od

LEFT JOIN POP_OrderHeader oh ON od.POP_OrderHeader_ID = oh.POP_OrderHeader_ID
LEFT JOIN POP_Supplier sup ON oh.POP_Supplier_ID = sup.POP_Supplier_ID
LEFT JOIN inventory inv ON od.product = inv.product

WHERE CONVERT(date, oh.daterequired) BETWEEN @Date AND @date2
AND sup.suppliername IN (@Supplier)

ORDER BY suppliername ASC
