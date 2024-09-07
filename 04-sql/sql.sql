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
--     , HasLite BIT
--     , Price DECIMAL(18, 4)
--     , VideoCard NVARCHAR(50)
-- }
-- GO


-- SELECT * FROM TutorialAppSchema.Computer