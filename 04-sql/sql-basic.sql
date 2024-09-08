-- CREATE DATABASE DotNetCourseDatabase
-- -- Put a "GO" Statement so that if we were to tun this as a comprehensive script we wouldn't be breaking anything.  
-- -- Basiv saying everything after "GO" Statement is a new and seperate query
-- GO

-- -- We create a new database in top of master
-- -- because the master database should be reserved for SQL Server to manage itself for the most part, or for something that we want to have access to across multiple databases but unless you're an experienced database administrator. Then you probadly won't want to do anyting in the master database
-- USE DotNetCourseDatabase
-- GO

-- CREATE SCHEMA TutorialAppSchema
-- GO

-- CREATE TABLE TutorialAppSchema.Computer 
-- {
-- -- Tabled  INT IDENTITY(starting, Increment By) 
--     ComputedId INT IDENTITY(1,1) PRIMARY KEY
--     -- , Motherboard CHAR(10) 'x' => 'x         '
--     -- , Motherboard VARCHAR(10) 'x' => 'x'
--     --  NVARCHAR(255) is not a cure all, and if you have enough information to make the size closer to he values it will hold, that is always a better idea.
--     , Motherboard NVARCHAR(50) '!@#^$%' => error?
--     , CPUCores INT
--     -- BIT is a single bit 1 or 0 and translate back to true or false when we try to convert it to a Boolean in C#
--     , HasWifi BIT  
--     , HasLite BIT,
--    ,  ReleaseDate DATETIME 
--     , Price DECIMAL(18, 4)
--     , VideoCard NVARCHAR(50)
-- }
-- GO


-- SELECT * FROM TutorialAppSchema.Computer

-- -- ComputerId - you can't insert something into a table in a field that's been declared as an IDENTITY
-- -- You can increment manual the IDENTITY with "SET IDENTITY_INSERT TutorialAppSchema.Computer ON" and after that you need to set off "SET IDENTITY_INSERT TutorialAppSchema.Computer OFF" because could cause other issues for you down the line.
-- INSERT INTO TutorialAppSchema.Computer(
-- [Motherboard],
-- [CPUCores],
-- [HasWifi],
-- [HasLTE],
-- [ReleaseDate],
-- [Price],
-- [VideoCard]
-- ) VALUES (
--     'Sample-Motherboard',
--     4,
--     1,
--     0,
--     '2022-01-01',
--     1000,
--     'Sample-Videocard'
-- )


-- DELETE FROM TutorialAppSchema.Computer WHERE ComputerId = 100

-- UPDATE TutorialAppSchema.Computer SET CPUCores = 4 WHERE ComputerId = 100
-- UPDATE TutorialAppSchema.Computer SET CPUCores = 4 WHERE ReleaseDate < '2017-01-01'
-- UPDATE TutorialAppSchema.Computer SET CPUCores = NULL WHERE ReleaseDate > '2017-01-01'

-- -- ISNULL return no column so we need to set an alias name with "AS" and the name we want to give "CPUCores" in this case
-- SELECT [ComputerId],
-- [Motherboard],
-- ISNULL([CPUCores], 4) AS CPUCores,
-- [HasWifi],
-- [HasLTE],
-- [ReleaseDate],
-- [Price],
-- [VideoCard] FROM TutorialAppSchema.Computer
--     ORDER BY HasWifi DESC, ReleaseDate DESC