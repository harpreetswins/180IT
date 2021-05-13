
/****** Object:  StoredProcedure [admin].[sp_AdminGetFormSectionsByFormId]    Script Date: 03-02-2021 15:11:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [admin].[sp_AdminGetFormSectionsByFormId]   @formid INT    
AS      
BEGIN      
DECLARE @formsectionTranslationKeyId INT= 3;        
        SELECT Id,         
               Name,         
               dbo.fn_multiLingualName(Id, @formsectionTranslationKeyId) AS FormSectionName        
        FROM service.FormSections sf  Where sf.FormId = @formid       
               
  END