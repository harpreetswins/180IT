
/****** Object:  StoredProcedure [dbo].[sp_GetEntityFieldLookups]    Script Date: 11-02-2021 11:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetEntityFieldLookups 7, 1, null    
    
ALTER PROCEDURE [dbo].[sp_GetEntityFieldLookups] @formid AS     INT,                       
                                                  @languageid AS INT                      
              ,@serviceid AS INT                      
AS                      
    BEGIN                   
 DECLARE @lookupTranslationKeyId INT = 8, @systemLookupTranslationKeyId INT = 18;            
      SELECT DISTINCT SFSF.EntityFieldId,                       
               SFSF.FormSectionId,                       
               SEF.FieldTypeId,                       
               SFT.Name AS FieldTypeName,                       
    ( CASE WHEN SEF.Settings IS NULL THEN               
      (SELECT LEFL.Value AS lookupId,                  
                   STS.Value AS lookupValue,                       
                   STS.ItemId AS LookupTranslationId,              
       LEFL.EntityFieldId AS EntityFieldId                      
                  
      FROM service.EntityFieldLookups LEFL                   
      INNER JOIN [dbo].[vw_Translations] STS  ON STS.ItemId =  LEFL.id                  
      INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId                    
     WHERE STS.ItemId = LEFL.id AND STK.Id = @lookupTranslationKeyId AND STS.LanguageId = @languageid AND LEFL.EntityFieldId = SFSF.EntityFieldId                  
    AND LEFL.ParentId Is NULL      
  FOR JSON PATH)                     
              
  ELSE      
   (SELECT SLV.Id AS lookupId,        
       STS.Value AS lookupValue,                
                   SLV.Name AS lookupFieldValue,                       
                   STS.ItemId AS LookupTranslationId,              
       SEF.Id AS EntityFieldId        
      FROM system.LookupValues SLV                   
      INNER JOIN [dbo].[vw_Translations] STS ON STS.ItemId = SLV.id                  
      INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId                    
     WHERE STK.Id = @systemLookupTranslationKeyId AND SLV.ParentId IS NULL AND STS.LanguageId = @languageid AND SLV.LookupTypeId =  (select CAST(JSON_VALUE(Settings, '$.lookupTypeId') AS INT) from service.EntityFields where id = SFSF.EntityFieldId)     
     FOR JSON PATH)                     
              
  END ) AS entityData                 
        FROM service.Forms SF                      
             INNER JOIN service.FormSections SFS ON SFS.FormId = SF.id                      
             INNER JOIN service.FormSectionFields SFSF ON SFSF.FormSectionId = SFS.Id                      
             INNER JOIN service.EntityFields SEF ON SEF.id = SFSF.EntityFieldId                      
             INNER JOIN lookups.FieldTypes SFT ON SFT.Id = SEF.FieldTypeId             
            LEFT JOIN service.EntityFieldLookups LEFLS ON LEFLS.EntityFieldId = SFSF.EntityFieldId AND LEFLS.ParentId Is NULL                   
        WHERE SF.Id = @formid                     
    END;  