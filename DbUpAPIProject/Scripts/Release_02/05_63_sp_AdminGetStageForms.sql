
/****** Object:  StoredProcedure [admin].[sp_AdminGetStageForms]    Script Date: 09-02-2021 15:23:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- [admin].[sp_AdminGetStageForms] 
ALTER PROCEDURE [admin].[sp_AdminGetStageForms]     
AS    
BEGIN    
DECLARE @formTranslationKeyId INT= 2;      
        SELECT Id,       
               Name,       
               dbo.fn_multiLingualName(Id, @formTranslationKeyId) AS FormName,
			   (SELECT Id, Name FROM [lookups].[FormModes] FOR JSON PATH) AS FormMode
        FROM service.Forms sf      
        --WHERE Id NOT IN      
        --(      
        --    SELECT FormId      
        --    FROM service.stageforms      
        --    WHERE stageid = @stageid      
        --);      
  END
