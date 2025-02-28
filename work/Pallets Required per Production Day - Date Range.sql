SELECT inva.product, inv.description, SUM(inva.quantity2) AS 'Quantity', inv.casesperpallet,
CEILING(SUM(CAST(ISNULL(inva.quantity2, 0) AS FLOAT)) / CAST(ISNULL(inv.casesperpallet, 1) AS FLOAT)) AS 'Pallets Required'

FROM inventoryaudit inva

LEFT JOIN inventory inv ON inv.product = inva.product

WHERE CONVERT(date, inva.transdate) BETWEEN @Date1 AND @Date2 
AND inva.area = '16' AND inva.reference = 'OCM'
AND inva.product NOT LIKE '%[A-Za-z]'

GROUP BY inva.product, inv.casesperpallet, inv.description

ORDER BY inva.product ASC
