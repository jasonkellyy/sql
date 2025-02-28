SELECT RunNumber, ProductionDate, Product, Qty, InputOutput

FROM RunNumber_ProductionQty

WHERE ProductionDate = @Date AND InputOutput = 1 AND Product NOT IN ('WASTE')

ORDER BY Product ASC
