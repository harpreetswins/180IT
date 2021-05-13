
/****** Object:  StoredProcedure [dbo].[sp_GetStageActionTypes]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================                
-- Author:  Neeraj Saini                
-- Create date: 14 Jan,2021                
-- Description: Get action types of service.                
-- =============================================                
ALTER PROCEDURE [dbo].[sp_GetStageActionTypes] @serviceid AS INT  
AS  
    BEGIN  
        SELECT    
               LAT.Id,   
               LAT.Name AS ActionType  
        FROM lookups.ActionTypes LAT  
            
    END;
GO