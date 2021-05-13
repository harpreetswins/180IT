
/****** Object:  StoredProcedure [dbo].[sp_AdminDeleteStageActions]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- exec sp_AdminDeleteStageActions   
-- =============================================  
ALTER PROCEDURE [dbo].[sp_AdminDeleteStageActions] @stageactionid AS INT
AS  
    BEGIN  
	BEGIN TRY
	BEGIN TRAN
     Delete From service.StageActionRoles
	  where StageActionId = @stageactionid

	  Delete from service.StageActions Where Id = @stageactionid

	   SELECT @stageactionid AS Id,     
                           200 AS STATUS,     
                           'Success' AS Message;    
                
            COMMIT TRANSACTION;    
        END TRY    
        BEGIN CATCH    
            ROLLBACK TRANSACTION;    
            SELECT @stageactionid AS Id,     
                   500 AS STATUS,     
                   ERROR_MESSAGE() AS Message;    
        END CATCH; 
    END;
GO