
/****** Object:  StoredProcedure [dbo].[sp_AdminGetStageForms]    Script Date: 25-01-2021 15:36:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
    
ALTER PROCEDURE [dbo].[sp_AdminGetStageForms]     
AS    
BEGIN    
DECLARE @formTranslationKeyId INT= 2;      
        SELECT Id,       
               Name,       
               dbo.fn_multiLingualName(Id, @formTranslationKeyId) AS FormName      
        FROM service.Forms sf      
        --WHERE Id NOT IN      
        --(      
        --    SELECT FormId      
        --    FROM service.stageforms      
        --    WHERE stageid = @stageid      
        --);      
  END