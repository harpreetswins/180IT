
/****** Object:  StoredProcedure [dbo].[sp_GetFormModeCounts]    Script Date: 11-02-2021 20:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- sp_GetFormModeCounts '09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0','Sanjay','NAD Program Manager'    
-- =============================================    
ALTER PROCEDURE [dbo].[sp_GetFormModeCounts] @userId      NVARCHAR(100),   
                                     @creatorName NVARCHAR(100),    
                                     @role AS        NVARCHAR(100)  
AS  
    BEGIN  
        DECLARE @RowCount AS INT, @FormModeCounts AS NVARCHAR(MAX);  
        DECLARE @uId INT;  
        EXEC @uId = sp_GetUserId   
             @userId,   
             @creatorName; 
		
		DECLARE @FormModeTable TABLE (
		FormMode VARCHAR(50),
		Count INT
		)
		INSERT INTO @FormModeTable
		VALUES(
		'MyApplications',
		(  
                SELECT SUM(StatusCount)  
                FROM dbo.fn_MyApplicationCategories(@uId)  
            ) 
		)
		INSERT INTO @FormModeTable
		VALUES(
		'OtherApplications',
		(  
                SELECT SUM(StatusCount)  
                FROM dbo.fn_OtherApplicationCategories(@uId, @role)  
            ) 
		)	
		INSERT INTO @FormModeTable
		VALUES(
		'AssignedToMe',
		(  
              SELECT SUM(StatusCount)  
                FROM dbo.fn_AssignedToMeApplicationCategories(@uId) 
            ) 
		)	
		INSERT INTO @FormModeTable
		VALUES(
		'MyTasks',
		(  
                SELECT SUM(StatusCount)  
                FROM dbo.fn_MyTasksApplicationCategories(@uId, @role)  
            ) 
		)
	  SET @FormModeCounts =  (SELECT FormMode, ISNULL(Count,0) AS FormModeCounts FROM @FormModeTable FOR JSON PATH )
	  Select @FormModeCounts AS Mode
    END;  