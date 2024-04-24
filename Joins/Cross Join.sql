USE DEMODATABASE;

CREATE OR REPLACE TABLE Meals
(MealName VARCHAR(100));

CREATE OR REPLACE TABLE Drinks
(DrinkName VARCHAR(100));

INSERT INTO Drinks
VALUES
('Orange Juice'), 
('Tea'), 
('Cofee'),
('Beer');

INSERT INTO Meals
VALUES
('Omlet'), 
('Fried Egg'), 
('Sausage');


SELECT * FROM Meals;

SELECT * FROM Drinks;

SELECT * FROM Meals
CROSS JOIN Drinks
ORDER BY MealName;

SELECT *, CONCAT(MEALNAME, ' - ', DRINKNAME) AS BREAK_COMBO
FROM Meals
CROSS JOIN Drinks
ORDER BY MealName;

SELECT *, CONCAT_WS('-',MEALNAME, DRINKNAME) AS BREAK_COMBO
FROM Meals
CROSS JOIN Drinks
ORDER BY MealName;

-- https://www.sqlshack.com/sql-cross-join-with-examples/