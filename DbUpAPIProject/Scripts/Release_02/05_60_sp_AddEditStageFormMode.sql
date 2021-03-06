
/****** Object:  StoredProcedure [admin].[sp_AddEditStageFormMode]    Script Date: 09-02-2021 16:01:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
CREATE PROCEDURE [admin].[sp_AddEditStageFormMode] @stageid INT,    
              @formid INT,
			  @formmodeid INT    
AS    
BEGIN    
    
 BEGIN TRY    
  BEGIN TRAN    
    
	IF EXISTS(select 1 from service.StageForms Where StageId = @stageid AND FormId = @formid)
	BEGIN
	Update service.StageForms SET FormModeId = @formmodeid Where StageId = @stageid AND FormId = @formid
	END 
                  
        
    SELECT @stageid AS Id,       
                           200 AS STATUS,       
                           'Success' AS Message;      
    
  COMMIT TRANSACTION    
 END TRY    
  BEGIN CATCH        
            SELECT @stageid AS Id,         
                   500 AS STATUS,         
                   ERROR_MESSAGE() AS Message;        
            ROLLBACK TRANSACTION;        
        END CATCH;        
END    