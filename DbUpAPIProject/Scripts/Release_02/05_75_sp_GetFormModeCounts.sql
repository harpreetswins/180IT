-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- sp_GetFormModeCounts '09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0','Sanjay','OtherApplications','NAD Program Manager'  
-- =============================================  
CREATE PROCEDURE sp_GetFormModeCounts @userId      NVARCHAR(100), 
                                     @creatorName NVARCHAR(100), 
                                     @mode        NVARCHAR(50), 
                                     @role AS        NVARCHAR(100)
AS
    BEGIN
        DECLARE @RowCount AS INT;
        DECLARE @uId INT;
        EXEC @uId = sp_GetUserId 
             @userId, 
             @creatorName;
        IF @mode = 'MyApplications'
            SET @RowCount =
            (
                SELECT SUM(StatusCount)
                FROM dbo.fn_MyApplicationCategories(@uId)
            );
        IF @mode = 'OtherApplications'
            SET @RowCount =
            (
                SELECT SUM(StatusCount)
                FROM dbo.fn_OtherApplicationCategories(@uId, @role) AS ApplicationCategories
            );
        IF @mode = 'AssignedToMe'
            SET @RowCount =
            (
                SELECT SUM(StatusCount)
                FROM dbo.fn_AssignedToMeApplicationCategories(@uId) AS ApplicationCategories
            );
        IF @mode = 'MyTasks'
            SET @RowCount =
            (
                SELECT SUM(StatusCount)
                FROM dbo.fn_MyTasksApplicationCategories(@uId, @role) AS ApplicationCategories
            );
        SELECT @RowCount AS COUNT;
    END;