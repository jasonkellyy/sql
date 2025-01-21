SELECT DISTINCT QTY.Product, INV.Description, RN.prodline, RN.InputProducts, PL.ProductionLine, QTY.Qty, PH.PlanHeaderID, PH.PlanDate

FROM RunNumber RN

LEFT JOIN RunNumber_ProductionQty QTY ON QTY.RunNumber = RN.RunNumber

LEFT JOIN PlanLine PL ON PL.Product = QTY.Product

LEFT JOIN PlanHeader PH ON PH.PlanHeaderID = PL.PlanHeaderID

LEFT JOIN si_prod_lines SPL ON PL.ProductionLine = SPL.productionline

LEFT JOIN inventory INV ON INV.product = QTY.Product

WHERE RN.ProductionDate = @Date AND RN.Active = 1 

AND (QTY.UOM = 'CASE' OR QTY.Product LIKE 'ZZP%')

AND (PH.PlanDate = @Date OR (QTY.Product LIKE 'ZZP%'))

AND PH.PlanHeaderID = @PlanID

ORDER BY PL.ProductionLine ASC, QTY.Product ASC
