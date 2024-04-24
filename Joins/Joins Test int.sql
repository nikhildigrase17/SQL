USE DEMODATABASE;

DROP TABLE TABLE2;

CREATE TABLE TABLE1(
NAME1 INT
);

INSERT INTO TABLE1
VALUES
(1),
(1),
(NULL),
(2),
(3),
(NULL),
(4);

SELECT * FROM TABLE1;

CREATE TABLE TABLE2(
NAME2 INT
);

INSERT INTO TABLE2
VALUES
(1),
(2),
(2),
(NULL),
(3),
(3),
(4);

SELECT * FROM TABLE2;

SELECT COUNT(*) FROM TABLE2;

SELECT DISTINCT *
FROM TABLE1 AS T1
INNER JOIN TABLE2 T2
ON T1.NAME1 = T2.NAME2;

SELECT DISTINCT *
FROM TABLE1 AS T1
LEFT OUTER JOIN TABLE2 T2
ON T1.NAME1 = T2.NAME2;

SELECT DISTINCT *
FROM TABLE1 AS T1
RIGHT OUTER JOIN TABLE2 T2
ON T1.NAME1 = T2.NAME2;

-- FULL OUTER JOIN

SELECT * FROM TABLE1
UNION
SELECT * FROM TABLE2;

SELECT  DISTINCT *
FROM TABLE1 AS T1
CROSS JOIN TABLE2 T2;

SELECT DISTINCT *
FROM TABLE1 AS T1
JOIN TABLE1 T2
ON T1.NAME1 = T2.NAME1;