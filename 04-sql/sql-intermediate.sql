USE DotNetCourseDatabase
GO

-- -- alias
-- -- "[Users].[FirstName] + ' ' + [Users].[LastName] AS FullName" it is a field Alias or a value alias
-- -- "FROM TutorialAppSchema.Users AS Users" it is a  table Alias 
-- -- The "WHERE" Clause come before "ORDER BY" Clause
-- SELECT [Users].[UserId],
--     [Users].[FirstName] + ' ' + [Users].[LastName] AS FullName,
--     [Users].[Email],
--     [Users].[Gender],
--     [Users].[Active] 
--     FROM TutorialAppSchema.Users AS Users
--     WHERE Users.Active = 1
--     ORDER BY UserId DESC


-- Join with another table
SELECT [Users].[UserId],
    [Users].[FirstName] + ' ' + [Users].[LastName] AS FullName,
    -- [UserJobInfo].[UserId]  [UserJobInfo].[UserId] is equal with [Users].[UserId] so no need to display ,
    [UserJobInfo].[JobTitle],
    [UserJobInfo].[Department],
    [UserSalary].[Salary],
    [Users].[Email],
    [Users].[Gender],
    [Users].[Active]
FROM TutorialAppSchema.Users AS Users
    -- INNER JOIN is same as JOIN
    -- "LEFT JOIN" is going to take our user table and anywhere that is has a match, it's going to pick up date from the table, it's left joining two but anywhere taht it doesn;t have a match, it's just going to leave these fiels blank
    JOIN TutorialAppSchema.UserSalary AS UserSalary
    ON UserSalary.UserId = Users.UserId
    LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
    ON UserJobInfo.UserId = Users.UserId
WHERE Users.Active = 1
ORDER BY Users.UserId DESC

-- DELETE FROM TutorialAppSchema.UserJobInfo where Userid > 500
-- -- When we use BETWEEN we also include the lower and Upper Bound of the value we're chacking
-- DELETE FROM TutorialAppSchema.UserSalary where Userid BETWEEN 250 AND 750 --501 Rows

-- -- "WHERE EXISTS" Clause is faster than "JOIN" Clause
-- -- We query user salary and user id but only if they have a record that exists in user job info.
-- -- "<>" it's means NOT EQUAL
SELECT [UserId],
    [Salary]
FROM TutorialAppSchema.UserSalary
WHERE EXISTS (
            SELECT *
    FROM TutorialAppSchema.UserJobInfo AS UserJobInfo
    WHERE UserJobInfo.UserId = UserSalary.UserId)
    AND UserId <> 7

-- -- "UNION" Clause means were only picking up rows that are distinct between the two data sets 
-- -- "UNION ALL" Clause we are going picking up ALL rows  between the two data sets 
    SELECT [UserId],
        [Salary]
    FROM TutorialAppSchema.UserSalary
UNION ALL
    SELECT [UserId],
        [Salary]
    FROM TutorialAppSchema.UserSalary


-- Add indexs
SELECT [Users].[UserId],
    [Users].[FirstName] + ' ' + [Users].[LastName] AS FullName,
    -- [UserJobInfo].[UserId]  [UserJobInfo].[UserId] is equal with [Users].[UserId] so no need to display ,
    [UserJobInfo].[JobTitle],
    [UserJobInfo].[Department],
    [UserSalary].[Salary],
    [Users].[Email],
    [Users].[Gender],
    [Users].[Active]
FROM TutorialAppSchema.Users AS Users
    JOIN TutorialAppSchema.UserSalary AS UserSalary
    ON UserSalary.UserId = Users.UserId
    LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
    ON UserJobInfo.UserId = Users.UserId
WHERE Users.Active = 1
ORDER BY Users.UserId DESC


-- -- A "CLUSTERED INDEX"  the nameing convetion is cix_. It's going to take all the records that are inside of tis table and it's going to physically order them by that field. So, the way that this is actually going to be stored now the way the physical files and pages that this data lives inside, are going to be stored is in the order of this ID and even within those pages each row inside of a page, is going to be stored by this UserId
CREATE CLUSTERED INDEX cix_UserSalary_UserId ON TutorialAppSchema.UserSalary(UserId)


-- -- "CREATE INDEX" it is the same as "CREATE NONCLUSTERED IDEX" the nameing convetion is ix_ instead of cix_. "CREATE NONCLUSTERED IDEX" create a listing that tell us where to look for a specific salary in a page. So it'll tell us what page are row is on to look at and it'll give us a new listing of just the salary in order and it will also include are clustered index. So if we wanted to include other fields we would "INCLUDE" and the field we want to add "(Department)"
CREATE NONCLUSTERED INDEX ix_UserJobTitle ON TutorialAppSchema.UserJobInfo(JobTitle) INCLUDE (Department)


-- -- "FILTER" INDEX

-- -- Users table has a primary key of UserId and when we set a primary key, it becomes are clusted index automatically
-- Also Includes UserId because it is clustered Index 

CREATE NONCLUSTERED INDEX fix_User_Active ON TutorialAppSchema.Users(Active) INCLUDE ([FirstName], [LastName], [Email])
        WHERE Active = 1



