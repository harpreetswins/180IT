
/****** Object:  StoredProcedure [dbo].[sp_AdminGetStageForms]    Script Date: 22-01-2021 19:40:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE PROCEDURE [dbo].[sp_AdminGetStageForms] 
AS  
BEGIN  
DECLARE @formTranslationKeyId INT= 2;    
        SELECT Id,     
               Name,     
               dbo.fn_multiLingualName(Id, @formTranslationKeyId) AS FormName    
        FROM service.Forms sf    

  END