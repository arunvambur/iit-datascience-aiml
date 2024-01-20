
/*1. Create a stored procedure to display the restaurant name, type and cuisine where the
table booking is not zero.**/

CREATE or ALTER FUNCTION dbo.GetTableBooking()
RETURNS TABLE
RETURN(
	SELECT RestaurantName, RestaurantType, CuisinesType
	FROM Jomato
	WHERE TableBooking > 0 
);

/*2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.*/

BEGIN TRANSACTION;
UPDATE Jomato
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType = 'Cafe';

SELECT *
FROM Jomato
WHERE CuisinesType = 'Cafeteria';

ROLLBACK;

SELECT *
FROM Jomato
WHERE CuisinesType = 'Cafe';

/*3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.*/
SELECT * FROM(
	SELECT ROW_NUMBER() OVER(ORDER BY Rating DESC) AS Rank, Area
	FROM Jomato 
) j
WHERE Rank <=5

/*4. Use the while loop to display the 1 to 50*/

DECLARE @Counter INT 
SET @Counter=1
WHILE ( @Counter <= 50)
BEGIN
    PRINT CONVERT(VARCHAR,@Counter)
    SET @Counter  = @Counter  + 1
END

/*5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.*/

CREATE OR ALTER VIEW TopRatingRestaurant AS
SELECT RestaurantName FROM(
	SELECT ROW_NUMBER() OVER(ORDER BY Rating DESC) AS Rank, RestaurantName
	FROM Jomato 
) j
WHERE Rank <=5;

SELECT * FROM TopRatingRestaurant;

/*6. Write a trigger that sends an email notification to the restaurant owner whenever a new record is inserted*/

/*mail configuration*/
USE Sales
GO
 
SP_CONFIGURE 'show advanced options', 1
RECONFIGURE WITH OVERRIDE
GO
 
SP_CONFIGURE 'Database Mail XPs', 1
RECONFIGURE WITH OVERRIDE
GO
 
SP_CONFIGURE 'show advanced options', 0
RECONFIGURE WITH OVERRIDE
GO

EXEC msdb.dbo.sysmail_add_account_sp
    @account_name = 'Arun_Mail_Account'
   ,@description = 'Send emails using SQL Server Stored Procedure'
   ,@email_address = 'arunvambur@gmail.com'
   ,@display_name = 'Arun Venkatesan'
   ,@replyto_address = 'arunvambur@gmail.com'
   ,@mailserver_name = 'smtp.gmail.com'
   ,@username = 'arunvambur@gmail.com'
   ,@password = ''
   ,@port = 587
   ,@enable_ssl = 1
GO

EXEC msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'ArunVenkatesan_Email_Profile'
   ,@description = 'Send emails using SQL Server Stored Procedure'
GO

EXEC msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'ArunVenkatesan_Email_Profile'
   ,@account_name = 'Arun_Mail_Account'
   ,@sequence_number = 1
GO


/*Trigger*/

CREATE TRIGGER [dbo].[Jomato_Insert_Notification]
       ON [dbo].[Jomato]
AFTER INSERT
AS
BEGIN
       SET NOCOUNT ON;
 
       DECLARE @restaurantName VARCHAR
	   
       SELECT @restaurantName = INSERTED.RestaurantName      
       FROM INSERTED
       declare @body varchar(500) = 'A new restaurant ' + CAST(@restaurantName AS VARCHAR(50)) + ' inserted into the table Jomato.'
       EXEC msdb.dbo.sp_send_dbmail
            @profile_name = 'ArunVenkatesan_Email_Profile'
           ,@recipients = 'arunvambur@gmail.com'
           ,@subject = 'New Restaurant Added'
           ,@body = @body
           ,@importance ='HIGH'
END

/*test*/

INSERT INTO Jomato(OrderId, RestaurantName, RestaurantType, Rating, No_of_Rating, AverageCost, OnlineOrder, TableBooking, CuisinesType, Area, LocalAddress, Delivery_time)
VALUES(10000, 'Village cafe', 'Cafe', 4.9, 100, 700, 0, 1,  'Cafe, South Indian', 'Chennai', 'Ekkattuthangal', 55)