SELECT
    ISNULL([UserJobInfo].[Department], 'No Department Listed') AS Deparment,
    SUM([UserSalary].[Salary]) AS Salary,
    MIN([UserSalary].[Salary]) AS MinSalary,
    MAX([UserSalary].[Salary]) AS MaxSalary,
    AVG([UserSalary].[Salary]) AS AvgSalary,
    COUNT(*) AS PeopleInDepartement,
    STRING_AGG(Users.UserId, ', ') AS UserIds
FROM TutorialAppSchema.Users AS Users
    JOIN TutorialAppSchema.UserSalary AS UserSalary
    ON UserSalary.UserId = Users.UserId
    LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
    ON UserJobInfo.UserId = Users.UserId
WHERE Users.Active = 1
GROUP BY [UserJobInfo].[Department]
ORDER BY ISNULL([UserJobInfo].[Department], 'No Department Listed') DESC


-- OUTER APPLY
SELECT [Users].[UserId],
    [Users].[FirstName] + ' ' + [Users].[LastName] AS FullName,
    -- [UserJobInfo].[UserId]  [UserJobInfo].[UserId] is equal with [Users].[UserId] so no need to display ,
    [UserJobInfo].[JobTitle],
    [UserJobInfo].[Department],
    DepartmentAverage.AvgSalary,
    [UserSalary].[Salary],
    [Users].[Email],
    [Users].[Gender],
    [Users].[Active]
FROM TutorialAppSchema.Users AS Users
    JOIN TutorialAppSchema.UserSalary AS UserSalary
    ON UserSalary.UserId = Users.UserId
    LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
    ON UserJobInfo.UserId = Users.UserId  
            OUTER APPLY (
                -- SELECT TOP 1
                SELECT
        ISNULL([UserJobInfo2].[Department], 'No Department Listed') AS Deparment,
        AVG([UserSalary2].[Salary]) AS AvgSalary
    FROM TutorialAppSchema.UserSalary AS UserSalary2
        LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo2
        ON UserJobInfo2.UserId = UserSalary2.UserId
    WHERE ISNULL([UserJobInfo2].[Department], 'No Department Listed') = ISNULL([UserJobInfo].[Department], 'No Department Listed')
    GROUP BY [UserJobInfo2].[Department]
            ) AS DepartmentAverage
WHERE Users.Active = 1
ORDER BY Users.UserId DESC


-- OUTER APPLY when some records don't exists
SELECT [Users].[UserId],
    [Users].[FirstName] + ' ' + [Users].[LastName] AS FullName,
    [UserJobInfo].[JobTitle],
    [UserJobInfo].[Department],
    DepartmentAverage.AvgSalary,
    [UserSalary].[Salary],
    [Users].[Email],
    [Users].[Gender],
    [Users].[Active]
FROM TutorialAppSchema.Users AS Users
    JOIN TutorialAppSchema.UserSalary AS UserSalary
    ON UserSalary.UserId = Users.UserId
    LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
    ON UserJobInfo.UserId = Users.UserId  
            -- OUTER APPLY (-- Similar to LEFT JOIN
            CROSS APPLY (
                -- SELECT TOP 1
                SELECT
        ISNULL([UserJobInfo2].[Department], 'No Department Listed') AS Deparment,
        AVG([UserSalary2].[Salary]) AS AvgSalary
    FROM TutorialAppSchema.UserSalary AS UserSalary2
        LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo2
        ON UserJobInfo2.UserId = UserSalary2.UserId
    WHERE [UserJobInfo2].[Department] = [UserJobInfo].[Department]
    GROUP BY [UserJobInfo2].[Department]
            ) AS DepartmentAverage
WHERE Users.Active = 1
-- AND DepartmentAverage.AvgSalary IS NOT NULL 
ORDER BY Users.UserId DESC


-- DATE and DATETIMES
SELECT GETDATE()

-- DATEADD is going to add some value(YEAR, MOUNTH, WEEK, ect), and after a number, the value can be negative, and then the day it's being added to
SELECT DATEADD(YEAR, -5, GETDATE())

SELECT DATEDIFF(MINUTE, DATEADD(YEAR, -5, GETDATE()),  GETDATE())
-- Returns Positive
SELECT DATEDIFF(MINUTE, GETDATE(), DATEADD(YEAR, -5, GETDATE()))
-- Returns Negative




ALTER TABLE TutorialAppSchema.UserSalary ADD AvgSalary DECIMAL(18,4)
GO

SELECT *
FROM TutorialAppSchema.UserSalary

UPDATE UserSalary 
    SET UserSalary.AvgSalary = DepartmentAverage.AvgSalary
    FROM TutorialAppSchema.UserSalary AS UserSalary
    LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
    ON UserJobInfo.UserId = UserSalary.UserId 
      CROSS APPLY (
                SELECT
        ISNULL([UserJobInfo2].[Department], 'No Department Listed') AS Deparment,
        AVG([UserSalary2].[Salary]) AS AvgSalary
    FROM TutorialAppSchema.UserSalary AS UserSalary2
        LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo2
        ON UserJobInfo2.UserId = UserSalary2.UserId
    WHERE ISNULL([UserJobInfo2].[Department], 'No Department Listed') =  ISNULL([UserJobInfo].[Department], 'No Department Listed')
    GROUP BY [UserJobInfo2].[Department]
            ) AS DepartmentAverage


