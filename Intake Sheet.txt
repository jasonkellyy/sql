SELECT 
    dbo.InventoryBatch.product, 
    MAX(dbo.inventory.description) AS description, 
    MAX(dbo.InventoryBatch.batchno) AS batchno, 
    MAX(dbo.InventoryBatch.purchaseorder) AS purchaseorder, 
    SUM(dbo.InventoryBatch.onhandqty) AS total_onhandqty, 
    SUM(dbo.InventoryBatch.onhandqty2) AS total_onhandqty2,
    -- Formatted Created Date with Year
    CONVERT(VARCHAR, MAX(dbo.InventoryBatch.createdate), 103) AS CreatedDateFormatted,  
    -- Formatted Use By Date with Year in the CASE statement
    MAX(CASE WHEN QA_Definition.Question = 'Use by date' THEN 
             CONVERT(VARCHAR, TS_QC_Information.QCInput, 103) END) AS 'Use by Date',
    MAX(dbo.InventoryBatch.goodsreceipt) AS goodsreceipt, 
    MAX(dbo.InventoryBatch.createdby) AS createdby, 
    MAX(dbo.TS_QC_Information.QCID) AS QCID, 
    MAX(dbo.TS_QC_Information.comment) AS comment, 
    MAX(SI_QA.dbo.QA_Template.Name) AS TemplateName, 
    MAX(SI_QA.dbo.QA_Template.Description) AS TemplateDescription, 
    MAX(SI_POP.dbo.POP_Supplier.SupplierName) AS SupplierName, 
    DATEADD(dd, 0, DATEDIFF(dd, 0, MAX(dbo.InventoryBatch.createdate))) AS DateReceived,

    MAX(CASE WHEN QA_Definition.Question = 'Delivery PO' THEN TS_QC_Information.QCInput END) AS 'PO Number',
    MAX(CASE WHEN QA_Definition.Question = 'Vehicle Condition' THEN TS_QC_Information.QCInput END) AS 'Vehicle Condition',
    MAX(CASE WHEN QA_Definition.Question = 'Packaging Integrity Inc Pallet condition' THEN TS_QC_Information.QCInput END) AS 'Packing Integrity Inc Pallet Condition',
    MAX(CASE WHEN QA_Definition.Question = 'Product Temperature Chilled 0to5 frozen minus15 or less margarine 14to18 potatoes less than 12' THEN TS_QC_Information.QCInput END) AS 'Temp (°C) (If required)',
    MAX(CASE WHEN QA_Definition.Question = 'COA or COC' THEN TS_QC_Information.QCInput END) AS 'COA/COC with delivery',
    MAX(CASE WHEN QA_Definition.Question = 'AppSupp' THEN TS_QC_Information.QCInput END) AS 'Approved Supplier',
    MAX(CASE WHEN QA_Definition.Question = 'Plant Code for meat deliveries only' THEN TS_QC_Information.QCInput END) AS 'Plant Code (Meat deliveries only)',
    MAX(CASE WHEN QA_Definition.Question = 'AccRejec' THEN TS_QC_Information.QCInput END) AS 'Accepted / Rejected',

    COALESCE(MAX(CASE WHEN QA_Definition.Question = 'Intake Person' THEN TS_QC_Information.QCInput END),
             MAX(CASE WHEN QA_Definition.Question = 'Delivery Checked By' THEN TS_QC_Information.QCInput END)) AS 'Accepted by', 

    MAX(CASE WHEN QA_Definition.Question = 'Quantity' THEN TS_QC_Information.QCInput END) AS 'Quantity Received',

    dbo.InventoryBatch.area,  
    MAX(area.description) AS AreaDescription  

FROM 
    dbo.InventoryBatch 
    INNER JOIN dbo.inventory ON dbo.InventoryBatch.product = dbo.inventory.product 
    INNER JOIN dbo.TS_QC_Information ON dbo.InventoryBatch.batchno = dbo.TS_QC_Information.batchno 
    INNER JOIN SI_QA.dbo.QA_Template ON dbo.TS_QC_Information.TemplateID = SI_QA.dbo.QA_Template.TemplateId 
    INNER JOIN SI_QA.dbo.QA_Definition ON dbo.TS_QC_Information.QCID = SI_QA.dbo.QA_Definition.DefinitionId 
    INNER JOIN SI_POP.dbo.POP_Supplier ON dbo.InventoryBatch.supplier = SI_POP.dbo.POP_Supplier.SupplierCode
    LEFT JOIN dbo.area ON dbo.InventoryBatch.area = area.area  

WHERE 
    (DATEADD(dd, 0, DATEDIFF(dd, 0, dbo.InventoryBatch.createdate)) BETWEEN @Date1 AND @Date2) 
    AND dbo.InventoryBatch.area IN (@Area) 

GROUP BY dbo.InventoryBatch.product, dbo.InventoryBatch.area;












