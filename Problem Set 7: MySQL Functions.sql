
-- 7.2
    
CREATE TABLE INVENTORY (
	INV_NO INT KEY NOT NULL,
    INV_CODE INT NOT NULL,
    ITEM_CODE VARCHAR(20) NOT NULL,
    ITEM_CATE VARCHAR(20) NOT NULL,
    ITEM_AVAIL INT NOT NULL);

INSERT INTO INVENTORY (INV_NO, INV_CODE, ITEM_CODE, ITEM_CATE, ITEM_AVAIL) VALUES
	(1, 20012, 'QW-6599', 'Furniture', 10), 
    (2, 20012, 'QW-6822', 'Furniture', 8), 
    (3, 20012, 'QW-6822', 'Furniture', 11), 
    (4, 20015, 'QW-6599', 'Furniture', 8), 
    (5, 20016, 'QW-8766', 'Furniture', 8), 
    (6, 20016, 'QW-6822', 'Lamp', 12), 
    (7, 20018, 'QW-8656', 'Lamp', 10), 
    (8, 20020, 'QW-8766', 'Lamp', '12'), 
    (9, 20020, 'QW-8656', 'Lamp', 10), 
    (10, 20021, 'QW-6599', 'Cables', 11), 
    (11, 20022, 'QW-8766', 'Cables', 8), 
    (12, 20022, 'QW-8656', 'Cables', 12);
    
SELECT * FROM INVENTORY;

DELETE FROM INVENTORY
WHERE (INV_CODE, ITEM_CODE, ITEM_CATE, ITEM_AVAIL) IN 
	((20012, 'QW-6822', 'Furniture', 8), 
    (20020, 'QW-8766', 'Lamp', 12));

SELECT * FROM INVENTORY;
