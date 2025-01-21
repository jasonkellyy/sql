SELECT stk.product, inv.description, SUM(stk.qty_invoiced) AS 'Quantity Invoiced'

FROM si_sop_inv_stock stk

LEFT JOIN si_sop_inv_header invh ON stk.invoice_no = invh.invoice_no

LEFT JOIN inventory inv ON stk.product = inv.product

WHERE CAST(invh.invoice_date AS DATE) BETWEEN @Date AND @date2

GROUP BY stk.product, inv.description

ORDER BY stk.product;
