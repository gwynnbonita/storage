-- 7.1

CREATE TABLE STUDENT(
    STU_NUM INT PRIMARY KEY,
    STU_FNAME VARCHAR(50),
    STU_MNAME VARCHAR(50),
    STU_LNAME VARCHAR(50),
    STU_YR INT,
    STU_DEPT VARCHAR(50),
    STU_SEC VARCHAR(5),
    STU_ENDATE DATE
);

INSERT INTO STUDENT (STU_NUM, STU_FNAME, STU_MNAME, STU_LNAME, STU_YR, STU_DEPT, STU_SEC, STU_ENDATE)
VALUES
    (1001, 'Jake', 'Paras', 'Alonzo', 1, 'CS', 'A', '2022-07-15'),
    (1002, 'Rainne', 'Diaz', 'Martinez', 1, 'CS', 'A', '2022-08-01'),
    (2003, 'Matthew', NULL, 'Dela Cruz', 2, 'IS', 'B', '2022-07-15'),
    (2004, 'Rose Ann', 'Osorio', 'Jose', 2, 'IT', 'D', '2022-08-20'),
    (3005, 'Catherine', 'Lopez', 'Poblete', 3, 'CS', 'E', '2022-08-21'),
    (4006, 'Thalia', NULL, 'San Juan', 4, 'IT', 'C', '2022-07-19');
    
SELECT * FROM student;

SELECT
    STU_NUM AS "STUDENT#",
    CONCAT(STU_LNAME, ', ', STU_FNAME, ' ',
    CASE WHEN STU_MNAME IS NOT NULL THEN 
		CONCAT(' ', SUBSTR(STU_MNAME, 1, 1), '.') 
    ELSE '' 
    END) AS NAME,
    CONCAT(STU_YR, STU_DEPT, STU_SEC) AS Section,
    DATE_FORMAT(STU_ENDATE, '%M %d, %Y') AS "ENROLLMENT DATE",
    CASE
        WHEN STU_ENDATE < '2022-08-15' THEN 'REGULAR'
        ELSE 'LATE'
    END AS STATUS
FROM STUDENT;

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

-- 7.3

CREATE TABLE SALARY (
    EMP_CODE INT PRIMARY KEY,
    EMP_NAME VARCHAR(50),
    EMP_DATE DATE,
    EMP_DAILY_RATE INT,
    EMP_HOURS INT
);

INSERT INTO salary (EMP_CODE, EMP_NAME, EMP_DATE, EMP_DAILY_RATE, EMP_HOURS)
VALUES
    (20262015, 'Jamie Ruiz', '2023-10-09', 1200, 4), 
    (20264823, 'Mike Dela Pena', '2023-10-18', 900, 4),
    (20253882, 'George Poon', '2023-09-20', 850, 8),
    (20252081, 'Cynthia Reyes', '2023-09-15', 1100, 7),
    (20223240, 'Ivan Lopez', '2023-08-17', 1050, 10),
    (20263539, 'Britney Manalo', '2023-10-14', 950, 2),
    (20268799, 'Karen Dy', '2023-10-20', 850, 5),
    (20254335, 'Franco Victorio', '2023-09-25', 750, 6);

SELECT * FROM salary;

SELECT 
    EMP_CODE,
    EMP_NAME AS NAME,
    CASE
        WHEN EMP_HOURS BETWEEN 1 AND 3 THEN 'temporary'
        WHEN EMP_HOURS BETWEEN 4 AND 6 THEN 'probationary'
        ELSE 'regular'
    END AS STATUS,
    CASE
        WHEN (MONTH(EMP_DATE) BETWEEN 1 AND 9) OR (DAY(EMP_DATE) BETWEEN 1 AND 15) THEN 'yes'
        ELSE 'no'
    END AS SALARY_16TH,
    CASE
		--  when employee is hired between October 1-15
        WHEN (MONTH(EMP_DATE) = 10 ) AND (DAY(EMP_DATE) BETWEEN 1 AND 15) THEN 
            CAST((EMP_DAILY_RATE * EMP_HOURS * (ABS(DAY(EMP_DATE) - 15)) - 
            (CASE
                WHEN EMP_HOURS BETWEEN 1 AND 3 THEN 10 * ABS(DAY(EMP_DATE) - 15)
                WHEN EMP_HOURS BETWEEN 4 AND 6 THEN 30 * ABS(DAY(EMP_DATE) - 15)
                ELSE 40 * ABS(DAY(EMP_DATE) - 15)
            END)) AS DECIMAL(10, 2))
		-- When employee is hired before October
		WHEN (MONTH(EMP_DATE) < 10) THEN
		CAST(((EMP_DAILY_RATE * EMP_HOURS) * (15)) - 
            (CASE
                WHEN EMP_HOURS BETWEEN 1 AND 3 THEN 150
                WHEN EMP_HOURS BETWEEN 4 AND 6 THEN 450
                ELSE 600
            END) AS DECIMAL(10, 2))
        ELSE NULL
    END AS AMOUNT_16TH,
    CASE
        WHEN DAY(EMP_DATE) BETWEEN 1 AND 30 THEN 'yes'
    END AS SALARY_31ST,
    CASE
		-- Before October 15th
        WHEN (DAY(EMP_DATE) BETWEEN 1 AND 15) OR (MONTH(EMP_DATE) < 10)THEN 
            CAST(((EMP_DAILY_RATE * EMP_HOURS) * (15)) - 
            (CASE
                WHEN EMP_HOURS BETWEEN 1 AND 3 THEN 150
                WHEN EMP_HOURS BETWEEN 4 AND 6 THEN 450
                ELSE 600
            END) AS DECIMAL(10, 2))
		-- After October 15th
        WHEN (MONTH(EMP_DATE) = 10) AND (DAY(EMP_DATE) BETWEEN 16 AND 30) THEN 
            CAST(((EMP_DAILY_RATE * EMP_HOURS) * (ABS(DAY(EMP_DATE) - 30)) - 
            (CASE
                WHEN EMP_HOURS BETWEEN 1 AND 3 THEN 10 * ABS(DAY(EMP_DATE) - 30)
                WHEN EMP_HOURS BETWEEN 4 AND 6 THEN 30 * ABS(DAY(EMP_DATE) - 30)
                ELSE 40 * ABS(DAY(EMP_DATE) - 30)
            END)) AS DECIMAL(10, 2))
        ELSE NULL
    END AS AMOUNT_31ST
FROM 
    SALARY
WHERE 
    MONTH(EMP_DATE) BETWEEN 1 AND 10;

DROP TABLE SALARY;
    
drop database SCHOOL;
