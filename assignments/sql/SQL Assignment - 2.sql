select * from Jomato;

select * from Jomato where RestaurantType = 'Quick Bites';

/*1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.*/


CREATE or ALTER FUNCTION dbo.QuickChickenBites (@chicken varchar)
RETURNS varchar
WITH EXECUTE AS CALLER
AS
BEGIN
    RETURN(@chicken);
END;

/*2. Use the function to display the restaurant name and cuisine type which has the maximum number of rating.*/
CREATE or ALTER FUNCTION dbo.QuickChickenBites2()
RETURNS TABLE
RETURN(
	SELECT RestaurantName, CuisinesType, MAX(No_of_Rating) MaxRating
	FROM Jomato
	GROUP BY RestaurantName, CuisinesType 
);


/*3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
start rating, ‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3
and below 3.5 and ‘Bad’ if it is below 3 star rating.*/
CREATE or ALTER FUNCTION dbo.QuickChickenBites3()
RETURNS TABLE
RETURN(
	SELECT  RestaurantName, CuisinesType,  Rating,
	CASE
		WHEN Rating >= 4 THEN 'Excellent'
		WHEN Rating >= 3.5 AND Rating < 5 THEN 'Good'
		WHEN Rating >= 3 AND Rating < 3.5 THEN 'Average'
		ELSE 'Bad'
	END AS RatingStatus
	FROM(
		SELECT RestaurantName, CuisinesType, Rating, MAX(No_of_Rating) MaxRating
	
		FROM Jomato
		GROUP BY RestaurantName, CuisinesType, Rating
	) A
);

/*4. Find the Ceil, floor and absolute values of the rating column and display the current date
and separately display the year, month_name and day*/
CREATE or ALTER FUNCTION dbo.QuickChickenBites4()
RETURNS TABLE
RETURN(
	SELECT  RestaurantName, CuisinesType,  Rating, CEILING(Rating) Ceil, FLOOR(Rating) Floor, ABS(Rating) Absolute,
	CASE
		WHEN Rating >= 4 THEN 'Excellent'
		WHEN Rating >= 3.5 AND Rating < 5 THEN 'Good'
		WHEN Rating >= 3 AND Rating < 3.5 THEN 'Average'
		ELSE 'Bad'
	END AS RatingStatus, CONVERT(date, GETDATE()) CurrentDate, DAY( GETDATE()) Day, MONTH( GETDATE()) Month, YEAR( GETDATE()) Year
	FROM(
		SELECT RestaurantName, CuisinesType, Rating, MAX(No_of_Rating) MaxRating
	
		FROM Jomato
		GROUP BY RestaurantName, CuisinesType, Rating
	) A
);


/*5. Display the restaurant type and total average cost using rollup.*/
SELECT RestaurantName, RestaurantType, SUM(AverageCost) TotalAverageCost
FROM Jomato
GROUP BY ROLLUP(RestaurantName, RestaurantType)